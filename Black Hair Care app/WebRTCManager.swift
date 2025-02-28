import Foundation
import WebRTC

class WebRTCManager: NSObject, ObservableObject {
    private var peerConnection: RTCPeerConnection?
    private let config = RTCConfiguration()
    private let mediaConstraints = RTCMediaConstraints(
        mandatoryConstraints: [
            "OfferToReceiveAudio": "true",
            "OfferToReceiveVideo": "true"
        ],
        optionalConstraints: nil
    )
    private var webSocket: URLSessionWebSocketTask?
    private let factory = RTCPeerConnectionFactory() // Create an instance of RTCPeerConnectionFactory
    
    @Published var remoteVideoURL: URL?
    
    override init() {
        super.init()
        setupWebSocket()
        setupPeerConnection()
    }
    
    private func setupWebSocket() {
        let url = URL(string: "ws://localhost:8080")!
        webSocket = URLSession.shared.webSocketTask(with: url)
        webSocket?.resume()
        receiveMessage()
    }
    
    private func receiveMessage() {
        webSocket?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                print("WebSocket receiving error: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    self?.handleSignalingMessage(text)
                case .data(let data):
                    print("Received binary message: \(data)")
                @unknown default:
                    fatalError()
                }
                self?.receiveMessage()
            }
        }
    }
    
    private func handleSignalingMessage(_ message: String) {
        if message.contains("sdp") {
            handleSDP(message)
        } else if message.contains("candidate") {
            handleICECandidate(message)
        }
    }
    
    private func handleSDP(_ message: String) {
        guard let peerConnection = peerConnection else { return }
        
        do {
            let jsonData = message.data(using: .utf8)!
            let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
            let sdp = json["sdp"] as! String
            let type = json["type"] as! String
            
            let sessionDescription = RTCSessionDescription(type: type == "offer" ? .offer : .answer, sdp: sdp)
            
            peerConnection.setRemoteDescription(sessionDescription) { error in
                if let error = error {
                    print("Error setting remote description: \(error)")
                } else {
                    print("Successfully set remote description")
                    if sessionDescription.type == .offer {
                        self.createAnswer()
                    }
                }
            }
        } catch {
            print("Error parsing SDP: \(error)")
        }
    }
    
    private func handleICECandidate(_ message: String) {
        guard let peerConnection = peerConnection else { return }
        
        let candidateParts = message.components(separatedBy: ":")
        guard candidateParts.count > 1 else { return }
        
        let candidate = RTCIceCandidate(
            sdp: candidateParts[1],
            sdpMLineIndex: Int32(candidateParts[2])!,
            sdpMid: candidateParts[3]
        )
        
        peerConnection.add(candidate) { error in
            if let error = error {
                print("Error adding ICE candidate: \(error)")
            } else {
                print("Successfully added ICE candidate")
            }
        }
    }
    
    private func setupPeerConnection() {
        let config = RTCConfiguration()
        config.iceServers = [RTCIceServer(urlStrings: ["stun:stun.l.google.com:19302"])]
        
        let constraints = RTCMediaConstraints(
            mandatoryConstraints: [
                "OfferToReceiveAudio": "true",
                "OfferToReceiveVideo": "true"
            ],
            optionalConstraints: nil
        )
        
        peerConnection = factory.peerConnection(with: config, constraints: constraints, delegate: self)
    }
    
    func createOffer() {
        guard let peerConnection = peerConnection else {
            print("PeerConnection is not initialized")
            return
        }
        
        peerConnection.offer(for: mediaConstraints) { [weak self] (sdp, error) in
            guard let sdp = sdp else {
                if let error = error {
                    print("Error creating offer: \(error)")
                }
                return
            }
            
            self?.peerConnection?.setLocalDescription(sdp) { error in
                if let error = error {
                    print("Error setting local description: \(error)")
                } else {
                    print("Successfully set local description")
                    self?.sendSignalingMessage(sdp.sdp)
                }
            }
        }
    }
    
    private func createAnswer() {
        guard let peerConnection = peerConnection else { return }
        
        peerConnection.answer(for: mediaConstraints) { [weak self] (sdp, error) in
            guard let sdp = sdp else { return }
            self?.peerConnection?.setLocalDescription(sdp) { error in
                if let error = error {
                    print("Error setting local description: \(error)")
                } else {
                    print("Successfully set local description")
                    self?.sendSignalingMessage(sdp.sdp)
                }
            }
        }
    }
    
    func sendSignalingMessage(_ message: String) {
        webSocket?.send(.string(message)) { error in
            if let error = error {
                print("WebSocket sending error: \(error)")
            }
        }
    }
}

extension WebRTCManager: RTCPeerConnectionDelegate {
    func peerConnection(_ peerConnection: RTCPeerConnection, didChange stateChanged: RTCSignalingState) {}
    func peerConnection(_ peerConnection: RTCPeerConnection, didAdd stream: RTCMediaStream) {}
    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove stream: RTCMediaStream) {}
    func peerConnectionShouldNegotiate(_ peerConnection: RTCPeerConnection) {}
    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceConnectionState) {}
    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceGatheringState) {}
    func peerConnection(_ peerConnection: RTCPeerConnection, didGenerate candidate: RTCIceCandidate) {
        let message = "candidate:\(candidate.sdp):\(candidate.sdpMLineIndex):\(candidate.sdpMid ?? "")"
        sendSignalingMessage(message)
    }
    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove candidates: [RTCIceCandidate]) {}
    func peerConnection(_ peerConnection: RTCPeerConnection, didOpen dataChannel: RTCDataChannel) {}
}

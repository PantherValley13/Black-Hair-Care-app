import Foundation
import WebRTC
import Combine

class WebRTCManager: NSObject, ObservableObject {
    @Published var isRemoteVideoAvailable: Bool = false

     var rtcpeerConnection: RTCPeerConnection?
    private var localVideoTrack: RTCVideoTrack?
    private let factory = RTCPeerConnectionFactory()
    private var webSocket: URLSessionWebSocketTask?
    private var localRenderer: RTCMTLVideoView?
    private var remoteRenderer: RTCMTLVideoView?

    override init() {
        super.init()
        setupWebSocket()
        setupPeerConnection()
    }

    // MARK: - WebSocket Setup
    private func setupWebSocket() {
        guard let url = URL(string: "ws://localhost:8080") else { return }
        webSocket = URLSession.shared.webSocketTask(with: url)
        webSocket?.resume()
        receiveMessage()
    }

    private func receiveMessage() {
        webSocket?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                print("WebSocket receiving error: \(error)")
                self?.reconnectWebSocket()
            case .success(let message):
                switch message {
                case .string(let text):
                    self?.handleSignalingMessage(text)
                case .data(let data):
                    print("Received binary message: \(data)")
                @unknown default:
                    fatalError()
                }
                self?.receiveMessage() // Keep listening for messages
            }
        }
    }

    private func reconnectWebSocket() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            self.setupWebSocket()
        }
    }

    private func sendSignalingMessage(_ message: [String: Any]) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: message, options: [])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                webSocket?.send(.string(jsonString)) { error in
                    if let error = error {
                        print("WebSocket sending error: \(error)")
                    }
                }
            }
        } catch {
            print("Error encoding signaling message: \(error)")
        }
    }

    // MARK: - Signaling Message Handling
    private func handleSignalingMessage(_ message: String) {
        do {
            let jsonData = message.data(using: .utf8)!
            let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]

            if let type = json["type"] as? String, let sdp = json["sdp"] as? String {
                handleSDP(sdp, type: type)
            } else if json["candidate"] != nil {
                handleICECandidate(json)
            }
        } catch {
            print("Error parsing signaling message: \(error)")
        }
    }

    private func handleSDP(_ sdp: String, type: String) {
        guard let peerConnection = rtcpeerConnection else { return }

        let sdpType: RTCSdpType = (type == "offer") ? .offer : .answer
        let sessionDescription = RTCSessionDescription(type: sdpType, sdp: sdp)

        peerConnection.setRemoteDescription(sessionDescription) { [weak self] error in
            if let error = error {
                print("Error setting remote description: \(error)")
            } else {
                print("Successfully set remote description")
                if sdpType == .offer {
                    self?.createAnswer()
                }
            }
        }
    }

    private func handleICECandidate(_ json: [String: Any]) {
        guard let peerConnection = rtcpeerConnection,
              let candidateString = json["candidate"] as? String,
              let sdpMLineIndex = json["sdpMLineIndex"] as? Int32,
              let sdpMid = json["sdpMid"] as? String else { return }

        let candidate = RTCIceCandidate(sdp: candidateString, sdpMLineIndex: sdpMLineIndex, sdpMid: sdpMid)
        peerConnection.add(candidate) { error in
            if let error = error {
                print("Error adding ICE candidate: \(error)")
            } else {
                print("Successfully added ICE candidate")
            }
        }
    }

    // MARK: - WebRTC Setup
    private func setupPeerConnection() {
        let config = RTCConfiguration()
        config.iceServers = [RTCIceServer(urlStrings: ["stun:stun.l.google.com:19302"])]

        let constraints = RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: nil)
        rtcpeerConnection = factory.peerConnection(with: config, constraints: constraints, delegate: self)

        setupLocalVideoTrack()
    }

    private func setupLocalVideoTrack() {
        let videoSource = factory.videoSource()
        let videoCapturer = RTCCameraVideoCapturer(delegate: videoSource)
        localVideoTrack = factory.videoTrack(with: videoSource, trackId: "localVideo")

        if let camera = RTCCameraVideoCapturer.captureDevices().first,
           let format = RTCCameraVideoCapturer.supportedFormats(for: camera).last {
            let fps = min(format.videoSupportedFrameRateRanges.first?.maxFrameRate ?? 30, 30)
            videoCapturer.startCapture(with: camera, format: format, fps: Int(fps))
        }

        rtcpeerConnection?.add(localVideoTrack!, streamIds: ["stream0"])
    }

    // MARK: - WebRTC Offer/Answer
    func createOffer() {
        rtcpeerConnection?.offer(for: RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: nil)) { [weak self] sdp, error in
            guard let sdp = sdp else { return }
            self?.rtcpeerConnection?.setLocalDescription(sdp) { error in
                if let error = error {
                    print("Error setting local description: \(error)")
                } else {
                    print("Successfully set local description")
                    self?.sendSignalingMessage(["type": "offer", "sdp": sdp.sdp])
                }
            }
        }
    }

    private func createAnswer() {
        rtcpeerConnection?.answer(for: RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: nil)) { [weak self] sdp, error in
            guard let sdp = sdp else { return }
            self?.rtcpeerConnection?.setLocalDescription(sdp) { error in
                if let error = error {
                    print("Error setting local description: \(error)")
                } else {
                    print("Successfully set local description")
                    self?.sendSignalingMessage(["type": "answer", "sdp": sdp.sdp])
                }
            }
        }
    }

    // MARK: - Set Renderers
    func setRenderers(localRenderer: RTCMTLVideoView, remoteRenderer: RTCMTLVideoView) {
        self.localRenderer = localRenderer
        self.remoteRenderer = remoteRenderer

        localVideoTrack?.add(localRenderer)

        rtcpeerConnection?.transceivers.forEach { transceiver in
            if transceiver.mediaType == .video, let track = transceiver.receiver.track as? RTCVideoTrack {
                track.add(remoteRenderer)
                DispatchQueue.main.async {
                    self.isRemoteVideoAvailable = true
                }
            }
        }
    }
}

// MARK: - RTCPeerConnectionDelegate
extension WebRTCManager: RTCPeerConnectionDelegate {
    func peerConnection(_ peerConnection: RTCPeerConnection, didChange stateChanged: RTCSignalingState) {}
    func peerConnection(_ peerConnection: RTCPeerConnection, didAdd stream: RTCMediaStream) {}
    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove stream: RTCMediaStream) {}
    func peerConnectionShouldNegotiate(_ peerConnection: RTCPeerConnection) {}
    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceConnectionState) {}
    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceGatheringState) {}

    func peerConnection(_ peerConnection: RTCPeerConnection, didGenerate candidate: RTCIceCandidate) {
        sendSignalingMessage([
            "candidate": candidate.sdp,
            "sdpMLineIndex": candidate.sdpMLineIndex,
            "sdpMid": candidate.sdpMid ?? ""
        ])
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove candidates: [RTCIceCandidate]) {}
    func peerConnection(_ peerConnection: RTCPeerConnection, didOpen dataChannel: RTCDataChannel) {}
}


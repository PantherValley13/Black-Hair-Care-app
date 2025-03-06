import SwiftUI
import WebRTC

struct VideoView: View {
    @ObservedObject var webRTCManager: WebRTCManager
    @State private var localRenderer = RTCMTLVideoView()
    @State private var remoteRenderer = RTCMTLVideoView()

    var body: some View {
        VStack {
            if webRTCManager.isRemoteVideoAvailable {
                VideoRendererView(renderer: remoteRenderer)
                    .frame(width: 300, height: 200)
                    .background(Color.black)
                    .cornerRadius(12)
            } else {
                Text("Waiting for remote video...")
                    .foregroundColor(.gray)
                    .padding()
            }

            VideoRendererView(renderer: localRenderer)
                .frame(width: 150, height: 100)
                .background(Color.black)
                .cornerRadius(12)
                .padding()

            HStack {
                Button("Start Call") {
                    webRTCManager.createOffer()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)

                Button("End Call") {
                    if let connection = webRTCManager.rtcpeerConnection {
                        connection.close()
                        webRTCManager.rtcpeerConnection = nil // Reset after closing
                    }
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)

                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)

                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)

                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .onAppear {
            webRTCManager.setRenderers(localRenderer: localRenderer, remoteRenderer: remoteRenderer)
        }
    }
}

struct VideoRendererView: UIViewRepresentable {
    let renderer: RTCMTLVideoView

    func makeUIView(context: Context) -> RTCMTLVideoView {
        renderer.videoContentMode = .scaleAspectFill
        return renderer
    }

    func updateUIView(_ uiView: RTCMTLVideoView, context: Context) {}
}

#Preview {
   
}

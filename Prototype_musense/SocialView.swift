import SwiftUI
import WatchKit

struct SocialView: View {
    private let matchDuration: TimeInterval = 5.0

    @State private var isMatching = true
    @State private var elapsed: TimeInterval = 0
    @State private var matched = false

    @State private var peerName: String = "Row 08, Seats 27"

    private var progress: Double { min(elapsed / matchDuration, 1.0) }
    private var remaining: Int { max(Int(ceil(matchDuration - elapsed)), 0) }

    var body: some View {
        Group {
            if !matched {
                VStack(spacing: 8) {
                    Text("Matching…")
                        .font(.headline)

                    ProgressView(value: progress)
                        .progressViewStyle(.circular)
                        .scaleEffect(1.2)

                    Button(isMatching ? "Cancel" : "Retry") {
                        if isMatching {
                            isMatching = false
                        } else {
                            resetAndStart()
                        }
                    }
                    .font(.body.weight(.semibold))
                    .padding(.top, 4)
                }
                .onAppear { resetAndStart() }
                .onDisappear { isMatching = false }
                .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
                    guard isMatching, !matched else { return }
                    elapsed += 0.1
                    if floor(elapsed) == elapsed { WKInterfaceDevice.current().play(.click) }
                    if elapsed >= matchDuration {
                        matched = true
                        isMatching = false
                        WKInterfaceDevice.current().play(.success)
                    }
                }

            } else {
                VStack(spacing: 10) {
                    Image("Image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.white.opacity(0.25), lineWidth: 1))
                        .shadow(radius: 2)

                    Text("Lexi")
                        .font(.headline)

                    Text(peerName)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Button("Done") {
                        matched = false
                        resetAndStart()
                    }
                    .font(.body.weight(.semibold))
                    .padding(.top, 4)
                }
                .transition(.opacity)
            }
        }
    }

    private func resetAndStart() {
        elapsed = 0
        matched = false
        isMatching = true
    }
}



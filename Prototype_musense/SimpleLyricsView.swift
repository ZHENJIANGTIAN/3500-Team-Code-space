import SwiftUI

struct SimpleLyricsView: View {
    struct LyricLine {
        let text: String
        let duration: TimeInterval
    }
    
    @Environment(\.dismiss) private var dismiss
    @State private var currentLyricIndex = 0
    @State private var timer: Timer?
    
    private let lyrics: [LyricLine] = [
        .init(text: "Gravity", duration: 3),
        .init(text: "is working against me", duration: 7),
        .init(text: "And gravity", duration: 5),
        .init(text: "wants to bring me down", duration: 6),
        .init(text: "Oh, I'll never know", duration: 4),
        .init(text: "what makes this man", duration: 3),
        .init(text: "With all the love", duration: 2),
        .init(text: "that his heart can stand", duration: 4),
        .init(text: "Dream of ways to throw it all away", duration: 8),
    ]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Spacer()
                
                Text(lyrics[currentLyricIndex].text)
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .animation(.easeInOut(duration: 0.5), value: currentLyricIndex)
                
                Spacer()
                
                HStack(spacing: 8) {
                    ForEach(0..<lyrics.count, id: \.self) { index in
                        Circle()
                            .fill(index == currentLyricIndex ? Color.white : Color.white.opacity(0.3))
                            .frame(width: 6, height: 6)
                            .animation(.easeInOut(duration: 0.3), value: currentLyricIndex)
                    }
                }
                .padding(.bottom, 30)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            scheduleNextTick()
        }
        .onDisappear {
            stopLyricTimer()
        }
        .onTapGesture {
            dismiss()
        }
    }
    
    private func scheduleNextTick() {
        stopLyricTimer()
        let interval = max(0.1, lyrics[currentLyricIndex].duration)
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
            withAnimation {
                if currentLyricIndex < lyrics.count - 1 {
                    currentLyricIndex += 1
                } else {
                    currentLyricIndex = 0
                }
            }
            scheduleNextTick()
        }
    }
    
    private func stopLyricTimer() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    SimpleLyricsView()
}


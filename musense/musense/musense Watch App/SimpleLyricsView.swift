import SwiftUI

struct SimpleLyricsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var currentLyricIndex = 0
    @State private var timer: Timer?
    
    // lyrics data
    private let lyrics = [
        "Gravity is working against me",
        "And gravity wants to bring me down",
        "Oh, I'll never know what makes this man",
        "With all the love that his heart can stand",
        "Dream of ways to throw it all away",
        "Gravity is working against me",
        "And gravity wants to bring me down",
        "Oh, twice as much ain't twice as good",
        "And can't sustain like one half could",
        "It's wanting more that's gonna send me to my knees"
    ]
    
    var body: some View {
        ZStack {
            // background
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // lyrics container
                Text(lyrics[currentLyricIndex])
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .animation(.easeInOut(duration: 0.5), value: currentLyricIndex)
                
                Spacer()
                
                // progress
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
            startLyricTimer()
        }
        .onDisappear {
            stopLyricTimer()
        }
        .onTapGesture {
            dismiss()
        }
    }
    
    // lyrics timer
    private func startLyricTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            withAnimation {
                if currentLyricIndex < lyrics.count - 1 {
                    currentLyricIndex += 1
                } else {
                    // start or end the loop
                    currentLyricIndex = 0 // loop
                }
            }
        }
    }
    
    // stop timer
    private func stopLyricTimer() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    SimpleLyricsView()
}

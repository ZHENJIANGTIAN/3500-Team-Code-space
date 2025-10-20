import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                
                Text("Musense")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom, -5)
                
                NavigationLink(destination: FirstPageView()) {
                    HStack {
                        Image(systemName: "music.note")
                            .foregroundColor(.white)
                        Text("Lyrics Subtitle")
                            .font(.body)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: SecondPageView()) {
                    HStack {
                        Image(systemName: "swatchpalette.fill")
                            .foregroundColor(.white)
                        Text("Colour Change")
                            .font(.body)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: SocialView()) {
                    HStack {
                        Image(systemName: "party.popper.fill")
                            .foregroundColor(.white)
                        Text("Social Mode")
                            .font(.body)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.pink)
                    .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

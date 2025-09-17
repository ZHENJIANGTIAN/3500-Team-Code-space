import SwiftUI

struct FirstPageView: View {
    @State private var showPlaylist = false
    
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            
            // center content
            Image(systemName: "music.note.list")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("John Mayer - Solo Tour")
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            // check playlist button
            Button(action: {
                showPlaylist = true
            }) {
                HStack {
                    Image(systemName: "play.fill")
                    Text("View Playlist")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showPlaylist) {
            PlaylistView()
        }
    }
}

#Preview {
    FirstPageView()
}

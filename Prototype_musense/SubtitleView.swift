import SwiftUI

struct FirstPageView: View {
    @State private var showPlaylist = false
    
    var body: some View {
        VStack(spacing: 5) {
            Spacer()
            
            Image(systemName: "music.note.list")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("John Mayer")
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Spacer()
            
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

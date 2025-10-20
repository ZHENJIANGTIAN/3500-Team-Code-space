import SwiftUI

struct PlaylistView: View {
    @State private var showSongDetail = false

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 12) {
                    PlayableRowView {
                        showSongDetail = true
                    }

                    ForEach(1..<5) { index in
                        DisabledRowView(songIndex: index)
                    }
                }
                .padding(.horizontal, 8)
                .padding(.top, 4)
            }

            .navigationDestination(isPresented: $showSongDetail) {
                SimpleLyricsView()
            }

        }
    }
}

struct PlayableRowView: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            SongRowContent(
                title: "Gravity",
                artist: "John Mayer",
                iconColor: .blue,
                textColor: .primary,
                showChevron: true
            )
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct DisabledRowView: View {
    let songIndex: Int

    var body: some View {
        SongRowContent(
            title: "Song \(songIndex + 1)",
            artist: "John Mayer",
            iconColor: .gray,
            textColor: .gray,
            showChevron: false
        )
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.gray.opacity(0.05))
        .cornerRadius(8)
        .opacity(0.6)
    }
}

struct SongRowContent: View {
    let title: String
    let artist: String
    let iconColor: Color
    let textColor: Color
    let showChevron: Bool

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "music.note")
                .foregroundColor(iconColor)
                .font(.body)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(textColor)
                    .lineLimit(1)
                Text(artist)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }

            Spacer()

            if showChevron {
                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    PlaylistView()
}


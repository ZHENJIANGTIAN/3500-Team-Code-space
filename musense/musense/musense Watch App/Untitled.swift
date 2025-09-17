import SwiftUI

struct SecondPageView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "heart.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.red)
            
            Text("this is empty")
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Text("other functions")
                .font(.caption)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .padding()
        .navigationTitle("empty")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SecondPageView()
}

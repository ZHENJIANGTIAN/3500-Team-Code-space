//
//  ContentView.swift
//  concertgo Watch App
//
//  Created by Yu Zhang on 16/9/2025.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                
                // app name
                Text("Musense")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom, 0)
                
                // lyrics nav button
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
                
                // colour nav button
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
                
                // social nav button
                NavigationLink(destination: SecondPageView()) {
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

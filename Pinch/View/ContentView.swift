//
//  ContentView.swift
//  Pinch
//
//  Created by Ashwani Kumar on 02/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var isAnimating = false
    @State private var imageScale: CGFloat = 1
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("magazine-front-cover")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .white.opacity(0.5), radius: 12, x: 2, y: 10)
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(imageScale)
                    .onTapGesture(count: 2) {
                        withAnimation(.spring()) {
                            imageScale = imageScale == 1 ? 5 : 1
                        }
                    }
                
            }//: ZSTACK
            .navigationTitle("Zoom & Pich")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                withAnimation(.linear(duration: 2)) {
                    isAnimating = true
                }
            }
        } //: NavigationView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

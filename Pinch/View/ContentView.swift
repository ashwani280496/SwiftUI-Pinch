//
//  ContentView.swift
//  Pinch
//
//  Created by Ashwani Kumar on 02/10/22.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @State private var isAnimating = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset = CGSize.zero
    
    // MARK: - Functions
    
    private func resetImageState() {
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    
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
                    .offset(imageOffset)
                    .scaleEffect(imageScale)
                    .onTapGesture(count: 2) {
                        withAnimation(.spring()) {
                            if imageScale == 1 {
                                imageScale = 5
                            } else {
                                resetImageState()
                            }
                        }
                    }
                    .gesture(
                        
                        DragGesture()
                            .onChanged { gesture in
                                withAnimation(.linear(duration: 1)){
                                    imageOffset = gesture.translation
                                }
                            }
                            .onEnded { gesture in
                                if imageScale <= 1{
                                    resetImageState()
                                }
                            }
                    )
                
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

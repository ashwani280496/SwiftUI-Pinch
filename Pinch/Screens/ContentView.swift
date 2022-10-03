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
                Color.clear
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
                    .gesture(
                    MagnificationGesture()
                        .onChanged({ value in
                            withAnimation(.linear(duration: 1)) {
                                imageScale = value
                            }
                        })
                    )
                
            }//: ZSTACK
            .navigationTitle("Zoom & Pich")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                withAnimation(.linear(duration: 2)) {
                    isAnimating = true
                }
            }
            .overlay(
                InfoPanelVew(scale: imageScale, offset: imageOffset),
                alignment: .top
            )
            // MARK: - CONTROLLS
            .overlay(
                Group {
                    HStack {
                        Button {
                            if imageScale > 1 {
                                withAnimation(.spring()) {
                                    imageScale -= 1
                                }
                                if imageScale == 1 {
                                    resetImageState()
                                }
                            }
                            
                        } label: {
                            ControllImageView(icon: "minus.magnifyingglass")
                        }
                        
                        Button {
                            resetImageState()
                            
                        } label: {
                            ControllImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        
                        Button {
                            if imageScale < 5{
                                withAnimation(.spring()) {
                                    imageScale += 1
                                }
                            }
                        } label: {
                            ControllImageView(icon: "plus.magnifyingglass")
                        }
                    }
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.thinMaterial)
                    .cornerRadius(10)
                    .opacity(isAnimating ? 1 : 0)
                }.padding(30)
                ,
                alignment: .bottom
            )
        } //: NavigationView
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

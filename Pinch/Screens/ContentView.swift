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
    @State private var isDrawerOpened = false
    
    private let pages = pageData
    
    @State private var selectedPageIndex = 1
    
    
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
                Image(pageData[selectedPageIndex - 1].imageName)
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
                                imageScale = (1...5).contains(imageScale) ? value : 5
                            }
                        })
                    )
                
            } //: ZSTACK
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
            .overlay(
                HStack(spacing: 12){
                    Image(systemName: "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .padding(8)
                        .foregroundColor(.secondary)
                        .onTapGesture {
                            withAnimation {
                                isDrawerOpened.toggle()
                            }
                        }
                    
                    ForEach(pages) { page in
                        Image(page.thumnail)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                            .opacity(isDrawerOpened ? 1 : 0)
                            .animation(.easeOut(duration: 2), value: isDrawerOpened)
                            .onTapGesture {
                               isAnimating = true
                                selectedPageIndex = page.id
                            }
                    }
                    Spacer()
                }
                    .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .padding(.top, UIScreen.main.bounds.height / 12)
                    .frame(width: 250)
                    .offset(x: isDrawerOpened ? 20 : 215)
                   
                ,
                alignment: .topTrailing
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

//
//  InfoPanelVew.swift
//  Pinch
//
//  Created by Ashwani Kumar on 02/10/22.
//

import SwiftUI

struct InfoPanelVew: View {
    // MARK: - PROPERTIES
    var scale: CGFloat
    var offset: CGSize
    
    @State private var isInfoPanelVisible = false
    
    
    var body: some View {
        HStack {
            // MARK: - HOTSPOT
            Image(systemName: "circle.circle")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .padding(.horizontal)
                .onLongPressGesture(minimumDuration: 1) {
                    withAnimation(.easeOut(duration: 2)) {
                        self.isInfoPanelVisible.toggle()
                    }
                }
            
            Spacer()
            
            // MARK: - INFO CONTAINER
            
            HStack(spacing: 2) {
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text("\(scale)")
                
                Spacer()
                
                Image(systemName: "arrow.left.and.right")
                Text("\(offset.width)")
                
                Spacer()
                
                Image(systemName: "arrow.up.and.down")
                Text("\(offset.height)")
                
                Spacer()
            }
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .frame(maxWidth: 420)
            .opacity(isInfoPanelVisible ? 1 : 0)
            
            Spacer()
            
        }//: HSTACK
    }
}

struct InfoPanelVew_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanelVew(scale: 1, offset: .zero)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}

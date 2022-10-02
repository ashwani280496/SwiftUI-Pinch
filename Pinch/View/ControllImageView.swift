//
//  ControllImageView.swift
//  Pinch
//
//  Created by Ashwani Kumar on 02/10/22.
//

import SwiftUI

struct ControllImageView: View {
    var icon: String
    var body: some View {
       Image(systemName: icon)
            .font(.system(size: 36))
    }
}

struct ControllImageView_Previews: PreviewProvider {
    static var previews: some View {
        ControllImageView(icon: "minus.magnifyingglass")
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding(30)
    }
}

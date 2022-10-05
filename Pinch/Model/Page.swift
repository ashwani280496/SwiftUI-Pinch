//
//  Page.swift
//  Pinch
//
//  Created by Ashwani Kumar on 05/10/22.
//

import Foundation

struct Page: Identifiable {
    var id: Int
    var imageName: String
}

extension Page {
    var thumnail: String {
        "thumb-\(imageName)"
    }
}

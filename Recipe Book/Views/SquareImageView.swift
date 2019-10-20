//
//  SquareImageView.swift
//  Recipe Book
//
//  Created by Jonas Frey on 10.10.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import SwiftUI

/// Represents a view that displays an image cut to a square with rounded corners.
/// The image scales to fill the bounds.
struct SquareImageView: View {
    
    @Binding var image: UIImage?
    let defaultSystemImage: String
    static let cornerRadius: CGFloat = 15.0
    
    var body: some View {
        GeometryReader { geometry in
            Image(uiImage: self.image, defaultSystemImage: self.defaultSystemImage)
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width)
        }
        .clipped()
        .cornerRadius(Self.cornerRadius)
        .shadow(radius: 5)
        .aspectRatio(1.0, contentMode: .fit)
    }
}

struct SquareImageView_Previews: PreviewProvider {
    static var previews: some View {
        SquareImageView(image: .constant(Placeholder.sampleRecipes.first!.image!), defaultSystemImage: "doc.text")
            .padding()
    }
}

//
//  SquareImageView.swift
//  Recipe Book
//
//  Created by Jonas Frey on 10.10.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import SwiftUI

struct SquareImageView: View {
    
    var image: UIImage
    
    var body: some View {
        GeometryReader { geometry in
            Image(uiImage: self.image)
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width)
        }
        .clipped()
        .cornerRadius(15.0)
        .shadow(radius: 5)
        .aspectRatio(1.0, contentMode: .fit)
    }
}

struct SquareImageView_Previews: PreviewProvider {
    static var previews: some View {
        SquareImageView(image: Placeholder.sampleRecipes.first!.image!).padding()
    }
}

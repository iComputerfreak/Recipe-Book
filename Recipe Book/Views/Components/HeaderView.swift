//
//  HeaderView.swift
//  Recipe Book
//
//  Created by Jonas Frey on 09.10.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import SwiftUI

/// Represents a horizontally centered static header text
struct HeaderView: View {
    
    let header: String
    
    init(_ header: String) {
        self.header = header
    }
    
    var body: some View {
        HStack {
            Spacer()
            Text(header.uppercased())
                .bold()
                .font(.title)
            Spacer()
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView("Ingredients")
    }
}

//
//  StepsView.swift
//  Recipe Book
//
//  Created by Jonas Frey on 09.10.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import SwiftUI

struct StepsView: View {
    
    var steps: [String]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HeaderView("Steps")
            Divider()
            VStack(alignment: .leading, spacing: 5) {
                // Steps
                ForEach(0..<self.steps.count) { i in
                    HStack(alignment: .top) {
                        Text("\(i + 1)")
                            .font(.title)
                            .bold()
                            .underline()
                            .foregroundColor(Color("Step Color"))
                            .frame(width: 60, height: 35, alignment: .trailing)
                        HStack {
                            Text(self.steps[i])
                                .padding(8)
                                .frame(minHeight: 35)
                            // Expand the background to the whole width
                            Spacer()
                        }
                        .background(Color(white: 0.9))
                        .cornerRadius(5)
                    }
                }
            }
        }
    }
}

struct StepsView_Previews: PreviewProvider {
    static var previews: some View {
        StepsView(steps: Placeholder.sampleRecipes.first!.steps)
            .previewLayout(.fixed(width: 400, height: 600))
    }
}

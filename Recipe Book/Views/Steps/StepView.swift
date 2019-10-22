//
//  StepView.swift
//  Recipe Book
//
//  Created by Jonas Frey on 22.10.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import SwiftUI

struct StepView: View {
    
    @State var index: Int
    @Binding var description: String
    
    var body: some View {
        HStack {
            // Step Number
            VStack {
            Text("\(index + 1)")
                .font(.title)
                .bold()
                .underline()
                .foregroundColor(Color("StepColor"))
                .frame(width: 60, height: 35, alignment: .trailing)
                Spacer()
            }
            // Description
            HStack {
                Text(description)
                    .padding(8)
                    .frame(minHeight: 35)
                // Expand the background to the whole width
                Spacer()
            }
            .background(Color("ListBackground"))
            .cornerRadius(5)
        }
    }
}

struct StepView_Previews: PreviewProvider {
    static var previews: some View {
        StepView(index: 0, description: .constant("Lorem ipsum"))
    }
}

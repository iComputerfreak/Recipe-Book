//
//  StepView.swift
//  Recipe Book
//
//  Created by Jonas Frey on 22.10.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import SwiftUI

struct StepEditingView: View {
    
    @Binding var description: String
        
    var body: some View {
        // TODO: Replace TextView with TextField.lineLimit(), after it has been fixed, or TextView been implemented
        //        TextField("", text: self.$steps[i], onEditingChanged: { _ in }) {
        //            // Commit
        //            self.commitChanges()
        //        }
        //            .lineLimit(nil)
        HStack {
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

struct StepEditingView_Previews: PreviewProvider {
    static var previews: some View {
        StepEditingView(description: .constant("Lorem ipsum"))
    }
}

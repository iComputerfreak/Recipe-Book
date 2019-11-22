//
//  StepView.swift
//  Recipe Book
//
//  Created by Jonas Frey on 22.10.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import SwiftUI

struct StepEditingView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @Binding var description: String
    @State private var isEditing: Bool = false
    
    var body: some View {
        TextView(text: $description, isEditing: $isEditing, textColor: JFUtils.primaryUIColor(colorScheme), backgroundColor: .clear, contentType: nil, autocorrection: .yes, autocapitalization: .sentences, isScrollingEnabled: true)
            // FIXME: Currently using a fixed height, because other ways don't work
            .frame(height: 200)
            .padding(4)
            .background(Color("ListBackground"))
            .cornerRadius(5)
    }
}

struct StepEditingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StepEditingView(description: .constant("Lorem ipsum"))
                .previewLayout(.fixed(width: 600, height: 200))
            StepsView()
                .environmentObject(Placeholder.sampleRecipes.first!)
                .environment(\.editMode, .constant(.active))
                .previewLayout(.fixed(width: 500, height: 600))
        }
    }
}

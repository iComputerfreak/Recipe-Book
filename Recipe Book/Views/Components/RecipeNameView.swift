//
//  RecipeNameView.swift
//  Recipe Book
//
//  Created by Jonas Frey on 20.10.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import SwiftUI

struct RecipeNameView: View {
     
       @Binding var name: String
       
       var body: some View {
           HStack {
               Spacer()
               Text(name.uppercased())
                   .bold()
                   .font(.title)
               Spacer()
           }
       }
}

struct RecipeNameView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeNameView(name: .constant("Apfelkuchen"))
    }
}

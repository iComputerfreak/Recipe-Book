//
//  EditModeExtension.swift
//  Recipe Book
//
//  Created by Jonas Frey on 22.10.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import Foundation
import SwiftUI

struct JFEditButton: View {
    
    @Environment(\.editMode) var state
    
    var onEditModeChange: ((EditMode?) -> Void)?
    
    var title: String { (state?.wrappedValue == .active) ? "Done" : "Edit" }
    
    var body: some View {
        Button(title) {
            self.state?.wrappedValue.toggle()
            self.onEditModeChange?(self.state?.wrappedValue)
        }
    }
    
}

extension EditMode {
    mutating func toggle() {
        self = (self == .active) ? .inactive : .active
    }
}

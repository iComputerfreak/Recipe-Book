//
//  TextView.swift
//  Recipe Book
//
//  Created by Jonas Frey on 12.10.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import SwiftUI

/// Represents a UITextView
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public struct JFTextView: UIViewRepresentable {
    
    public typealias UIViewType = UITextView
    
    /// The text of the TextView
    @Binding var text: String
    
    public init(text: Binding<String>) {
        self._text = text
    }
    
    public func makeUIView(context: Context) -> JFTextView.UIViewType {
        let textView = UITextView()
        textView.text = self.text
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        textView.backgroundColor = .clear
        return textView
    }
    
    public func updateUIView(_ uiView: JFTextView.UIViewType, context: Context) {
        uiView.text = self.text
    }
}

struct JFTextView_Previews: PreviewProvider {
    static var previews: some View {
        JFTextView(text: .constant("Sample Text"))
    }
}

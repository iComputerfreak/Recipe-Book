//
//  CollectionView.swift
//  Recipe Book
//
//  Created by Jonas Frey on 23.06.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import SwiftUI

// FIXME: Many random errors. No idea where the mistake is
public struct CollectionView<Data, Content> : View where Data: RandomAccessCollection, Content: View, Data.Element: Identifiable, Data.Element: Hashable {
    public var data: Data
    public var content: (Data.Element.IdentifiedValue) -> Content
    
    public var spacing: Length = 10
    public var itemSize: Length = 300
    
    /// Returns the number of items that fit in one row, given the specified spacing and itemSize
    var itemsPerRow: Int {
        let screenWidth = UIScreen.main.bounds.width
        let itemsPerRow = Int(screenWidth / (RecipeListView.itemSize + RecipeListView.spacing))
        // There should be placed at least one item per row
        return itemsPerRow > 0 ? itemsPerRow : 1
    }
    
    public var body: some View {
        // A VStack for all the rows
        VStack(spacing: spacing) {
            // For each row
            ForEach(data.chunked(into: itemsPerRow).identified(by: \.self)) { (rowObjects: Data) in
                // Create a HStack with the rowObjects
                HStack(spacing: self.spacing) {
                    ForEach(rowObjects) { (object: Data.Element.IdentifiedValue) in
                        // Display the items as specified by the content closure
                        self.content(object)
                    }
                    // Make items left-aligned
                    //Spacer()
                }
            }
            // Make rows top-aligned
            Spacer()
            }
            .padding(self.spacing)
    }
}

fileprivate extension RandomAccessCollection {
    /// Splits an array into chunks of fixed size.
    /// - Parameters:
    ///   - into: The chunk size of the return arrays
    /// - Returns: An array containing arrays of at most `into` elements.
    func chunked(into size: Int) -> [[Element]] {
        // Counts from 0 to count in step size `size`
        return stride(from: 0, to: count, by: size).map { i in
            // i is a multiple of `size`
            let indexI = self.index(self.startIndex, offsetBy: i)
            let indexMin = self.index(self.startIndex, offsetBy: Swift.min(i + size, count))
            return Array(self[indexI..<indexMin])
        }
    }
}

#if DEBUG
struct CollectionView_Previews : PreviewProvider {
    // Preview
    static let objects: [Int] = [1, 2, 3, 4, 5]
    
    static var previews: some View {
        CollectionView<Int, Text>(objects: objects) { object in
            Text(String(describing: object))
        }
    }
}
#endif

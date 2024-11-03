//
//  RotateTextView.swift
//  Flashzilla
//
//  Created by Deon O'Brien on 4/11/24.
//

import SwiftUI

struct PriorityGestureView: View {
    var body: some View {
        // Gestures will always prioritise the child view (eg Text) over the parent (VStack), unless told to do otherwise
        // eg. using highPriorityGesture to override (eg. VStack), or .simultaneousGesture (both)
        VStack {
            Text("Hello, World!")
                .onTapGesture {
                    print("Text tapped")
                }
        }
//        .simultaneousGesture(
        .highPriorityGesture(
            TapGesture()
                .onEnded {
                    print("VStack tapped")
                }
        )
    }
}
#Preview {
    PriorityGestureView()
}

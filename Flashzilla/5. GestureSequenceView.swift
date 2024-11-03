//
//  RotateTextView.swift
//  Flashzilla
//
//  Created by Deon O'Brien on 4/11/24.
//

import SwiftUI

struct GestureSequenceView: View {
    // how far the circle has been dragged
    @State private var offset = CGSize.zero

    // whether it is currently being dragged or not
    @State private var isDragging = false

    var body: some View {
        // a drag gesture that updates offset and isDragging as it moves around
        let dragGesture = DragGesture() /// let dragGesture be a new DragGesture
            .onChanged { value in offset = value.translation } /// our offset is how much it's been dragged (translation)
            .onEnded { _ in /// When you release the drag , make it's offset back to .zero and turn off dragging
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }

        // a long press gesture that enables isDragging
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }

        // a combined gesture that forces the user to long press first then drag
        let combined = pressGesture.sequenced(before: dragGesture)

        // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
        Circle()
            .fill(.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
    }
}

#Preview {
    GestureSequenceView()
}

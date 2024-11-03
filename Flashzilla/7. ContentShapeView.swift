//
//  RotateTextView.swift
//  Flashzilla
//
//  Created by Deon O'Brien on 4/11/24.
//

import SwiftUI

struct ContentShapeView: View {
    var body: some View {
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("World")
        }
        .contentShape(.rect) /// Without this only the Hello and World would be tappable not the empty space between them
        .onTapGesture {
            print("VStack tapped!")
        }
    }
}


#Preview {
    ContentShapeView()
}

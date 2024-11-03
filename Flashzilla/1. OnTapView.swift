//
//  1. OnTapView.swift
//  Flashzilla
//
//  Created by Deon O'Brien on 3/11/24.
//

import SwiftUI

struct OnTapView: View {
    @State private var showMessage = false
    @State private var message = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Single Tap")
                .onTapGesture {
                    message = "Single Tapped!"
                    showMessage = true
                }

            Text("Double Tap")
                .onTapGesture(count: 2) { /// count: 2 for double tap
                    message = "Double Tapped!"
                    showMessage = true
                }
            Text("Long Press")
                .onLongPressGesture(minimumDuration: 2) { /// minimum duration is optional
                    message = "Long Pressed!"
                    showMessage = true
                }
            
            
            
                    }

                if showMessage {
                    Text(message)
                        .padding()
                        .background(.black.opacity(0.7))
                        .foregroundColor(.white)
                }
    }
}


#Preview {
    OnTapView()
}

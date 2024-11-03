//
//  CardView.swift
//  Flashzilla
//
//  Created by Deon O'Brien on 5/11/24.
//


// Force landscape mode by going to FlashZilla → Target → General → Deployment Info → Turn off Portrait

import SwiftUI

struct CardView: View {
    @State private var offset = CGSize.zero /// No drag by default (.zero)

    @State private var isShowingAnswer = false
    let card: Card /// needs to be told which card we are looking at, so let card be the current Card
    /// that’s a closure that accepts no parameters and sends nothing back, defaulting to nil so we don’t need to provide it unless it’s explicitly needed.
    /// We would use it to remove a card, for some reason we don't want to use it in ContentView (ie FlashzillaApp.swift)
    var removal: (() -> Void)? = nil

    
    var body: some View {
        ZStack { /// Zstack for multiple layers
            RoundedRectangle(cornerRadius: 25)
                // .fill(.white) /// white at the top
                .fill(
                    /// white is at the top, then it slowly becomes more green as the opacity changes
                    .white
                        .opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(offset.width > 0 ? .green : .red) /// underneath green (or red)
                )
                .shadow(radius: 10)

            /// Placing a Vstack over the ZStack
            VStack {
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                if isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center) /// Default is leading edge, could also use .trailing
        }
        .frame(width: 450, height: 250) /// The smallest iPhone has a width of 480 points
        .rotationEffect(.degrees(offset.width / 5.0)) /// rotate 1/5th of the amount dragged or it will rotate too much
        .offset(x: offset.width * 5) /// Multiply this time so a small swipe will flick the card off the screen
        .opacity(2 - Double(abs(offset.width / 50))) /// We want the opacity to start decreasing the further we drag the card from the center. Absolute in case we are dragging it left or right
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        /// if moved far enough, then remove the card
                        removal?() /// so the closure is only called if it's been set with a value

                    } else {
                        offset = .zero
                        /// else snap it back to it's original place
                    }
                }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.bouncy, value: offset)
        /// .animation(.default, value: offset)

    }
}


#Preview {
    CardView(card: .example) /// Our card is our example card
}

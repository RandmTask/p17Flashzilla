//
//  ContentView.swift
//  Flashzilla
//
//  Created by Deon O'Brien on 3/11/24.
//

import SwiftUI

// This file is the equivalent of ContentView

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        /// return the current view (self) with an offset of x=0 but a y offset of offset x 10
        /// ie pushing our views down by 10 points so we get a nice stack of cards
        return self.offset(y: offset * 10)
    }
}


struct FlashzillaApp: View {

    /// repeating takes one value and repeats it a number of times to create the array, since we don't currently have a way of adding cards (so basically taking our example card and making it 10 times)
    /// @State private var cards = Array<Card>(repeating: .example, count: 10)
    
    @State private var cards = [Card]() /// now that we can add cards we make an empty card array
    
    @State private var timeRemaining = 100 /// Giving the user 100 seconds to answer
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() /// Let timer be a new Timer (timer is from swift)
    
    /// We have two (scenePhase and isActive) because the environment value tells us whether the app is active or inactive in terms of its visibility, but we’ll also consider the app inactive is the player has gone through their deck of flashcards – it will be active from a scene phase point of view, but we don’t keep the timer ticking
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack { /// Our background, using the photo background.png
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            VStack { /// Our timer
                Text("Time: \(timeRemaining)")
                .font(.largeTitle)
                .foregroundStyle(.white)
                .padding(.horizontal, 20) /// padding around the text (ie in the clipshape)
                .padding(.vertical, 5) /// padding around the text (ie in the clipshape)
                .background(.black.opacity(0.75))
                .clipShape(.capsule)
                ZStack { /// Our stack of cards
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index]) {
                           withAnimation {
                               removeCard(at: index)
                           }
                        }
                        .stacked(at: index, in: cards.count)
                        .allowsHitTesting(index == cards.count - 1) /// This means only our top card will be able to be dragged, not the other cards in the stack

                    }
                }
                .allowsHitTesting(timeRemaining > 0) /// The modifier controls touch input - when there's time left, you can interact with cards. When time hits zero, all card interactions are blocked.
                
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                }

            }
            VStack {
                HStack {
                    Spacer()

                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }

                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
        }
        .onReceive(timer) { time in
            guard isActive else { return } /// Exits immediately is isActive is false

            if timeRemaining > 0 { /// To ensure you never get a negative time
                timeRemaining -= 1 /// countdown
            }
        }
        /// On change of scenePhase (ie Active, Inactive, Background)
        /// This will stop the timer immediately if the app is not active, or if the deck is finished
        .onChange(of: scenePhase) {
            if cards.isEmpty {
                if scenePhase == .active {
                    isActive = true
                } else {
                    isActive = false
                }
            }
        }
        
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditCards() /// () is syntactic sugar
        }
        /// When the view is first shown
        .onAppear(perform: resetCards) /// reset the cards to the beginning
    }
    func removeCard(at index: Int) {
        cards.remove(at: index)
        if cards.isEmpty { /// if no cards left
            isActive = false /// stop the timer
        }
    }
    func resetCards() {
        // cards = Array<Card>(repeating: .example, count: 10) /// set the cards to use (Don't need example data any more as we will add our own
        timeRemaining = 100 /// reset timer to 100
        isActive = true /// restart the timer counting down
        loadData()
    }
    func loadData() {
        /// If we can read it, then can we decode it?
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded /// if it works that becomes our cards property
            }
        }
    }
}

#Preview {
    FlashzillaApp()
}




//var body: some View {
//    ZStack {
//        VStack {
//            ZStack {
//                ForEach(0..<cards.count, id: \.self) { index in
//                    CardView(card: cards[index])
//                        .stacked(at: index, in: cards.count)
//                }
//            }
//        }
//    }
//}
//Image(.background)
//    .resizable()
//    .ignoresSafeArea()

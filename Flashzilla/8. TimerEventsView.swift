//
//  8. TimerEventsView.swift
//  Flashzilla
//
//  Created by Deon O'Brien on 4/11/24.
//

import SwiftUI

struct TimerEventsView: View {
    /// Fire the timer every 1 second on the main thread (which is safe for UI)
    /// The timer should run on the common run loop
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    /// This timerTolerance will have a half second tolerance so it will be less of a load on the CPU, in case your app doesn't need exact time (not even leaving out tolerance does not guarantee that it will be exact)
    let timerTolerance = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()

    @State private var counter = 0
    
    var body: some View {
        Text("Hello, World!")
            .onReceive(timer) { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }
                
                counter += 1
            }
    }

}

#Preview {
    TimerEventsView()
}

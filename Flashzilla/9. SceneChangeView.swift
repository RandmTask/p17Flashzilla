//
//  SceneChangeView.swift
//  Flashzilla
//
//  Created by Deon O'Brien on 4/11/24.
//

import SwiftUI

struct SceneChangeView: View {
    /// This tells us the state of the app, is it active, inactive or running in the background
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        Text("Hello, world!")
            .onChange(of: scenePhase) { oldPhase, newPhase in
                if newPhase == .active { /// You are in the app
                    print("Active")
                } else if newPhase == .inactive { /// eg. You have accessed control centre
                    print("Inactive")
                } else if newPhase == .background { /// eg. you are at the home screen or in another app
                    print("Background")
                }
            }
    }
}


#Preview {
    SceneChangeView()
}

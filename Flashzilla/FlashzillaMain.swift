//
//  FlashzillaApp.swift
//  Flashzilla
//
//  Created by Deon O'Brien on 3/11/24.
//

import SwiftUI

@main

struct FlashzillaMain: App {
    var body: some Scene {
        WindowGroup {
            FlashzillaApp()
        }
    }
}

//struct FlashzillaMain: App {
//    var body: some Scene {
//        WindowGroup {
//            NavigationView {
//                List {
//                    NavigationLink {
//                        OnTapView()
//                    } label: {
//                        VStack(alignment: .leading) {
//                            Text("1. OnTap View")
//                            Text("""
//                                .onTapGesture
//                                tap gestures 
//                                and haptic feedback
//                                """)
//                                .font(.caption)
//                                .foregroundColor(.secondary)
//                            
//                        }
//                    }
//                    
//                    NavigationLink("2. Magnify Text View") { MagnifyTextView() }
//                    NavigationLink("3. Rotate Text View") { RotateTextView() }
//                    NavigationLink("4. Priority Gesture View") { PriorityGestureView() }
//                    NavigationLink("5. Gesture Sequence View") { GestureSequenceView() }
//                    NavigationLink("6. Allows Hit Testing") { HitTestingView() }
//                    NavigationLink("7. Content Shape") { ContentShapeView() }
//                    NavigationLink("8. Timer Events") { TimerEventsView() }
//                    NavigationLink("9. Scene Change") { SceneChangeView() }
//                    NavigationLink("10. FlashZilla App") { FlashzillaApp() }
//
//                }
//                .navigationTitle("Project 17 - FlashZilla")
//            }
//        }
//    }
//}

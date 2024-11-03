//
//  Card.swift
//  Flashzilla
//
//  Created by Deon O'Brien on 5/11/24.
//

import Foundation


// Make the Card struct conform to codable,
/// Codable benefits:  1. Automatic Data Serialization eg. using JSON files
/// 2. Data Persistence - Makes it easy to save to UserDefaults, files, or send over network:
/// 3. Network API Integration - Perfect for working with JSON APIs:

struct Card: Codable {
    var prompt: String
    var answer: String

    /// Create a new Card as an example
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}

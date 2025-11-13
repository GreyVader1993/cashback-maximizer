//
//  Card.swift.swift
//  cashback-maximizer
//
//  Created by Tanmay Dureja on 11/8/25.
//

import Foundation
import SwiftUI

struct CashbackCategory: Identifiable {
    let id = UUID()
    let name: String
    let rate: Double
}

struct Card: Identifiable {
    let id = UUID()
    let nickname: String
    let issuer: String
    let last4: String
    let imageName: String        // 🔹 new
    let cashbackCategories: [CashbackCategory]
    let bestFor: [String]
}

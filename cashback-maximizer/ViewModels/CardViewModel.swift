//
//  CardViewModel.swift
//  cashback-maximizer
//
//  Created by Tanmay Dureja on 11/8/25.
//

import Combine
import SwiftUI

class CardViewModel: ObservableObject {
    @Published var cards: [Card] = [
        // Premium Travel Cards
        Card(
            nickname: "Sapphire Preferred",
            issuer: "Chase",
            last4: "0001",
            imageName: "chase_sapphire_preferred",
            cashbackCategories: [
                CashbackCategory(name: "Travel (Chase portal)", rate: 5.0),
                CashbackCategory(name: "Dining", rate: 3.0),
                CashbackCategory(name: "Online Grocery", rate: 3.0),
                CashbackCategory(name: "Streaming", rate: 3.0),
                CashbackCategory(name: "All Other Purchases", rate: 1.0)
            ],
            bestFor: ["Travel", "Dining", "Streaming"]
        ),
        Card(
            nickname: "Sapphire Reserve",
            issuer: "Chase",
            last4: "0002",
            imageName: "chase_sapphire_reserve",
            cashbackCategories: [
                CashbackCategory(name: "Hotels & Rentals (Chase portal)", rate: 10.0),
                CashbackCategory(name: "Flights (Chase portal)", rate: 5.0),
                CashbackCategory(name: "Dining (Chase Dining)", rate: 10.0),
                CashbackCategory(name: "All Other Purchases", rate: 1.0)
            ],
            bestFor: ["Premium Travel", "Fine Dining", "Lounges"]
        ),
        Card(
            nickname: "Platinum Card",
            issuer: "Amex",
            last4: "0003",
            imageName: "amex_platinum",
            cashbackCategories: [
                CashbackCategory(name: "Flights (Direct/Amex)", rate: 5.0),
                CashbackCategory(name: "Hotels (Amex Travel)", rate: 5.0),
                CashbackCategory(name: "All Other Purchases", rate: 1.0)
            ],
            bestFor: ["Premium Travel", "Airport Lounges", "Hotels"]
        ),
        Card(
            nickname: "Venture X",
            issuer: "Capital One",
            last4: "0004",
            imageName: "capital_one_venture_x",
            cashbackCategories: [
                CashbackCategory(name: "Hotels & Rentals (Cap One Travel)", rate: 10.0),
                CashbackCategory(name: "All Other Purchases", rate: 2.0)
            ],
            bestFor: ["Travel", "Everything Else", "Lounges"]
        ),
        
        // Mid-tier Travel & Dining Cards
        Card(
            nickname: "Gold Card",
            issuer: "Amex",
            last4: "0005",
            imageName: "amex_gold",
            cashbackCategories: [
                CashbackCategory(name: "Dining", rate: 4.0),
                CashbackCategory(name: "Groceries (up to $25k/yr)", rate: 4.0),
                CashbackCategory(name: "Flights (Direct/Amex)", rate: 3.0),
                CashbackCategory(name: "All Other Purchases", rate: 1.0)
            ],
            bestFor: ["Dining", "Groceries", "Restaurants"]
        ),
        Card(
            nickname: "Venture Rewards",
            issuer: "Capital One",
            last4: "0006",
            imageName: "capital_one_venture",
            cashbackCategories: [
                CashbackCategory(name: "Hotels & Rentals (Cap One Travel)", rate: 5.0),
                CashbackCategory(name: "All Purchases", rate: 2.0)
            ],
            bestFor: ["Travel", "Flexible Spending"]
        ),
        Card(
            nickname: "Premium Rewards",
            issuer: "Bank of America",
            last4: "0007",
            imageName: "bofa_premium",
            cashbackCategories: [
                CashbackCategory(name: "Travel & Dining", rate: 2.0),
                CashbackCategory(name: "All Other Purchases", rate: 1.5)
            ],
            bestFor: ["Travel", "Dining"]
        ),
        
        // Cash Back Cards
        Card(
            nickname: "Double Cash",
            issuer: "Citi",
            last4: "0008",
            imageName: "citi_double_cash",
            cashbackCategories: [
                CashbackCategory(name: "All Purchases (1% buy + 1% pay)", rate: 2.0)
            ],
            bestFor: ["Everything", "Simple Rewards"]
        ),
        Card(
            nickname: "Freedom Unlimited",
            issuer: "Chase",
            last4: "0009",
            imageName: "chase_freedom_unlimited",
            cashbackCategories: [
                CashbackCategory(name: "Travel (Chase portal)", rate: 5.0),
                CashbackCategory(name: "Dining", rate: 3.0),
                CashbackCategory(name: "Drugstores", rate: 3.0),
                CashbackCategory(name: "All Other Purchases", rate: 1.5)
            ],
            bestFor: ["Everyday", "Dining", "Drugstores"]
        ),
        Card(
            nickname: "Freedom Flex",
            issuer: "Chase",
            last4: "0010",
            imageName: "chase_freedom_flex",
            cashbackCategories: [
                CashbackCategory(name: "Rotating Categories (up to $1,500/qtr)", rate: 5.0),
                CashbackCategory(name: "Travel (Chase portal)", rate: 5.0),
                CashbackCategory(name: "Dining", rate: 3.0),
                CashbackCategory(name: "Drugstores", rate: 3.0),
                CashbackCategory(name: "All Other Purchases", rate: 1.0)
            ],
            bestFor: ["Rotating Categories", "Dining"]
        ),
        Card(
            nickname: "Discover it Cash Back",
            issuer: "Discover",
            last4: "0011",
            imageName: "discover_it",
            cashbackCategories: [
                CashbackCategory(name: "Rotating Categories (up to $1,500/qtr)", rate: 5.0),
                CashbackCategory(name: "All Other Purchases", rate: 1.0)
            ],
            bestFor: ["Rotating Categories", "Gas", "Groceries"]
        ),
        Card(
            nickname: "Active Cash",
            issuer: "Wells Fargo",
            last4: "0012",
            imageName: "wells_fargo_active_cash",
            cashbackCategories: [
                CashbackCategory(name: "All Purchases", rate: 2.0)
            ],
            bestFor: ["Everything", "No Annual Fee"]
        )
    ]
    
    // MARK: - Helper Methods
    
    /// Find the best card for a specific category
    func bestCardFor(category: String) -> Card? {
        return cards.max { card1, card2 in
            let rate1 = card1.cashbackCategories.first { $0.name.lowercased().contains(category.lowercased()) }?.rate ?? 0
            let rate2 = card2.cashbackCategories.first { $0.name.lowercased().contains(category.lowercased()) }?.rate ?? 0
            return rate1 < rate2
        }
    }
    
    /// Get cards sorted by reward rate for a specific category
    func rankedCardsFor(category: String) -> [Card] {
        return cards.sorted { card1, card2 in
            let rate1 = card1.cashbackCategories.first { $0.name.lowercased().contains(category.lowercased()) }?.rate ?? 0
            let rate2 = card2.cashbackCategories.first { $0.name.lowercased().contains(category.lowercased()) }?.rate ?? 0
            return rate1 > rate2
        }
    }
    
    /// Get recommendation based on natural language input
    func getRecommendation(for query: String) -> Card? {
        let lowerQuery = query.lowercased()
        
        // Dining
        if lowerQuery.range(of: "restaurant|dining|dinner|lunch|breakfast|eating|food|cafe|pizza|sushi|burger|bar|brunch", options: .regularExpression) != nil {
            return cards.first { $0.issuer == "Amex" && $0.nickname == "Gold Card" }
        }
        
        // Grocery
        if lowerQuery.range(of: "grocery|supermarket|whole foods|trader joe|safeway|kroger|market", options: .regularExpression) != nil {
            return cards.first { $0.issuer == "Amex" && $0.nickname == "Gold Card" }
        }
        
        // Travel
        if lowerQuery.range(of: "travel|flight|hotel|vacation|trip|airline|booking|airport|rental car", options: .regularExpression) != nil {
            return cards.first { $0.issuer == "Capital One" && $0.nickname == "Venture X" }
        }
        
        // Gas
        if lowerQuery.range(of: "gas|fuel|gas station|shell|chevron|exxon", options: .regularExpression) != nil {
            return cards.first { $0.issuer == "Discover" }
        }
        
        // Drugstore
        if lowerQuery.range(of: "pharmacy|drugstore|cvs|walgreens|rite aid|medicine", options: .regularExpression) != nil {
            return cards.first { $0.issuer == "Chase" && $0.nickname == "Freedom Unlimited" }
        }
        
        // Streaming
        if lowerQuery.range(of: "streaming|netflix|hulu|spotify|disney|apple music|subscription", options: .regularExpression) != nil {
            return cards.first { $0.issuer == "Chase" && $0.nickname == "Sapphire Preferred" }
        }
        
        // Shopping
        if lowerQuery.range(of: "shopping|amazon|target|walmart|store|online|clothes|electronics", options: .regularExpression) != nil {
            return cards.first { $0.issuer == "Citi" && $0.nickname == "Double Cash" }
        }
        
        // Default to best all-around card
        return cards.first { $0.issuer == "Citi" && $0.nickname == "Double Cash" }
    }
}

// MARK: - Category Mapping Extension
extension CardViewModel {
    /// Common spending categories mapped to friendly names
    static let categoryKeywords: [String: [String]] = [
        "Dining": ["restaurant", "dining", "dinner", "lunch", "breakfast", "food", "cafe", "bar"],
        "Groceries": ["grocery", "supermarket", "market", "food store"],
        "Travel": ["travel", "flight", "hotel", "airline", "vacation", "trip"],
        "Gas": ["gas", "fuel", "gas station"],
        "Drugstore": ["pharmacy", "drugstore", "cvs", "walgreens"],
        "Streaming": ["streaming", "netflix", "spotify", "subscription"],
        "Shopping": ["shopping", "amazon", "store", "retail"]
    ]
}

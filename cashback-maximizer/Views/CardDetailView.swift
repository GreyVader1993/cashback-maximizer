//
//  CardDetailView.swift
//  cashback-maximizer
//
//  Created by Tanmay Dureja on 11/8/25.
//

import SwiftUI

struct CardDetailsView: View {
    let card: Card

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Cashback Categories")
                .font(.headline)
                .foregroundColor(.white)
            
            ForEach(card.cashbackCategories) { category in
                HStack {
                    Text(category.name)
                        .foregroundColor(.white)
                    Spacer()
                    Text(String(format: "%.1f%%", category.rate))
                        .foregroundColor(.green)
                }
                .padding(.horizontal)
            }

            Divider().background(Color.white.opacity(0.3))

            Text("Best For")
                .font(.headline)
                .foregroundColor(.white)

            ForEach(card.bestFor, id: \.self) { best in
                Text("• \(best)")
                    .foregroundColor(.white.opacity(0.9))
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.08))
        )
        .padding(.horizontal)
        .padding(.top, -20) // connects visually under the card
    }
}

//
//  CardView.swift
//  cashback-maximizer
//
//  Created by Tanmay Dureja on 11/8/25.
//

import SwiftUI

struct CardView: View {
    let card: Card

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // 🔹 Background image
            Image(card.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 220)
                .clipped()
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black.opacity(0.25)) // darken for text contrast
                )
                .shadow(radius: 10, y: 6)

            VStack(alignment: .leading, spacing: 8) {
                Text(card.nickname)
                    .font(.title2)
                    .bold()
                Text(card.issuer)
                    .font(.subheadline)
                Text("•••• \(card.last4)")
                    .font(.caption)
                    .opacity(0.7)
            }
            .padding()
            .foregroundColor(.white)
        }
        .padding(.horizontal)
    }
}


//
//  CardCarouselView.swift
//  cashback-maximizer
//
//  Created by Tanmay Dureja on 11/8/25.
//

import SwiftUI

struct CardCarouselView: View {
    @ObservedObject var viewModel: CardViewModel
    @State private var selectedCard: Card? = nil

    // Define custom background color
    private let backgroundColor = Color(red: 0x1C/255, green: 0x29/255, blue: 0x2C/255)

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: -140) { // overlap cards strongly
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .frame(height: 220)
                            .scaleEffect(selectedCard?.id == card.id ? 1.05 : 1.0)
                            .opacity(selectedCard == nil || selectedCard?.id == card.id ? 1.0 : 0.3)
                            .shadow(color: .black.opacity(selectedCard?.id == card.id ? 0.4 : 0.2),
                                    radius: selectedCard?.id == card.id ? 20 : 10,
                                    y: selectedCard?.id == card.id ? 10 : 6)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                    if selectedCard?.id == card.id {
                                        selectedCard = nil
                                    } else {
                                        selectedCard = card
                                    }
                                }
                            }
                            .zIndex(selectedCard?.id == card.id ? 1 : 0) // bring focused card to front
                    }
                }
                .padding(.top, 120)
            }
        }
        .navigationTitle("My Cards")
        .navigationBarTitleDisplayMode(.inline)
    }
}

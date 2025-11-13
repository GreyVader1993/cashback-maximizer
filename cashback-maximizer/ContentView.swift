//
//  ContentView.swift
//  cashback-maximizer
//
//  Created by Tanmay Dureja on 11/8/25.
//

import SwiftUI

private let cardHeight: CGFloat = 220
private var cardOverlap: CGFloat {
    cardHeight * 0.85 // only 15% visible of each next card
}

struct ContentView: View {
    @StateObject private var viewModel = CardViewModel()
    @State private var selectedCardID: UUID? = nil
    @Namespace private var animation

    var body: some View {
        ZStack {
            Color(hex: "#1C292C").ignoresSafeArea()

            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: -cardOverlap) { // 🔹 controls overlap amount
                        ForEach(viewModel.cards) { card in
                            if selectedCardID == nil || selectedCardID == card.id {
                                VStack(spacing: 0) {
                                    CardView(card: card)
                                        .id(card.id)
                                        .matchedGeometryEffect(id: card.id, in: animation)
                                        .scaleEffect(selectedCardID == card.id ? 1.05 : 1.0)
                                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                                        .onTapGesture {
                                            withAnimation(.spring(response: 0.55, dampingFraction: 0.8)) {
                                                if selectedCardID == card.id {
                                                    // collapse
                                                    selectedCardID = nil
                                                } else {
                                                    // expand and scroll to top
                                                    selectedCardID = card.id
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                                        withAnimation {
                                                            proxy.scrollTo(card.id, anchor: .top)
                                                        }
                                                    }
                                                }
                                            }
                                        }

                                    if selectedCardID == card.id {
                                        // details section
                                        VStack(alignment: .leading, spacing: 16) {
                                            Text("Cashback Categories")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .padding(.top)

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
                                                    .padding(.horizontal)
                                            }
                                        }
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(Color.white.opacity(0.08))
                                        )
                                        .transition(.move(edge: .top).combined(with: .opacity))
                                        .padding(.bottom, 20)
                                    }
                                }
                                .zIndex(selectedCardID == card.id ? 1 : 0)
                                .padding(.horizontal, 20)
                            }
                        }
                    }
                    .padding(.top, 60) // ✅ start near top of screen, below status bar
                }
            }
        }
    }
}


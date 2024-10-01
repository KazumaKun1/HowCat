//
//  CatFactLoadingView.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 10/1/24.
//

import SwiftUI

struct CatFactLoadingView: View {
    @State private var rotationAngle: Double = -15
    @State private var isAnimating = false
    @State private var trimEnd = 0.2
    
    private let title = "Getting a cat fact"
    
    var body: some View {
        ZStack {
            Color.clear
                .ignoresSafeArea(.all)
            VStack {
                // MARK: - Circular Loading with a cat
                
                ZStack {
                    Circle()
                        .trim(from: 0, to: trimEnd)
                        .stroke(
                            Color.gray.opacity(0.8),
                            style: StrokeStyle(lineWidth: 4, lineCap: .round)
                        )
                        .frame(width: 100, height: 100)
                        .rotationEffect(
                            Angle(degrees: isAnimating ? 360 : 0)
                        )
                        .animation(
                            .linear(duration: 1.5)
                            .repeatForever(autoreverses: false),
                            value: isAnimating)
                        .accessibilityHidden(true)
                    
                    Image(systemName: "cat.fill")
                        .font(.largeTitle)
                        .rotationEffect(.degrees(rotationAngle))
                        .onAppear {
                            withAnimation(
                                .easeInOut(duration: 1.0)
                                .repeatForever(autoreverses: true)
                            ) {
                                rotationAngle = 15
                            }
                        }
                        .accessibilityHidden(true)
                }
                
                Text(title)
                    .font(.title)
                    .accessibilityLabel(title)
            }
            .padding(30)
            .background(.thinMaterial)
            .cornerRadius(10)
        }
        .onAppear {
            isAnimating = true
            withAnimation(
                .linear(duration: 2)
                .repeatForever(autoreverses: true)) {
                    trimEnd = 0.9
            }
        }
        .accessibilityLabel("Progress to get some cat information")
    }
}

#Preview {
    CatFactLoadingView()
}

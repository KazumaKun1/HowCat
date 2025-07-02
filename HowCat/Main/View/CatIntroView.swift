//
//  CatIntroView.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 7/2/25.
//

import SwiftUI

struct CatIntroView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        ZStack {
            ZStack {
                GeometryReader { proxy in
                    Image("CatPicture")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .clipped()
                        .accessibilityLabel(CatFactViewText.imageLabel + "Tap anywhere on the screen to get a cat fact.")
                    Color.black
                        .opacity(0.4)
                }
                .ignoresSafeArea(.all)
            }
            
            Spacer()
            
            VStack {
                // MARK: - Title text
                Text("How Cat?")
                    .font(.largeTitle)
                    .bold()
                    .accessibilityHidden(true)
                
                Spacer()
                
                Text(CatFactViewText.introduction)
                    .font(FontHelper.getAdaptiveFont(isRandomized: false, horizontalSizeClass: horizontalSizeClass))
                    .lineSpacing(1.15)
                    .multilineTextAlignment(.center)
                    .accessibilityLabel(CatFactViewText.introduction)
                    .accessibilityIdentifier("introductionLabel")
                
                Spacer()
            }
            .padding()
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    CatIntroView()
}

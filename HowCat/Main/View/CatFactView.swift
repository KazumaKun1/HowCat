//
//  CatFactView.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 10/1/24.
//

import SwiftUI
import Kingfisher

struct CatFactView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var fact: String?
    var imageUrl: URL?
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                if let url = imageUrl {
                    KFImage.url(url)
                        .fade(duration: 0.5)
                        .resizable()
                        .cacheOriginalImage(false)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .clipped()
                        .accessibilityLabel(CatFactViewText.imageLabel + "Tap anywhere on the screen to get a cat fact.")
                } else {
                    Image("CatPicture")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .clipped()
                        .accessibilityLabel(CatFactViewText.imageLabel + "Tap anywhere on the screen to get a cat fact.")
                }
                
                Color.black
                    .opacity(0.4)
                    .ignoresSafeArea(.all)
            }
            VStack {
                Text("How Cat?")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 40)
                    .accessibilityHidden(true)
                Spacer()
                
                if let fact = fact, !fact.isEmpty {
                    Text(fact)
                        .font(getAdaptiveFont())
                        .lineSpacing(1.15)
                        .multilineTextAlignment(.center)
                        .accessibilityLabel(fact)
                        .accessibilityIdentifier("factLabel")
                } else {
                    Text(CatFactViewText.introduction)
                        .font(getAdaptiveFont())
                        .lineSpacing(1.15)
                        .multilineTextAlignment(.center)
                        .accessibilityLabel(CatFactViewText.introduction)
                        .accessibilityIdentifier("introductionLabel")
                }
                
                Spacer()
            }
            .padding()
            .foregroundStyle(.white)
        }
        .ignoresSafeArea(.all)
    }
    
    func getAdaptiveFont() -> Font {
        if horizontalSizeClass == .regular {
            return .largeTitle
        } else {
            return .title3
        }
    }
}

#Preview {
    CatFactView()
}

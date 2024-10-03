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
    
    @StateObject private var viewModel = CatFactViewModel()
    
    var fact: String?
    var imageUrl: URL?
    
    var body: some View {
        ZStack {
            // MARK: - Cat Background Image
            ZStack {
                GeometryReader { proxy in
                    if let url = imageUrl {
                        KFImage.url(url)
                            .fade(duration: 0.5)
                            .resizable()
                            .cacheOriginalImage(false)
                            .onSuccess {
                                viewModel.loadedImage = $0.image
                            }
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
                }
                .ignoresSafeArea(.all)
            }
            
            VStack {
                HStack {
                    // MARK: - Title text
                    Text("How Cat?")
                        .font(.largeTitle)
                        .bold()
                        .accessibilityHidden(true)
                    
                    if let url = imageUrl,
                       let newFact = fact,
                       !newFact.isEmpty {
                        Spacer()
                        // MARK: - Share Button
                        ShareLink(item: url,
                                  subject: Text("HowCat's cat fact"),
                                  message: Text(newFact)) {
                            Image(systemName: "square.and.arrow.up.fill")
                                .font(.title)
                        }
                        .accessibilityLabel("Share Button")
                        .accessibilityIdentifier("ShareLink")
                    }
                }
                
                Spacer()
                
                // MARK: - fact text
                if let fact = fact, !fact.isEmpty {
                    Text(fact)
                        .font(viewModel.getAdaptiveFont(isRandomized: true, horizontalSizeClass))
                        .lineSpacing(1.15)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.5)
                        .accessibilityLabel(fact)
                        .accessibilityIdentifier("factLabel")
                } else {
                    Text(CatFactViewText.introduction)
                        .font(viewModel.getAdaptiveFont(isRandomized: false, horizontalSizeClass))
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
    }
}

#Preview {
    CatFactView()
}

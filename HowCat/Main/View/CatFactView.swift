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
    
    var content: CatContent
    
    var body: some View {
        ZStack {
            // MARK: - Cat Background Image
            ZStack {
                GeometryReader { proxy in
                    KFImage.url(content.imageUrl)
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
                    
                    Spacer()
                    // MARK: - Share Button
                    ShareLink(item: content.imageUrl,
                              subject: Text("HowCat's cat fact"),
                              message: Text(content.fact)) {
                        Image(systemName: "square.and.arrow.up.fill")
                            .font(.title)
                    }
                    .accessibilityLabel("Share Button")
                    .accessibilityIdentifier("ShareLink")
                }
                
                Spacer()
                
                // MARK: - fact text
                Text(content.fact)
                    .font(FontHelper.getAdaptiveFont(isRandomized: true, horizontalSizeClass: horizontalSizeClass))
                    .lineSpacing(1.15)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .accessibilityLabel(content.fact)
                    .accessibilityIdentifier("factLabel")
                
                Spacer()
            }
            .padding()
            .foregroundStyle(.white)
        }
    }
}

//
//  CatIntroView.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 7/11/25.
//

import SwiftUI

struct CatIntroView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @ObservedObject var viewModel: CatViewModel
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            Group {
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
                
                if viewModel.isLoading {
                    CatFactLoadingView()
                        .transition(.opacity)
                }
            }
            .containerRelativeFrame([.vertical, .horizontal])
        }
        .animation(.easeInOut, value: viewModel.isLoading)
        .onTapGesture {
            viewModel.screenTappedSubject.send()
        }
        .disabled(viewModel.isLoading)
    }
}

private extension CatIntroView {
    struct BackgroundView: View {
        var body: some View {
            Group {
                Image("CatPicture")
                    .resizable()
                    .scaledToFill()
                    .accessibilityLabel("\(CatFactViewText.imageLabel). Tap anywhere on the screen to get a cat fact.")
                Color.black
                    .opacity(0.4)
            }
            .clipped()
            .ignoresSafeArea()
        }
    }
}

#Preview {
    CatIntroView(viewModel: CatViewModel(catService: CatService()))
}

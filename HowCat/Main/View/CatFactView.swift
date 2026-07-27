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
    
    @ObservedObject var viewModel: CatViewModel
    
    @State private var factFont: Font = FontHelper.getAdaptiveFont(isRandomized: true, horizontalSizeClass: nil)
    
    var body: some View {
        ZStack {
            // MARK: - Cat Background Image
            ZStack {
                AsyncImage(url: viewModel.content.imageUrl) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .transition(.opacity)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                            .transition(.opacity)
                    case .failure:
                        Image(systemName: "wifi.slash")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .transition(.opacity)
                    @unknown default:
                        Text("Not Available. Need Developer to fix it")
                    }
                }
                Color.black
                    .opacity(0.4)
                
            }
            .ignoresSafeArea()
            .containerRelativeFrame([.vertical, .horizontal])
            
            VStack {
                HStack {
                    // MARK: - Title text
                    Text("How Cat?")
                        .font(.largeTitle)
                        .bold()
                        .accessibilityHidden(true)
                    
                    Spacer()
                    // MARK: - Share Button
                    ShareLink(item: viewModel.content.imageUrl,
                              subject: Text("HowCat's cat fact"),
                              message: Text(viewModel.content.fact)) {
                        Image(systemName: "square.and.arrow.up.fill")
                            .font(.title)
                    }
                    .accessibilityLabel("Share Button")
                    .accessibilityIdentifier("ShareLink")
                }
                
                Spacer()
                
                // MARK: - fact text
                Text(viewModel.content.fact)
                    .font(factFont)
                    .lineSpacing(1.15)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .accessibilityLabel(viewModel.content.fact)
                    .accessibilityIdentifier("factLabel")
                
                Spacer()
            }
            .padding()
            .foregroundStyle(.white)
            
            if viewModel.isLoading {
                CatFactLoadingView()
            }
        }
        .onTapGesture {
            viewModel.screenTappedSubject.send()
        }
        .onChange(of: viewModel.content.fact) { @MainActor _, _ in
            factFont = FontHelper.getAdaptiveFont(isRandomized: true, horizontalSizeClass: horizontalSizeClass)
        }
        .onAppear { @MainActor in
            factFont = FontHelper.getAdaptiveFont(isRandomized: true, horizontalSizeClass: horizontalSizeClass)
        }
        .disabled(viewModel.isLoading)
        .navigationBarBackButtonHidden(true)
        .animation(.easeInOut, value: viewModel.isLoading)
    }
}

#Preview {
    CatFactView(viewModel: CatViewModel(catService: CatService()))
}

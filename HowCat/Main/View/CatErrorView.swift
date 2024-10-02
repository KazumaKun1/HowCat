//
//  CatErrorView.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 10/1/24.
//

import SwiftUI

struct CatErrorView: View {
    var errorMessage: String
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Image("SadCatPicture")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: proxy.size.height, alignment: .leading)
                    .clipped()
                    .accessibilityHidden(true)
                
                Color.black
                    .opacity(0.4)
                    .ignoresSafeArea(.all)
            }
            
            VStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .accessibilityHidden(true)
                
                Text(errorMessage)
                    .foregroundStyle(.white)
                    .font(.title3)
                    .lineSpacing(1.15)
                    .multilineTextAlignment(.center)
                    .padding()
                    .accessibilityLabel(errorMessage)
                    .accessibilityIdentifier("errorLabel")
            }
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    CatErrorView(errorMessage: "This is an error message")
}

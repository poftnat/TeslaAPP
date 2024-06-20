//
//  PlaceholderPage.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 20.05.2024.
//

import SwiftUI

/// Заглушка для несозданных экранов
struct PlaceholderPage: View {
    
    private enum Constants {
        static let pageTitle = "Develop in process"
        static let avenirBoldFontName = "Avenir-Bold"
        static let imageName = "gear1"
    }
    var body: some View {
        backgroundStackView {
            VStack {
                Text(Constants.pageTitle)
                    .font(.custom(Constants.avenirBoldFontName, size: 16))
                    .foregroundStyle(.icon)
                Image(Constants.imageName)
                    .resizable()
                    .frame(width: 100, height: 100)
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)

    }
    
    private func backgroundStackView<Content: View>(content: () -> Content ) -> some View {
        ZStack {
            Rectangle()
                .fill(
                    Color.topPageBackground.opacity(0.6)
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
            Rectangle()
                .fill(
                    LinearGradient(stops: [.init(color: .lightShadow.opacity(0.4), location: 0.4), .init(color: .lightShadow.opacity(0.2), location: 0.99)], startPoint: .topTrailing, endPoint: .bottomLeading)
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
            content()
        }
    }
}

#Preview {
    PlaceholderPage()
}

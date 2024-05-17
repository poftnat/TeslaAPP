//
//  SplashView.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 16.05.2024.
//

import SwiftUI

struct SplashView: View {
    
    @State private var isAnimationStarted = false
    @State private var isAnimationFinished = false
    
    var body: some View {
        ZStack {
            Color.black
            foregroundGradient
                .opacity(isAnimationFinished ? 0 : 1)
                TeslaLogoShape()
                    .stroke(style: .init(lineWidth: isAnimationFinished ? 10 : 3, lineJoin: .round))
                    .fill(.white)
                    .shadow(color: .white, radius: isAnimationFinished ? 10 : 6)
                    .shadow(color: .white, radius: isAnimationFinished ? 10 : 6)
                    .blur(radius: isAnimationFinished ? 3 : 0)
                    .opacity(isAnimationStarted ? 1 : 0)
                    .opacity(isAnimationFinished ? 0 : 1)
        }
        .ignoresSafeArea()
        .onAppear {
            animateLogo()
        }
        .fullScreenCover(isPresented: $isAnimationFinished, content: {
            withAnimation {
                UnlockView()
            }
        })
    }
    
    private var logo: some View {
            TeslaLogoShape()
                .stroke(style: .init(lineWidth: isAnimationFinished ? 10 : 3, lineJoin: .round))
                .fill(.white)
                .shadow(color: .white, radius: isAnimationFinished ? 20 : 6)
                .blur(radius: isAnimationFinished ? 5 : 1)
                .opacity(isAnimationStarted ? 1 : 0.5)
                .opacity(isAnimationFinished ? 0 : 1)
    }
    
    private var foregroundGradient: LinearGradient {
        LinearGradient(
            stops: [
                .init(color: .lightShadow, location: 0),
                .init(color: .darkShadow, location: 0.2),
                .init(color: .darkShadow, location: 0.7),
                .init(color: .lightShadow, location: 1)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    private func animateLogo() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            withAnimation(.easeIn) {
                isAnimationStarted = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeIn(duration: 1.5)) {
                        isAnimationStarted = false
                    }
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            withAnimation(.easeIn(duration: 3)) {
                isAnimationFinished = true
            }
        }
    }
}

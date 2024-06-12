//
//  SplashView.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 16.05.2024.
//

import SwiftUI

/// Сплэш-скрин с логотипом
struct SplashView: View {
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: UnlockView(), isActive: $isTransitionAllowed) {
                ZStack {
                    Color.black
                    foregroundGradient
                        .opacity(isAnimationStarted ? 1 : 0)
                    if isAnimationStarted {
                        Group {
                            logoView
                            coloredLogoView
                        }
                        .frame(width: 300, height: 570)
                        .transition(.offset(y: -8).combined(with: .opacity))
                    }
                }
                .ignoresSafeArea()
                .onAppear {
                    animateLogo()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    @State private var isAnimationStarted = false
    @State private var isAnimationLoopFinished = false
    @State private var isAnimationFinished = false
    @State private var isTransitionAllowed = false
    
    private var logoView: some View {
        TeslaLogoShape()
            .stroke(style: .init(lineWidth: 0.9, lineJoin: .round))
            .fill(.white)
            .shadow(color: .white, radius: isAnimationLoopFinished ? 10 : 3)
            .shadow(color: .white, radius: isAnimationLoopFinished ? 10 : 3)
            .blur(radius: isAnimationFinished ? 3 : 0)
            .opacity(isAnimationLoopFinished ? 1 : 0.8)
            .opacity(isAnimationFinished ? 0 : 1)
    }
    
    private var coloredLogoView: some View {
            TeslaLogoShape()
                .stroke(style: .init(lineWidth: 0.7))
                .opacity(isAnimationStarted ? 1 : 0)
                .opacity(isAnimationFinished ? 0 : 1)
                .blur(radius: 3.0)
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
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in
            withAnimation(.easeIn(duration: 1.2)) {
                isAnimationStarted = true
                isAnimationLoopFinished = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeIn(duration: 1)) {
                        isAnimationLoopFinished = false
                    }
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            withAnimation(.easeIn(duration: 0.6)) {
                isAnimationFinished = true
            }
        }
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 9.6) {
            withAnimation(.easeIn(duration: 1)) {
                isTransitionAllowed = true
            }
        }
    }
}

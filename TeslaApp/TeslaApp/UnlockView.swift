//
//  UnlockView.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 14.05.2024.
//

import SwiftUI

struct UnlockView: View {
    
    private enum Constants {
        static let unlockText = "Unlock"
        static let lockText = "Lock"
        static let lockImageName = "lock.fill"
        static let unlockImageName = "lock.open.fill"
        static let hiText = "Hi"
        static let verdanaFontName = "Verdana"
        static let welcomeText = "Welcome back"
        static let verdanaBoldFontName = "Verdana-Bold"
        static let unlockedCarImageName = "unlocked car"
        static let lockedCarImageName = "locked car"
        static let settingsImageName = "gearshape"
    }
        
    var body: some View {
            backgroundStackView {
                ZStack {
                    foregroundGradient
                        .ignoresSafeArea()
                        .opacity(isCarClosed ? 1 : 0)
                    VStack {
                        if !isCarClosed {
                            welcomeTitleView
                                .transition(.opacity.combined(with: .offset(y: -20)))
                        }
                        carImageView
                            .offset(x: 5, y: isCarClosed ? 40 : 0)
                    }
                    VStack {
                        NavigationLink(destination: TeslaTabView()) {
                            HStack {
                                Spacer()
                                settingsButton
                            }
                        }
                        Spacer()
                        CarLockerView(isCarClosed: $isCarClosed)
                            .padding(.bottom, 30)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .navigationBarBackButtonHidden()
    }
    
    @State private var isCarClosed = true
    
    private var welcomeTitleView: some View {
        VStack {
            Text(Constants.hiText)
                .font(.custom(Constants.verdanaFontName, size: 20))
                .foregroundStyle(.labelSecondary)
            Spacer().frame(height: 20)
            Text(Constants.welcomeText)
                .font(.custom(Constants.verdanaBoldFontName, size: 36))
                .foregroundStyle(.white)
        }
        .padding()
    }
    
    private var carImageView: some View {
        ZStack {
            Image(Constants.unlockedCarImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(x: 5)
                .opacity(isCarClosed ? 0 : 1)
                .background(
                    RadialGradient(colors: [.basic, .gradientBottom.opacity(0.4)], center: .center, startRadius: 200, endRadius: 10)
                        .blur(radius: 20)
                        .opacity(isCarClosed ? 0 : 1)
                )
            Image(Constants.lockedCarImageName)
                .resizable()
                .frame(width: 320, height: 240)
                .offset(y: -35)
                .aspectRatio(contentMode: .fit)
                .opacity(isCarClosed ? 1 : 0)
        }
    }
    
    private var settingsButton: some View {
        Image(systemName: Constants.settingsImageName)
            .regularCircleBackground()
            .padding(.top, 10)
            .padding(.horizontal, 20)
    }
    
    private var backgroundGradient: LinearGradient {
        LinearGradient(colors: [.black, .darkShadow, .lightShadow, .darkShadow, .black], startPoint: .top, endPoint: .bottom)
    }
    
    private var foregroundGradient: LinearGradient {
        LinearGradient(stops: [.init(color: .lightShadow.opacity(0.6), location: 0), .init(color: .darkShadow, location: 0.2), .init(color: .darkShadow, location: 0.7), .init(color: .lightShadow.opacity(0.4), location: 1)], startPoint: .top, endPoint: .bottom)
    }
    
    func backgroundStackView<Content: View>(content: () -> Content ) -> some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(colors: [.lightShadow, .basic, .basic], startPoint: .top, endPoint: .bottom))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
            content()
        }
    }
}

#Preview {
    UnlockView()
}

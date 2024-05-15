//
//  UnlockView.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 14.05.2024.
//

import SwiftUI

struct UnlockView: View {
    
    @State var isCarClosed = true
    
    var body: some View {
        NavigationView {
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
                        NavigationLink(destination: MainView()) {
                            HStack {
                                Spacer()
                                settingsButton
                            }
                        }
                        Spacer()
                        lockCarView
                            .padding(.bottom, 30)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
    }
    
    private var lockCarView: some View {
            Button {
                withAnimation() {
                    isCarClosed.toggle()
                }
            } label: {
                HStack {
                    Text(isCarClosed ? "Unlock" : "Lock")
                        .padding(.leading, 10)
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: isCarClosed ? "lock.fill" : "lock.open.fill")
                        .foregroundStyle(LinearGradient.accentGradient)
                        .font(.system(size: 20))
                        .foregroundStyle(.icon)
                        .padding(.all, 12)
                        .background(
                            ZStack {
                                buttonBackgroundView
                            }
                        )
                .clipShape(Circle())
                .frame(width: 30, height: 30)
                .padding(.trailing, 10)
                .neumorfismNonSelectedStyle()
                }
                .frame(width: 160, height: 55)
                .padding(.all, 10)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 40)
                            .fill(LinearGradient(colors: [.darkShadow.opacity(0.45), .lightShadow.opacity(0.3)], startPoint: .top, endPoint: .bottom))
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(LinearGradient(colors: [.darkShadow.opacity(0.45), .lightShadow.opacity(0.1)], startPoint: .top, endPoint: .bottomTrailing), lineWidth: 15)
                            .blur(radius: 6)
                            .clipShape(RoundedRectangle(cornerRadius: 60))
                    }

                )
            }
            .frame(width: 300)
    }
    
    private var welcomeTitleView: some View {
        VStack {
            Text("Hi")
                .font(.custom("Verdana", size: 20))
                .foregroundStyle(.labelSecondary)
            Spacer().frame(height: 20)
            Text("Welcome back")
                .font(.custom("Verdana-Bold", size: 36))
                .foregroundStyle(.white)
        }
        .padding()
    }
    
    private var carImageView: some View {
        ZStack {
            Image("unlocked car")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(x: 5)
                .opacity(isCarClosed ? 0 : 1)
                .background(
                    RadialGradient(colors: [.basic, .gradientBottom.opacity(0.4)], center: .center, startRadius: 200, endRadius: 10)
                        .blur(radius: 20)
                        .opacity(isCarClosed ? 0 : 1)
                )
            Image("locked car")
                .resizable()
                .frame(width: 320, height: 240)
                .offset(y: -35)
                .aspectRatio(contentMode: .fit)
                .opacity(isCarClosed ? 1 : 0)
        }
    }
    
    private var buttonBackgroundView: some View {
        ZStack {
            RadialGradient(colors: [.lightShadow, .darkShadow.opacity(0.45)], center: .topLeading, startRadius: 0, endRadius: 80)
            Circle()
                .fill(LinearGradient(colors: [.lightShadow, .darkShadow.opacity(0.45)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .padding(2)
                .blur(radius: 8)
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 4))
                .fill(LinearGradient(colors: [.darkShadow.opacity(0.45), .lightShadow], startPoint: .top, endPoint: .bottomTrailing))
                .blur(radius: 1)
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 1))
                .fill(.darkShadow)
        }
    }
    
    private var settingsButton: some View {
        Image(systemName: "gearshape")
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

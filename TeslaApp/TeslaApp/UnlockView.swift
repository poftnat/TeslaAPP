//
//  UnlockView.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 14.05.2024.
//

import SwiftUI

struct UnlockView: View {
    
    @State var isCarClosed = false
    @State var isOnSettingsButtonTap = false
    
    var body: some View {
        NavigationView {
            backgroundStackView {
                VStack {
                    NavigationLink(destination: MainView()) {
                        Image(systemName: "gearshape")
                            .regularCircleBackground()
                            .position(x: UIScreen.main.bounds.width - 60, y: 60)
                    }
                    Spacer()
                    lockCarView
                    Spacer()

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                    Image(systemName: isCarClosed ? "lock.open.fill" : "lock.fill")
                        .foregroundStyle(gradient)
                        .padding(.trailing, 10)
                }
                .frame(width: 120, height: 50)
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
    
    var gradient: LinearGradient {
        LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .top, endPoint: .bottom)
    }
    
    var backgroundGradient: LinearGradient {
        LinearGradient(colors: [.black, .darkShadow, .lightShadow, .darkShadow, .black], startPoint: .top, endPoint: .bottom)
    }
    
    func backgroundStackView<Content: View>(content: () -> Content ) -> some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(colors: [.white.opacity(0.3), .basic, .basic], startPoint: .top, endPoint: .bottom))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
            content()
        }
    }
}

#Preview {
    UnlockView()
}

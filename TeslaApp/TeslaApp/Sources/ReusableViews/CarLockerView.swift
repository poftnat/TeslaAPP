//
//  CarLockerView.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 12.06.2024.
//

import SwiftUI

/// Переиспользуемое вью открытия-закрытия машины
struct CarLockerView: View {
    
    private enum Constants {
        static let unlockText = "Unlock"
        static let lockText = "Lock"
        static let lockImageName = "lock.fill"
        static let unlockImageName = "lock.open.fill"
    }
    
    @Binding
    var isCarClosed: Bool
    
    var body: some View {
        lockCarView
    }
    
    private var lockCarView: some View {
            Button {
                withAnimation(.spring(duration: 1)) {
                    isCarClosed.toggle()
                }
            } label: {
                HStack {
                    Text(isCarClosed ? Constants.unlockText : Constants.lockText)
                        .padding(.leading, 10)
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: isCarClosed ? Constants.lockImageName : Constants.unlockImageName)
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
                    lockCarViewBackground
                )
            }
            .frame(width: 300)
    }
    
    private var lockCarViewBackground: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .fill(LinearGradient(colors: [.darkShadow.opacity(0.45), .lightShadow.opacity(0.3)], startPoint: .top, endPoint: .bottom))
            RoundedRectangle(cornerRadius: 40)
                .stroke(LinearGradient(colors: [.darkShadow.opacity(0.45), .lightShadow.opacity(0.1)], startPoint: .top, endPoint: .bottomTrailing), lineWidth: 15)
                .blur(radius: 6)
                .clipShape(RoundedRectangle(cornerRadius: 60))
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
}

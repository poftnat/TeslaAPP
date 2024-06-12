//
//  ViewModifiers.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 14.05.2024.
//

import SwiftUI


/// Возвращает выпуклый вью
struct NonselectedShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .lightShadow, radius: 10, x: -8, y: -8)
            .shadow(color: .darkShadow, radius: 10, x: 8, y: 8)
    }
}


/// Возвращает вогнутый вью
struct SelectedShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .lightShadow, radius: 10, x: 5, y: 5)
            .shadow(color: .darkShadow, radius: 10, x: -5, y: -5)
    }
}

/// Возвращает круглый вью
struct CircleShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 10)
            .background(Circle().fill(.basic))
            .neumorfismNonSelectedStyle()
    }
}

/// Возвращает круглый вью под стандартную выпуклую кнопку с желобом
struct CircleButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20))
            .foregroundStyle(.icon)
            .frame(width: 50, height: 50)
            .background(
                ZStack {
                    RadialGradient(colors: [.lightShadow, .darkShadow.opacity(0.45)], center: .topLeading, startRadius: 0, endRadius: 80)
                    Circle()
                        .fill(LinearGradient(colors: [.lightShadow, .darkShadow.opacity(0.45)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .padding(2)
                        .blur(radius: 8)
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 4))
                        .fill(LinearGradient(colors: [.darkShadow.opacity(0.45), .lightShadow], startPoint: .top, endPoint: .bottomTrailing))
                }
                    .clipShape(Circle())
            )
    }
}

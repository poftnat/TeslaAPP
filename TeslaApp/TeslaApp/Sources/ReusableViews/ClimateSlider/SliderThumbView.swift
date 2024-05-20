//
//  SliderThumbView.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 14.05.2024.
//

import SwiftUI

/// Точка захвата для слайдера с экрана настройки климата
struct SliderThumbView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.basic)
                .frame(width: 27.5, height: 15)
            RoundedRectangle(cornerRadius: 20)
                .fill(linearGradient)
                .frame(width: 27.5, height: 15)
            RoundedRectangle(cornerRadius: 10)
                .stroke(style: .init(lineWidth: 0.5))
                .fill(borderGradient)
                .frame(width: 27.5, height: 15)
                .blur(radius: 2)
            HStack {
                separatorElement
                    .offset(x: 2)
                separatorElement
                    .offset(x: -2)
            }
        }
    }
    
    private var linearGradient = LinearGradient(
        colors: [.lightShadow, .darkShadow],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    private var borderGradient = LinearGradient(
        colors: [.darkShadow, .lightShadow],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    private var separatorElement: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .fill(LinearGradient(colors: [.darkShadow.opacity(0.5), .lightShadow.opacity(0.9)], startPoint: .leading, endPoint: .trailing))
            RoundedRectangle(cornerRadius: 40)
                .stroke(LinearGradient(colors: [.darkShadow.opacity(0.8), .lightShadow.opacity(0.4)], startPoint: .leading, endPoint: .trailing), lineWidth: 15)
                .blur(radius: 3)
                .clipShape(RoundedRectangle(cornerRadius: 60))
        }
        .frame(width: 3, height: 12)
    }
}

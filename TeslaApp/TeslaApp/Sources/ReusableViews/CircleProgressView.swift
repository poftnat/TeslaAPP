//
//  CircleProgressView.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 15.05.2024.
//

import SwiftUI

/// Круглый прогресс-вью для экрана климат-системы
struct CircleProgressBar: View {
    @Binding var progress: Double
    var maxValue: Double
    var minValue: Double
    var color: Color
    
    private var trimPoint: Double {
        (progress - minValue) / (maxValue - minValue)
    }
    var body: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(colors: [.circularTop, .darkShadow.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 200)
            Circle()
                .fill(LinearGradient(colors: [.darkShadow.opacity(0.6), .icon.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 140)
            Circle()
                .stroke(style: .init(lineWidth: 1))
                .fill(Color.topPageBackground)
                .blur(radius: 1)
                .frame(width: 140)
            Circle()
                .trim(from: 0, to: trimPoint)
                .stroke(style: .init(lineWidth: 16, lineCap: .round, lineJoin: .round))
                .fill(color.opacity(0.9))
                .frame(width: 140)
                .rotationEffect(.degrees(-100))
                .animation(.easeInOut(duration: 0.5))
                .shadow(color: color, radius: 12)
        }
    }
}

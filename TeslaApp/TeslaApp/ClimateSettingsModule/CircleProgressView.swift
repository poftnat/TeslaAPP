//
//  CircleProgressView.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 15.05.2024.
//

import SwiftUI

struct CircleProgressBarView: View {
    @State var progress: Double = 0
    
    
    var body: some View {
        VStack {
            CircleProgressBar(progress: $progress, maxValue: 100, minValue: 21, startColor: .red, endColor: .yellow)
            Slider(value: $progress, in: 21...100, step: 1)
            Text("\(progress)")
                .foregroundStyle(.white)
        }
    }
}



struct CircleProgressBar: View {
    @Binding var progress: Double
    var maxValue: Double
    var minValue: Double
    var startColor: Color
    var endColor: Color
    
    private var trimPoint: Double {
        (progress - minValue) / (maxValue - minValue)
    }
    var body: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(colors: [.circularTop, .darkShadow.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 160)
            Circle()
                .fill(LinearGradient(colors: [.icon, .darkShadow], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 120)
            Circle()
                .stroke(style: .init(lineWidth: 1))
                .fill(Color.topPageBackground)
                .frame(width: 120)
            Circle()
                .trim(from: 0, to: trimPoint)
                .stroke(style: .init(lineWidth: 16, lineCap: .round, lineJoin: .round))
                .fill(LinearGradient(colors: [startColor, endColor], startPoint: .bottomTrailing, endPoint: .topLeading).opacity(0.9))
                .frame(width: 120)
                .rotationEffect(.degrees(-100))
                .animation(.easeInOut(duration: 0.5))
                .shadow(color: startColor, radius: 12)
        }
    }
}

#Preview {
    CircleProgressBarView()
}

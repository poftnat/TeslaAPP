//
//  TriangleSlider.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 20.05.2024.
//

import SwiftUI

/// Слайдер экрана зарядки
struct TriangleSlider: View {
    
    @Binding var value: Double

    var body: some View {
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    ZStack {
                        makeCurrentValueIndicator(with: geometry)
                        makeMaxValueIndicator(with: geometry)
                    }
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.basic)
                            .frame(width: geometry.size.width, height: 10)
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(verticalGradient, style: .init(lineWidth: 5))
                            .blur(radius: 4)
                            .frame(width: geometry.size.width, height: 10)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        TriangleSliderThimbView()
                            .shadow(color: .lightShadow, radius: 10)
                            .offset(x: CGFloat(value) * geometry.size.width - 12)
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged({ value in
                                            updateValue(with: value, in: geometry)
                                    })
                            )
                    }
                }
            }
            .frame(height: 80)
    }
    
    var verticalGradient = LinearGradient(colors: [.darkShadow, .lightShadow], startPoint: .top, endPoint: .bottom)

    private func makeCurrentValueIndicator(with geometry: GeometryProxy) -> some View {
        VStack {
            Rectangle()
                .fill(LinearGradient.accentGradient)
                .frame(width: 3, height: 10)
                .offset(x: CGFloat(value) * geometry.size.width - 24)
            
            Text("\(Int(value * 100))%")
                .font(.custom("Avenir", size: 16))
                .frame(maxWidth: 50, alignment: .trailing)
                .offset(x: CGFloat(value) * geometry.size.width * 0.97 - 25)
        }
        .padding(.trailing, 30)
    }
    
    private func makeMaxValueIndicator(with geometry: GeometryProxy) -> some View {
        VStack {
            Rectangle()
                .fill(LinearGradient.accentGradient)
                .frame(width: 3, height: 10)
                .offset(x: geometry.size.width - 24)
                .opacity(value > 0.9 ? 0.5 : 1)
            Text("100%")
                .font(.custom("Avenir", size: 16))
                .frame(maxWidth: 50, alignment: .leading)
                .offset(x: geometry.size.width - 29)
                .opacity(value > 0.9 ? 0 : 1)
        }
        .padding(.trailing, 30)
    }
    
    private func updateValue(with gesture: DragGesture.Value, in geometry: GeometryProxy) {
        let newValue = gesture.location.x / geometry.size.width
        value = min(max(Double(newValue), 0), 1)
    }
}

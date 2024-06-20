//
//  DarkSlider.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 14.05.2024.
//

import SwiftUI

/// Слайдер для экрана настройки климат-системы
struct DarkSlider: View {
    @Binding var value: Double
    @Binding var color: Color
    
    @State var lastCoordinateValue: CGFloat = 0.0
    var sliderRange: ClosedRange<Double>
    var step: Double
    var thumbColor: Color = .green
    var minTrackColor: Color = .red
    var maxTrackColor: Color = .blue
    
    var body: some View {
        GeometryReader { gr in
            let thumbHeight = gr.size.height * 1.3
            let thumbWidth = gr.size.width * 0.05
            let radius = gr.size.height
            let minValue = gr.size.width * 0.0
            let maxValue = (gr.size.width * 0.99) - thumbWidth * 0.6
            
            let scaleFactor = (maxValue - minValue) / (sliderRange.upperBound - sliderRange.lowerBound)
            let lower = sliderRange.lowerBound
            let sliderVal = (self.value - lower) * scaleFactor + minValue
            ZStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LinearGradient(colors: [.darkShadow, .lightShadow], startPoint: .top, endPoint: .bottom))
                        .frame(width: gr.size.width, height: 6)
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(style: .init(lineWidth: 0.8))
                        .fill(LinearGradient(colors: [.lightShadow, .darkShadow], startPoint: .top, endPoint: .bottom))
                        .blur(radius: 1)
                        .frame(width: gr.size.width, height: 8)
                }
                HStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(color)
                        .shadow(radius: 3)
                        .frame(width: sliderVal, height: 8)
                    Spacer()
                }
                HStack {
                    SliderThumbView()
                        .foregroundColor(thumbColor)
                        .frame(width: thumbWidth, height: thumbHeight)
                        .offset(x: sliderVal)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { v in
                                    withAnimation {
                                        
                                        if (abs(v.translation.width) < 0.1) {
                                            self.lastCoordinateValue = sliderVal
                                        }
                                        if v.translation.width > 0 {
                                            let nextCoordinateValue = min(maxValue, self.lastCoordinateValue + v.translation.width)
                                            if ((nextCoordinateValue - minValue) / scaleFactor) + lower - self.value > step {
                                                self.value += step
                                            }
                                        } else {
                                            let nextCoordinateValue = max(minValue, self.lastCoordinateValue + v.translation.width)
                                            if ((nextCoordinateValue - minValue) / scaleFactor) + lower - self.value < -step {
                                                self.value -= step
                                            }
                                        }
                                    }
                                }
                        )
                    Spacer()
                }
                .frame(height: 50)
            }
        }
    }
}

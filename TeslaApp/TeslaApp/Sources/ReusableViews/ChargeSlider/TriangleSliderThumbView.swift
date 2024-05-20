//
//  TriangleSliderThumbView.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 20.05.2024.
//

import SwiftUI

/// Точка захвата для слайдера с экрана зарядки
struct TriangleSliderThimbView: View {
    
    var body: some View {
        RoundedTriangle()
            .fill(LinearGradient.accentGradient)
            .frame(width: 25, height: 25)
    }
}

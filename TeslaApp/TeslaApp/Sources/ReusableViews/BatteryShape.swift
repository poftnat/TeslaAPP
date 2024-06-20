//
//  BatteryShape.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 20.05.2024.
//

import SwiftUI

/// Батарея с экрана зарядки
struct Battery: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height * 0.6))
            path.addLine(to: CGPoint(x: rect.width * 0.1, y: 0))
            path.addLine(to: CGPoint(x: rect.width * 0.9, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height * 0.6))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.closeSubpath()
        }
    }
}

/// Батарея с экрана зарядки - активная часть.
struct ActiveBattery: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height * 0.6))
            path.addLine(to: CGPoint(x: rect.width * 0.1, y: 0))
            path.addLine(to: CGPoint(x: rect.width * 0.6, y: 0))
            path.addLine(to: CGPoint(x: rect.width * 0.7, y: rect.height * 0.6))
            path.addLine(to: CGPoint(x: rect.width * 0.7, y: rect.height))
            path.closeSubpath()
        }
    }
}

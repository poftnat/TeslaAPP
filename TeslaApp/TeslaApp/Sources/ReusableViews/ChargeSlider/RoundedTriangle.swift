//
//  RoundedTriangle.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 20.05.2024.
//

import SwiftUI

/// Треугольник со скругленными краями
struct RoundedTriangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.width * 0.03, y: rect.height * 0.92))
            path.addLine(to: CGPoint(x: rect.width * 0.44, y: rect.height * 0.1))
            path.addQuadCurve(to: CGPoint(x: rect.width * 0.56, y: rect.height * 0.1), control: CGPoint(x: rect.width * 0.5, y: 0))
            path.addLine(to: CGPoint(x: rect.width * 0.97, y: rect.height * 0.92))
            path.addQuadCurve(to: CGPoint(x: rect.width * 0.9, y: rect.height), control: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width * 0.1, y: rect.height))
            path.addQuadCurve(to: CGPoint(x: rect.width * 0.03, y: rect.height * 0.92), control: CGPoint(x: 0, y: rect.height))
            path.closeSubpath()
        }
    }
}

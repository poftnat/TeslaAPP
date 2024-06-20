//
//  ChargerMarker.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 20.05.2024.
//

import SwiftUI


/// Каплевидный маркер под указатель
struct ChargerMarker: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.width * 0.5, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width * 0.22, y: rect.height * 0.6))
            path.addQuadCurve(to: CGPoint(x: rect.width * 0.25, y: rect.height * 0.08), control: CGPoint(x: rect.width * 0.0, y: rect.height * 0.26))
            path.addQuadCurve(to: CGPoint(x: rect.width * 0.75, y: rect.height * 0.08), control: CGPoint(x: rect.width * 0.5, y: rect.height * -0.07))
            path.addQuadCurve(to: CGPoint(x: rect.width * 0.78, y: rect.height * 0.6), control: CGPoint(x: rect.width * 1.0, y: rect.height * 0.26))
            path.closeSubpath()
        }
    }
}

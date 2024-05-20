//
//  TeslaTabBarShape.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 16.05.2024.
//

import SwiftUI

struct TeslaTabBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let startPoint = CGPoint(x: 0, y: rect.height * 0.428)
        
        path.move(to: startPoint)
        
        path.addCurve(
            to: CGPoint(
                x: rect.width * 0.16,
                y: rect.height * 0.001
            ),
            control1: CGPoint(
                x: rect.width * 0.05,
                y: rect.height * 0.18
            ),
            control2: CGPoint(
                x: rect.width * 0.05,
                y: rect.height * 0.001
            )
        )
        
        path.addLine(to: CGPoint(x: rect.width * 0.31,
                                 y: rect.height * 0.02))
        
        path.addCurve(
            to: CGPoint(
                x: rect.width * 0.5,
                y: rect.height * 0.41
            ),
            control1: CGPoint(
                x: rect.width * 0.41,
                y: rect.height * 0.02
            ),
            control2: CGPoint(
                x: rect.width * 0.42,
                y: rect.height * 0.41
            )
        )
        
        path.addCurve(
            to: CGPoint(
                x: rect.width * 0.69,
                y: rect.height * 0.02
            ),
            control1: CGPoint(
                x: rect.width * 0.58,
                y: rect.height * 0.41
            ),
            control2: CGPoint(
                x: rect.width * 0.59,
                y: rect.height * 0.02
            )
        )
        
        path.addLine(to: CGPoint(x: rect.width * 0.84, y: rect.height * 0.001))
        
        path.addCurve(
            to: CGPoint(
                x: rect.width,
                y: rect.height * 0.428
            ),
            control1: CGPoint(
                x: rect.width * 0.95,
                y: rect.height * 0.001
            ),
            control2: CGPoint(
                x: rect.width * 0.95,
                y: rect.height * 0.18
            )
        )
        
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        return path
    }
}

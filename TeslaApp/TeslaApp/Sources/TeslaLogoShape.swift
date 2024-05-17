//
//  TeslaLogoShape.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 16.05.2024.
//

import SwiftUI

struct TeslaLogoShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        var startPoint = CGPoint(x: rect.width * 0.158, y: rect.height * 0.288)
        
        //upper shape
        path.move(to: startPoint)
        path.addCurve(
                    to: CGPoint(
                        x: rect.width * 0.84,
                        y: rect.height * 0.288
                    ),
                    control1: CGPoint(x: rect.width * 0.4, y: rect.height * 0.243),
                    control2: CGPoint(x: rect.width * 0.6, y: rect.height * 0.244)
                )
        path.addLine(to: CGPoint(x: rect.width * 0.818, y: rect.height * 0.31))
        path.addCurve(
                    to: CGPoint(
                        x: rect.width * 0.18,
                        y: rect.height * 0.31
                    ),
                    control1: CGPoint(x: rect.width * 0.6, y: rect.height * 0.265),
                    control2: CGPoint(x: rect.width * 0.4, y: rect.height * 0.265)
                )
        path.closeSubpath()
        
        //lower shape
        startPoint = CGPoint(x: rect.width * 0.185, y: rect.height * 0.317)
        path.move(to: startPoint)
        path.addCurve(
            to: CGPoint(
                x: rect.width * 0.43,
                y: rect.height * 0.287
            ),
            control1: CGPoint(
                x: rect.width * 0.2,
                y: rect.height * 0.315
            ),
            control2: CGPoint(
                x: rect.width * 0.3,
                y: rect.height * 0.29
            )
        )
        path.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.331))
        path.addLine(to: CGPoint(x: rect.width * 0.57, y: rect.height * 0.287))
    
        path.addCurve(
            to: CGPoint(
                x: rect.width * 0.813,
                y: rect.height * 0.318
            ),
            control1: CGPoint(
                x: rect.width * 0.65,
                y: rect.height * 0.29
            ),
            control2: CGPoint(
                x: rect.width * 0.71,
                y: rect.height * 0.296
            )
        )
        
        path.addCurve(
            to: CGPoint(
                x: rect.width * 0.713,
                y: rect.height * 0.356
            ),
            control1: CGPoint(
                x: rect.width * 0.77,
                y: rect.height * 0.345
            ),
            control2: CGPoint(
                x: rect.width * 0.74,
                y: rect.height * 0.35
            )
        )
        
        path.addCurve(
            to: CGPoint(
                x: rect.width * 0.596,
                y: rect.height * 0.329
            ),
            control1: CGPoint(
                x: rect.width * 0.716,
                y: rect.height * 0.328
            ),
            control2: CGPoint(
                x: rect.width * 0.65,
                y: rect.height * 0.33
            )
        )
        
        path.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.604))
        path.addLine(to: CGPoint(x: rect.width * 0.403, y: rect.height * 0.329))
        
        path.addCurve(
            to: CGPoint(
                x: rect.width * 0.286,
                y: rect.height * 0.356
            ),
            control1: CGPoint(
                x: rect.width * 0.3,
                y: rect.height * 0.328
            ),
            control2: CGPoint(
                x: rect.width * 0.29,
                y: rect.height * 0.336
            )
        )
        
        path.addCurve(
            to: startPoint,
            control1: CGPoint(
                x: rect.width * 0.22,
                y: rect.height * 0.343
            ),
            control2: CGPoint(
                x: rect.width * 0.2,
                y: rect.height * 0.328
                
            )
        )
        path.closeSubpath()
        return path
    }
}

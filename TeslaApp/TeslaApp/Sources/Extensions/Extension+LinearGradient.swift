//
//  Extension+LinearGradient.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 14.05.2024.
//

import SwiftUI

/// Добавляет акцентный градиент от светло-зеленого к светло-голубому
extension LinearGradient {
    
    /// Акцентный градиент от светло-зеленого к светло-голубому
    static var accentGradient = LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .top, endPoint: .bottom)
}

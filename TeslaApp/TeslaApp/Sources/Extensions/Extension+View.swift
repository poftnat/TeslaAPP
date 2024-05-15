//
//  Extension+View.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 14.05.2024.
//

import SwiftUI

extension View {
    
    /// Возвращает плоский выпуклый вью
    /// - Returns: вью с примененным модификатором
    func neumorfismNonSelectedStyle() -> some View {
        modifier(NonselectedShadowModifier())
    }
    
    /// Возвращает вогнутый вью
    /// - Returns: вью с примененным модификатором
    func neumorfismSelectedStyle() -> some View {
        modifier(SelectedShadowModifier())
    }
    
    /// Возвращает круглый вью
    /// - Returns: вью с примененным модификатором
    func neumorfismCircleStyle() -> some View {
        modifier(CircleShadowModifier())
    }
    
    /// Возвращает круглый вью под кнопку
    /// - Returns: вью с примененным модификатором
    func regularCircleBackground() -> some View {
        modifier(CircleButtonModifier())
    }
}

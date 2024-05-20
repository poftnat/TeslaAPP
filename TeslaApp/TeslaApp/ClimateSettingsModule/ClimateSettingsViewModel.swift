//
//  ClimateSettingsViewModel.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 14.05.2024.
//

import SwiftUI

/// Вью-модель экрана настроек климат-системы
final class ClimateSettingsViewModel: ObservableObject {
    
    @Published var acValue: Double = 15.0
    @Published var savedAcValue: Double = 15.0
    @Published var fanValue: Double = 15.0
    @Published var heatValue: Double = 15.0
    @Published var autoValue: Double = 15.0
    @Published var isOnACButtonTap = false
    
    func getSliderButtonImages() -> [String] {
        ["snowflake", "wind", "humidity.fill", "timer"]
    }
    
    func getSliderButtonTitles() -> [String] {
        ["Ac", "Fan", "Heat", "Auto"]
    }
}

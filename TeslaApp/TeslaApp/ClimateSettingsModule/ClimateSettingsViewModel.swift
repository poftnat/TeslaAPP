//
//  ClimateSettingsViewModel.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 14.05.2024.
//

import SwiftUI

final class ClimateSettingsViewModel: ObservableObject {
    
    @Published var acValue: Double = 0.0
    @Published var fanValue: Double = 0.0
    @Published var heatValue: Double = 0.0
    @Published var autoValue: Double = 0.0
    @Published var isOnACButtonTap = false
    
    
    func getSliderButtonImages() -> [String] {
        ["snowflake", "wind", "humidity.fill", "timer"]
    }
    
    func getSliderButtonTitles() -> [String] {
        ["Ac", "Fan", "Heat", "Auto"]
    }
    
    
    func getSliderBindings() -> [Published<Double>.Publisher] {
        [$acValue, $fanValue, $heatValue, $autoValue]
    }
}

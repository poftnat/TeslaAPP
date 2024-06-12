//
//  ChargerModel.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 18.05.2024.
//

import Foundation

/// Вью-модель экрана зарядки
final class ChargeViewModel: ObservableObject {
    
    func getMockData() -> [Charger] {
        let chargers = [
            Charger(type: "Tesla Supercharger", address: "Vologda, Revolutsii sq.", total: 4, free: 2, distance: 1.8),
            Charger(type: "Tesla Supercharger", address: "Vologda, Mira str.", total: 4, free: 1, distance: 1.2),
            Charger(type: "Tesla Supercharger", address: "Vologda, Revolutsii sq.", total: 4, free: 2, distance: 1.8),
            Charger(type: "Tesla Supercharger", address: "Vologda, Revolutsii sq.", total: 4, free: 2, distance: 1.8)
        ]
        return chargers
    }
}

//
//  ChargeModel.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 19.05.2024.
//

import Foundation

/// Описание станции зарядки
struct Charger: Identifiable {
    /// ID
    let id = UUID()
    /// Принадлежность
    let type: String
    /// Адрес
    let address: String
    /// Всего портов для зарядки
    let total: Int
    /// Свободных портов для зарядки
    let free: Int
    /// Дистанция до точки зарядки
    let distance: Double
}

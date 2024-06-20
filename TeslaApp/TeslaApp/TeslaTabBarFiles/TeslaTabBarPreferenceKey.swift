//
//  TeslaTabBarPreferenceKey.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 17.05.2024.
//

import SwiftUI

struct TabItemPreferenceKey: PreferenceKey {
    static var defaultValue: [TabItem] = []
    
    static func reduce(value: inout [TabItem], nextValue: () -> [TabItem]) {
        value += nextValue()
    }
}

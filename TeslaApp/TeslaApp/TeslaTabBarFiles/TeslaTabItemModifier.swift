//
//  TeslaTabItemModifier.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 17.05.2024.
//

import SwiftUI

struct TabItemModifier: ViewModifier {
    let tabbarItem: TabItem
    
    func body(content: Content) -> some View {
        content
            .preference(key: TabItemPreferenceKey.self, value: [tabbarItem])
    }
}

extension View {
    func teslaTabItem(_ label: () -> TabItem) -> some View {
         modifier(TabItemModifier(tabbarItem: label()))
    }
}

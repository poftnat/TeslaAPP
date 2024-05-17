//
//  TeslaTabView.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 16.05.2024.
//

import SwiftUI

/// Таб-бар
struct TeslaTabView: View {
    
    private enum Constants {
        static let carIcon = "car"
        static let chargeIcon = "bolt.fill"
        static let mappinIcon = "mappin.and.ellipse"
        static let accountIcon = "person.fill"
    }
    
    var body: some View {
        TeslaTabBar(selectedItem: $selectedItem) {
            MainView()
                .teslaTabItem {
                    TabItem(icon: Constants.carIcon)
                }
                .opacity(selectedItem == 0 ? 1 : 0)
                
            ChargeView()
                .teslaTabItem {
                    TabItem(icon: Constants.chargeIcon)
                }
                .opacity(selectedItem == 1 ? 1 : 0)
            
            Color.yellow
                .teslaTabItem {
                    TabItem(icon: Constants.mappinIcon)
                }
                .opacity(selectedItem == 2 ? 1 : 0)
            
            Color.yellow
                .teslaTabItem {
                    TabItem(icon: Constants.accountIcon)
                }
                .opacity(selectedItem == 3 ? 1 : 0)
        }
        .frame(maxHeight: .infinity)
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    @State private var selectedItem = 0
}

#Preview {
    TeslaTabView()
}

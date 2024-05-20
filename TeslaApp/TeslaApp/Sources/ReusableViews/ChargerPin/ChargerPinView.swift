//
//  ChargerPinView.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 20.05.2024.
//

import SwiftUI

/// Вью для использования в качестве маркера на экране зарядки
struct ChargerPinView: View {
    var body: some View {
        ZStack {
            ChargerMarker()
                .fill(LinearGradient.accentGradient)
                .frame(width: 30, height: 34)
            Image(systemName: "bolt.fill")
                .foregroundStyle(.black)
                .font(.system(size: 15))
                .offset(y: -2)
        }
        .frame(width: 34, height: 34)
    }
}

#Preview {
    ChargerPinView()
}

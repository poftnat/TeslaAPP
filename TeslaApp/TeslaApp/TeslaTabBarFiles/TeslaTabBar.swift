//
//  TeslaTabBar.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 17.05.2024.
//

import SwiftUI

struct TeslaTabBar<Content: View>: View {
    @Binding var selectedItem: Int
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
            HStack {
                tabItemViews
            }
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    TeslaTabBarShape()
                        .fill(.darkShadow)
                    TeslaTabBarShape()
                        .stroke(style: .init(lineWidth: 1))
                        .fill(.lightShadow)
                        .blur(radius: 1)
                }
                    .offset(y: 1)
            )
            .ignoresSafeArea(edges: .bottom)
            .shadow(radius: 8)
            .shadow(radius: 16)
        }
        .onPreferenceChange(TabItemPreferenceKey.self , perform: { value in
            self.tabs = value
        })
    }
    
    init(selectedItem: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.content = content()
        _selectedItem = selectedItem
    }
    
    @State private var tabs: [TabItem] = []
    @Namespace private var tabBarItem
    private var content: Content
    
    private var tabItemViews: some View {
        ForEach(Array(tabs.enumerated()), id: \.offset) { index, element in
            Spacer()
                Image(systemName: element.icon)
                .font(.system(size: 20))
                .scaleEffect(selectedItem == index ? 1.1 : 1)
            .foregroundStyle(selectedItem == index ? .gradientTop : .gray)
            .background(
                ZStack {
                    if selectedItem == index {
                            Circle()
                            .fill(.gradientTop.opacity(0.8))
                            .frame(width: 40, height: 40)
                            .blur(radius: 15)
                            .matchedGeometryEffect(id: "tabBarItem", in: tabBarItem, properties: .size)
                    }
                }
            )
            .onTapGesture {
                withAnimation {
                    selectedItem = index
                }
            }
            if index == 1 {
                Spacer().frame(width: UIScreen.main.bounds.width * 0.15)
            }
            Spacer()
        }
    }
}

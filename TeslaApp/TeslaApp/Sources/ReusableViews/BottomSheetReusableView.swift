//
//  BottomSheetReusableView.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 15.05.2024.
//

import SwiftUI

/// Переиспользуемый bottom sheet
struct BottomSheetReusableView<Content: View>: View {
    
    let content: () -> Content
    
    @Binding var isOpened: Bool
    
    @GestureState private var gestureOffset = CGSize.zero
    @State private var currentMenuOffsetY: CGFloat = 0
    @State private var lastMenuOffsetY: CGFloat = 0
    
    private var dragGesture: some Gesture {
        DragGesture()
            .updating($gestureOffset) { value, state, transaction in
                state = value.translation
                onChangeMenuOffset()
            }
            .onEnded { _ in
                let maxHeight = UIScreen.main.bounds.height * 0.25
                withAnimation {
                    if -currentMenuOffsetY > maxHeight / 2 {
                        currentMenuOffsetY = -maxHeight
                        isOpened = true
                    } else {
                        currentMenuOffsetY = 0
                        isOpened = false
                    }
                    
                }
            }
    }
    
    var body: some View {
        ZStack {
            content()
                .frame(height: UIScreen.main.bounds.height)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.darkShadow)
                        .ignoresSafeArea(.all, edges: .bottom)
                )
                .offset(y: UIScreen.main.bounds.height - 40)
                .offset(y: currentMenuOffsetY)
                .gesture(dragGesture)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    func onChangeMenuOffset() {
        DispatchQueue.main.async {
            self.currentMenuOffsetY = gestureOffset.height + lastMenuOffsetY
        }
    }
}


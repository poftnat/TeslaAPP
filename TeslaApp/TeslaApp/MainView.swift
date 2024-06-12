//
//  ContentView.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 13.05.2024.
//

import SwiftUI

struct MainView: View {
    
    private enum Constants {
        static let personImageName = "person.fill"
        static let teslaText = "Tesla"
        static let mileageText = "189 km"
        static let batteryText = "battery.75percent"
        static let closedMainImage = "closeCar"
        static let openMainImage = "car"
        static let unlockText = "Unlock"
        static let lockText = "Lock"
        static let unlockImageName = "lock.open.fill"
        static let lockImageName = "lock.fill"
    }
    
    var body: some View {
        backgroundStackView {
            VStack {
                HStack {
                    headerView
                    NavigationLink(destination: UnlockView()) {
                        Image(systemName: Constants.personImageName)
                            .regularCircleBackground()
                            .neumorfismNonSelectedStyle()
                        .padding(.trailing, 20)
                    }
                }
                carView
                controlPanelView
                Spacer()
                if tagSelected == 1 {
                    CarLockerView(isCarClosed: $isCarClosed)
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    @State private var isCarClosed = false
    @State private var tagSelected = 0
    
    private var controlPanelView: some View {
        HStack(spacing: 30) {
            ForEach(1..<5) { index in
                Button(action: {
                    withAnimation {
                        tagSelected = index
                    }
                }, label: {
                    if index == 2 {
                        NavigationLink(destination: ClimateSettingsView()) {
                            createPanelButton(index: index, tagSelected: $tagSelected)
                        }
                    } else {
                        createPanelButton(index: index, tagSelected: $tagSelected)
                    }
                })
                
            }
        }
        .padding()
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 50).fill(.basic)
                RoundedRectangle(cornerRadius: 50)
                    .stroke(style: .init(lineWidth: 4))
                    .fill(LinearGradient(colors: [.darkShadow, .lightShadow], startPoint: .top, endPoint: .bottomTrailing))
                    .blur(radius: 6)
            }
        )
        .neumorfismNonSelectedStyle()
    }
    
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(Constants.teslaText)
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .foregroundStyle(.textcolor)
                Label {
                    Text(Constants.mileageText)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .opacity(0.4)
                } icon: {
                    Image(systemName: Constants.batteryText)
                        .foregroundStyle(.gray)
                }
            }
            Spacer()
        }
        .padding(.all, 25)
    }
    
    private var carView: some View {
        Image(isCarClosed ? Constants.closedMainImage : Constants.openMainImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 150)
            .padding(.horizontal)
            .padding(.bottom, 40)
            .shadow(color: .textcolor.opacity(0.5), radius: 15, x: 10, y: 10)
    }
    
    private func createPanelButton(index: Int, tagSelected: Binding<Int>) -> some View {
        Image("\(index)")
            .resizable()
            .frame(width: 20, height: 20)
            .padding()
            .overlay(
                Circle()
                    .stroke(LinearGradient.accentGradient, lineWidth: 2)
                    .opacity($tagSelected.wrappedValue == index ? 1 : 0)
            )
    }
    
    private func backgroundStackView<Content: View>(content: () -> Content) -> some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(stops: [.init(color: .topPageBackground, location: 0), .init(color: .darkShadow, location: 1)], startPoint: .top, endPoint: .bottom)
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
            Rectangle()
                .fill(
                    LinearGradient(stops: [.init(color: .lightShadow.opacity(0.45), location: 0.4), .init(color: .lightShadow.opacity(0), location: 0.99)], startPoint: .topTrailing, endPoint: .bottomLeading)
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
            content()
        }
    }
}

#Preview {
    MainView()
}

//
//  ChargeView.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 17.05.2024.
//

import SwiftUI

/// Экран зарядки
struct ChargeView: View {
    
    private enum Constants {
        static let carImageName = "charging car"
        static let backButtonImageName = "chevron.left"
        static let settingsImageName = "gearshape"
        static let chargingTitleText = "CHARGING"
        static let avenirBoldFontName = "Avenir-Bold"
        static let verdanaBoldFontName = "Verdana-Bold"
        static let percentPostfix = "%"
        static let setChargeLimitText = "Set Charge Limit"
        static let nearbySuperchargersText = "Nearby Superchargers"
        static let upButton = "chevron.up"
        static let downButton = "chevron.down"
        static let chargeValueFormatRule = "%2.1f"
        static let kmPostfix = " km"
    }
    var body: some View {
        backgroundStackView {
            ZStack(alignment: .top)  {
                navigationView
                ScrollView(.vertical, showsIndicators: false) {
                        Spacer()
                            .frame(height: 120)
                        Image(Constants.carImageName)
                            .frame(height: 110)
                        batteryView
                        sliderView
                        nearbySuperchargesView
                        Spacer().frame(height: 100)
                    }
                    .menuIndicator(.hidden)
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    @Environment (\.dismiss) private var dismiss
    @ObservedObject private var viewModel = ChargeViewModel()
    @State private var chargeValue: Double = 0.65
    @State private var chargeLimitValue: Double = 0.75
    @State private var color = Color.gradientTop
    @State private var isChargersViewExpanded = false
    
    private var navigationView: some View {
        HStack {
            backButton
            Spacer()
            settingsTitle
            Spacer()
            settingsButton
        }
        .frame(height: 110)
        .zIndex(1)
        .background(
            ZStack {
                Rectangle()
                    .fill(LinearGradient(colors: [.basic, .clear], startPoint: .top, endPoint: .bottom))
                Rectangle()
                    .fill(LinearGradient(colors: [.lightShadow.opacity(0.4), .clear], startPoint: .top, endPoint: .bottom))
            }
        )
        .ignoresSafeArea(.all, edges: .top)
    }
    
    private var backButton: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: Constants.backButtonImageName)
                .regularCircleBackground()
                .neumorfismNonSelectedStyle()
        })
        .padding(.horizontal, 20)
    }
    
    private var settingsButton: some View {
        Button(action: {
            // TODO: - action?
        }, label: {
            Image(systemName: Constants.settingsImageName)
                .regularCircleBackground()
                .neumorfismNonSelectedStyle()
            
        })
        .padding(.horizontal, 20)
    }
    
    private var settingsTitle: some View {
        Text(Constants.chargingTitleText)
            .font(.custom(Constants.avenirBoldFontName, size: 22))
    }
    
    private var batteryView: some View {
        VStack {
            Text("\(Int(chargeValue * 100))")
                .font(.custom(Constants.verdanaBoldFontName, size: 32))
            +
            Text(Constants.percentPostfix)
            
            ZStack(alignment: .bottom) {
                Battery()
                    .fill(
                        LinearGradient(stops: [.init(color: .lightShadow, location: 0), .init(color: .basic, location: 0.4), .init(color: .darkShadow, location: 0.6), .init(color: .lightShadow.opacity(0.6), location: 1)], startPoint: .top, endPoint: .bottom)
                    )
                Battery()
                    .stroke(style: .init(lineWidth: 1, lineJoin: .round))
                    .fill(.basic)
                    .blur(radius: 6)
                ActiveBattery()
                    .fill(LinearGradient.accentGradient)
                    .shadow(color: .white.opacity(0.6), radius: 4)
                    .shadow(color: .gradientBottom, radius: 60)
                ActiveBattery()
                    .stroke(style: .init(lineWidth: 4))
                    .fill(LinearGradient.accentGradient)
                    .blur(radius: 3)
                    .shadow(color: .white.opacity(0.6), radius: 4)
                    .shadow(color: .gradientBottom, radius: 60)
            }
            .overlay {
                Rectangle()
                    .fill(LinearGradient(colors: [.gradientTop.opacity(0.1), .clear], startPoint: .bottom, endPoint: .top))
                    .frame(width: 215, height: 200)
                    .blur(radius: 7)
                    .shadow(color: .gradientTop, radius: 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(y: -60)
            }
            .frame(height: 55)
            .padding(.horizontal, 30)
        }

    }
    
    private var sliderView: some View {
        VStack {
            TriangleSlider(value: $chargeLimitValue)
            Text(Constants.setChargeLimitText)
                .foregroundStyle(.icon)
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 20)
    }
    
    private var nearbySuperchargesView: some View {
        VStack {
            HStack {
                Text(Constants.nearbySuperchargersText)
                    .font(.custom(Constants.verdanaBoldFontName, size: 20))
                Spacer()
                Button {
                    withAnimation {
                        isChargersViewExpanded.toggle()
                    }
                } label: {
                    Image(systemName: isChargersViewExpanded ? Constants.downButton : Constants.upButton)
                        .font(.system(size: 18))
                        .offset(y: 2)
                        .regularCircleBackground()
                        .neumorfismNonSelectedStyle()
                }
            }
            .padding(.horizontal)
            .padding(.top, isChargersViewExpanded ? 40 : 0)
            if isChargersViewExpanded {
                VStack {
                    ForEach(viewModel.getMockData(), id: \.id) { element in
                        makeNearbyChargerInfoView(with: element)
                    }
                }
                .padding(.bottom, 40)
            }
        }
        .frame(minHeight: isChargersViewExpanded ? 300 : 130)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 32)
                    .fill(.basic)
                    .frame(width: .infinity, height: .infinity)
                RoundedRectangle(cornerRadius: 32)
                    .stroke(style: .init(lineWidth: 5))
                    .fill(LinearGradient(colors: [.darkShadow, .lightShadow], startPoint: .top, endPoint: .bottom))
                    .blur(radius: 8)
                RoundedRectangle(cornerRadius: 32)
                    .stroke(style: .init(lineWidth: 5))
                    .fill(LinearGradient(colors: [.darkShadow, .basic.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .blur(radius: 5)
            }
                .clipShape(.rect(cornerRadius: 32))
        )
        .padding(.horizontal)
        
    }
    
    private func checkLimitValueStatus() -> Bool {
        chargeValue < chargeLimitValue
    }
    
    private func makeNearbyChargerInfoView(with element: Charger) -> some View {
        VStack {
            HStack {
                Text("\(element.type) -\n\(element.address)")
                    .frame(width: 200, height: 50, alignment: .leading)
                Spacer()
                ChargerPinView()
                    
            }
            HStack {
                Text("\(element.free)")
                    .foregroundColor(.white)
                +
                Text(" / \(element.total) available")
                    .foregroundColor(.icon)
                Spacer()
                Text("\(String(format: Constants.chargeValueFormatRule, element.distance))\(Constants.kmPostfix)")
            }
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
    }
    
    private func backgroundStackView<Content: View>(content: () -> Content ) -> some View {
        ZStack {
            Rectangle()
                .fill(
                    Color.topPageBackground.opacity(0.6)
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
            Rectangle()
                .fill(
                    LinearGradient(stops: [.init(color: .lightShadow.opacity(0.4), location: 0.4), .init(color: .lightShadow.opacity(0.2), location: 0.99)], startPoint: .topTrailing, endPoint: .bottomLeading)
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
            content()
        }
    }
}

#Preview {
    ChargeView()
}

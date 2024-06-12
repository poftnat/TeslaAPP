//
//  ClimateSettingsView.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 14.05.2024.
//

import SwiftUI

/// Экран настроек климат-системы
struct ClimateSettingsView: View {
    
    private enum Constants {
        static let backButtonImageName = "chevron.left"
        static let settingsButtonImageName = "gearshape"
        static let climateTitleText = "CLIMATE"
        static let avenirBoldFontName = "Avenir-Bold"
        static let climateDisclosureText = "Air conditioner settings"
        static let climateDisclosureIconName = "fanblades"
        static let celsiumPostfixText = "˚ C"
        static let degreesFormatRule = "%2.f"
    }
    var body: some View {
        backgroundStackView {
            ZStack(alignment: .top)  {
                navigationView
                        ScrollView(.vertical, showsIndicators: false) {
                        Spacer().frame(height: 120)
                        progressBar
                        Spacer().frame(height: 30)
                        acSettingsGroup
                            .padding()
                            .blur(radius: isBottomSheetOpened ? 1 : 0)
                        Spacer().frame(height: 120)
                }
                bottomSheetView
                if isAlertButtonTapped {
                    supportAlertView
                        .transition(.move(edge: .top))
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    @Environment (\.dismiss) private var dismiss
    @ObservedObject private var viewModel = ClimateSettingsViewModel()
    @State private var isGroupExpanded = true
    @State private var isBottomSheetOpened = false
    @State private var isAlertButtonTapped = false
    @State private var selectedColor: Color = .gradientBottom
    
    private var navigationView: some View {
        HStack  {
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
                    .fill(LinearGradient(colors: [.basic.opacity(0.5), .clear], startPoint: .top, endPoint: .bottom))
                Rectangle()
                    .fill(LinearGradient(colors: [.lightShadow.opacity(0.3), .clear], startPoint: .top, endPoint: .bottom))
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
            withAnimation(.linear(duration: 0.3)) {
                isAlertButtonTapped.toggle()
            }
        }, label: {
            Image(systemName: Constants.settingsButtonImageName)
                .regularCircleBackground()
                .neumorfismNonSelectedStyle()
        })
        .padding(.horizontal, 20)
    }
    
    private var settingsTitle: some View {
        Text(Constants.climateTitleText)
            .font(.custom(Constants.avenirBoldFontName, size: 22))
    }
    
    private var acSettingsGroup: some View {
        DisclosureGroup(isExpanded: $isGroupExpanded) {
            HStack {
                VStack {
                    ForEach(0..<viewModel.getSliderButtonTitles().count, id: \.self) { element in
                        makeSliderElement(text: viewModel.getSliderButtonTitles()[element], imageName: viewModel.getSliderButtonImages()[element])
                    }
                }
                VStack {
                    DarkSlider(value: $viewModel.acValue, color: $selectedColor, sliderRange: 15...30, step: 1)
                        .disabled(!viewModel.isOnACButtonTap)
                    DarkSlider(value: $viewModel.fanValue, color: $selectedColor, sliderRange: 15...30, step: 1)
                        .disabled(!viewModel.isOnACButtonTap)
                    DarkSlider(value: $viewModel.heatValue, color: $selectedColor, sliderRange: 15...30, step: 1)
                        .disabled(!viewModel.isOnACButtonTap)
                    DarkSlider(value: $viewModel.autoValue, color: $selectedColor, sliderRange: 15...30, step: 1)
                        .disabled(!viewModel.isOnACButtonTap)
                }
                .padding(.horizontal, 20)
            }
        } label: {
            Label(
                title: {
                    Text(Constants.climateDisclosureText)
                }, icon: {
                    Image(systemName: Constants.climateDisclosureIconName) }
            )
            .foregroundStyle(.labelSecondary)
            .padding(.vertical, 20)
        }
        .padding(.bottom, isGroupExpanded ? 0 : 230)
    }
    
    private var progressBar: some View {
        ZStack {
            CircleProgressBar(progress: $viewModel.acValue, maxValue: 30, minValue: 15, color: selectedColor)
            Text(viewModel.isOnACButtonTap ? "\(String(format: Constants.degreesFormatRule, viewModel.acValue))\(Constants.celsiumPostfixText)" : "")
                .font(.custom(Constants.avenirBoldFontName, size: 26))
                .opacity(viewModel.isOnACButtonTap ? 1 : 0)
        }
        .clipShape(Circle())
        .shadow(color: viewModel.isOnACButtonTap ? selectedColor.opacity(0.3) : .black, radius: 40, x: 0, y: 0)
        .shadow(color: .lightShadow, radius: 8, x: -8, y: -8)
        .shadow(color: .darkShadow, radius: 8, x: 8, y: 8)
    }
    
    private var bottomSheetView: some View {
        BottomSheetReusableView(content: {
            ClimateBottomSheetView(isACOn: $viewModel.isOnACButtonTap, selectedColor: $selectedColor, value: $viewModel.acValue, savedValue: $viewModel.savedAcValue, range: 15...30)
        }, isOpened: $isBottomSheetOpened)
        .offset(y: -80)
    }
    
    private var supportAlertView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.darkShadow.opacity(0.8))
            VStack(spacing: 10) {
                Text("Any questions?")
                Text("Contact support team via")
                Link(destination: URL(string: "https://www.tesla.com/support")!, label: {
                    Label {
                        Text("Tesla Support")
                    } icon: {
                        Image("logo")
                            .resizable()
                            .frame(width: 20, height: 30)
                    }
                })
                Button {
                    isAlertButtonTapped = false
                } label: {
                    Text("Ok")
                }

            }
        }
        .frame(width: 250, height: 200)
        .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
    }
    
    private func backgroundStackView<Content: View>(content: () -> Content ) -> some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(stops: [.init(color: .topPageBackground, location: 0), .init(color: .darkShadow, location: 1)], startPoint: .top, endPoint: .bottom)
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
            Rectangle()
                .fill(
                    LinearGradient(stops: [.init(color: .lightShadow.opacity(0.4), location: 0.4), .init(color: .lightShadow.opacity(0), location: 0.99)], startPoint: .topTrailing, endPoint: .bottomLeading)
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
            content()
        }
    }
    
    private func makeSliderElement(text: String, imageName: String) -> some View {
        HStack(spacing: 20) {
            Text(text)
                .foregroundStyle(.labelSecondary)
                .frame(width: 40)
            if !viewModel.isOnACButtonTap {
                Image(systemName: imageName)
                    .regularCircleBackground()
                    .shadow(color: .darkShadow, radius: 8, x: 3, y: 3)
            } else {
                Image(systemName: imageName)
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
                    .frame(width: 50, height: 50)
                    .background(
                        ZStack {
                            RadialGradient(colors: [.activeButtonBottom, .white.opacity(0.7)], center: .topLeading, startRadius: 40, endRadius: 0)
                            Circle()
                                .fill(LinearGradient(colors: [.activeButtonTop, .darkShadow.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .blur(radius: 8)
                                .padding(2)
                            Circle()
                                .stroke(style: StrokeStyle(lineWidth: 1))
                                .fill(.gradientTop)
                        }
                            .clipShape(Circle())
                    )
            }
        }
    }
}

#Preview {
    ClimateSettingsView()
}

//
//  ClimateSettingsView.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 14.05.2024.
//

import SwiftUI

struct ClimateSettingsView: View {
    var body: some View {
        backgroundStackView {
            ZStack(alignment: .top)  {
                VStack {
                    Spacer().frame(height: 45)
                    HStack  {
                        backButton
                        Spacer()
                        settingsTitle
                        Spacer()
                        settingsButton
                    }
                    ScrollView {
                        Spacer().frame(height: 100)
                        progressBar
                        Spacer().frame(height: 50)
                        acSettingsGroup
                            .padding()
                            .blur(radius: isBottomSheetOpened ? 2 : 0)
                        Spacer().frame(height: 120)
                    }
                }
                
                BottomSheetReusableView(content: {
                    ClimateBottomSheetView(isACOn: $isACOn, selectedColor: $selectedColor, value: $acValue, range: 15...30)
                }, isOpened: $isBottomSheetOpened)
                .offset(y: -80)
            }
        }
        .onAppear(perform: {
            
        })
        .navigationBarBackButtonHidden()
    }
    
    @Environment (\.dismiss) private var dismiss
    @ObservedObject private var viewModel = ClimateSettingsViewModel()
    @State private var isACOn = false {
        didSet {
            if !isACOn {
                acValue = 15
            }
        }
    }
    @State private var acValue = 15.0
    @State private var fanValue = 15.0
    @State private var heatValue = 15.0
    @State private var autoValue = 15.0
    @State private var isGroupExpanded = true
    @State private var isBottomSheetOpened = false
    @State private var selectedColor: Color = .gradientBottom
    
    private var backButton: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "chevron.left")
                .regularCircleBackground()
                .neumorfismNonSelectedStyle()
        })
        .padding(.horizontal, 20)
    }
    
    private var settingsButton: some View {
        Button(action: {
            // TODO: - action?
        }, label: {
            Image(systemName: "gearshape")
                .regularCircleBackground()
                .neumorfismNonSelectedStyle()
            
        })
        .padding(.horizontal, 20)
    }
    
    private var settingsTitle: some View {
        Text("CLIMATE")
            .font(.custom("Avenir-Bold", size: 22))
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
                    DarkSlider(value: $acValue, color: $selectedColor, sliderRange: 15...30, step: 1)
                    DarkSlider(value: $fanValue, color: $selectedColor, sliderRange: 15...30, step: 1)
                    DarkSlider(value: $heatValue, color: $selectedColor, sliderRange: 15...30, step: 1)
                    DarkSlider(value: $autoValue, color: $selectedColor, sliderRange: 15...30, step: 1)
                }
                .padding(.horizontal, 20)
            }
        } label: {
            Label(
                title: {
                    Text("Air conditioner settings")
                }, icon: {
                    Image(systemName: "fanblades") }
            )
            .foregroundStyle(.labelSecondary)
            .padding(.vertical, 20)
        }
        .padding(.bottom, isGroupExpanded ? 0 : 230)
    }
    
    private var progressBar: some View {
        ZStack {
            CircleProgressBar(progress: $acValue, maxValue: 30, minValue: 15, color: selectedColor)
            Text("\(String(format: "%2.f", acValue))˚ C")
                .font(.custom("Avenir-Bold", size: 26))
                .opacity(isACOn ? 1 : 0)
        }
        .clipShape(Circle())
        
        .shadow(color: isACOn ? selectedColor.opacity(0.3) : .black, radius: 60, x: 0, y: 0)
        .shadow(color: .lightShadow, radius: 8, x: -8, y: -8)
        .shadow(color: .darkShadow, radius: 8, x: 8, y: 8)
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
            Button(action: {
                //TODO: - action
            }, label: {
                if $acValue.wrappedValue == 15 {
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
            })
        }
    }
}

#Preview {
    ClimateSettingsView()
}

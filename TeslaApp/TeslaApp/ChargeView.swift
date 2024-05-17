//
//  ChargeView.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 17.05.2024.
//

import SwiftUI

struct Battery: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height * 0.5))
            path.addLine(to: CGPoint(x: rect.width * 0.1, y: 0))
            path.addLine(to: CGPoint(x: rect.width * 0.9, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height * 0.5))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.closeSubpath()
        }
    }
}

struct ActiveBattery: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height * 0.5))
            path.addLine(to: CGPoint(x: rect.width * 0.1, y: 0))
            path.addLine(to: CGPoint(x: rect.width * 0.6, y: 0))
            path.addLine(to: CGPoint(x: rect.width * 0.7, y: rect.height * 0.5))
            path.addLine(to: CGPoint(x: rect.width * 0.7, y: rect.height))
            path.closeSubpath()
        }
    }
}


struct ChargeView: View {
    var body: some View {
        backgroundStackView {
            ZStack(alignment: .top)  {
                VStack {
                    HStack  {
                        backButton
                        Spacer()
                        settingsTitle
                        Spacer()
                        settingsButton
                    }
                    Spacer().frame(height: 50)
                    Image("charging car")
                        .frame(height: 110)
                    batteryView
                    Spacer()
                }
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        
    }
    
    @Environment (\.dismiss) private var dismiss
    @State private var chargeValue: Double = 0.65
    @State private var color = Color.gradientTop
    
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
        Text("CHARGING")
            .font(.custom("Avenir-Bold", size: 22))
    }
    
    private var batteryView: some View {
        VStack {
            Text("65")
                .font(.custom("Avenir-Bold", size: 36))
            +
            Text("%")
                .foregroundStyle(.labelSecondary)
                .font(.custom("Avenir-Bold", size: 20))
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
                    .shadow(color: .white.opacity(0.6), radius: 8)
            }
            .overlay {
                Rectangle()
                    .fill(LinearGradient(colors: [.gradientTop.opacity(0.1), .basic.opacity(0.1)], startPoint: .bottom, endPoint: .top))
                    .frame(width: 260, height: 100)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(y: -60)
            }
            .frame(height: 80)
            .padding(.horizontal, 10)
            HStack {
                Spacer()
                VStack {
                    HStack {
                        Rectangle()
                            .fill(LinearGradient.accentGradient)
                            .frame(width: 3, height: 10)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    Text("75%")
                        .font(.custom("Avenir", size: 16))
                        .opacity(chargeValue >= 0.75 && chargeValue < 1 ? 1 : 0.7)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .scaleEffect(chargeValue >= 0.75 && chargeValue < 1 ? 1.1 : 1)
                .frame(width: 50, height: 50)
                .padding(.trailing, 10)
                VStack {
                    HStack {
                        Rectangle()
                            .fill(LinearGradient.accentGradient)
                            .frame(width: 3, height: 10)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    Text("100%")
                        .font(.custom("Avenir", size: 16))
                        .opacity(chargeValue == 1 ? 1 : 0.7)

                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
                }
                .frame(width: 50, height: 50)
                .padding(.trailing, 10)
            }
            DarkSlider(
                value: $chargeValue,
                color: $color,
                sliderRange: 0...1,
                step: 0.05
            )
            .frame(height: 40)
            .padding(.horizontal, 20)
            Text("Set charge limit")
                .foregroundStyle(.icon)
                .font(.custom("Avenir", size: 16))
            
        }
    }
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


#Preview {
    ChargeView()
}

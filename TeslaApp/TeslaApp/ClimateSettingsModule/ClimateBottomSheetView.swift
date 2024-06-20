//
//  ClimateBottomSheetView.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 20.05.2024.
//

import SwiftUI

struct ClimateBottomSheetView: View {
    
    private enum Constants {
        static let acOn = "A/C is ON"
        static let acOff = "A/C is OFF"
        static let subtitleText = "Tap to turn off or swipe up for a fast setup"
        static let powerButtonName = "power"
        static let docImageName = "doc.fill"
        static let degreesFormatRule = "%2.f˚"
        static let decreaseButtonImage = "chevron.left"
        static let increaseButtonImage = "chevron.right"
        static let avenirBoldFontName = "Avenir-Bold"
        static let onText = "On"
        static let ventText = "Vent"
    }
    
    @Binding var isACOn: Bool
    @Binding var selectedColor: Color
    @Binding var value: Double
    @Binding var savedValue: Double
    var range: ClosedRange<Double>
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.darkShadow)
                .frame(width: 100, height: 3)
                .padding(.bottom, 10)
            HStack {
                VStack {
                    Text(isACOn ? Constants.acOn: Constants.acOff)
                        .font(.custom(Constants.avenirBoldFontName, size: 22))
                        .foregroundStyle(isACOn ? .white : .labelSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(Constants.subtitleText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.lightShadow.opacity(0.6))
                }
                powerButton
            }
            Spacer().frame(height: 30)
            optionSelectorsView
            Spacer().frame(height: 30)
            optionsView
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
        .background(
            LinearGradient(colors: [.lightShadow, .darkShadow], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
    
    private var powerButton: some View {
        Button(action: {
            withAnimation {
                isACOn.toggle()
                if value != 15 {
                    savedValue = value
                }
                value = isACOn ? savedValue : 15
            }
        }, label: {
            Image(systemName: Constants.powerButtonName)
                .frame(width: 55, height: 55)
                .foregroundStyle(isACOn ? .white : .lightShadow)
                .background(
                    ZStack {
                        Circle()
                            .fill(LinearGradient(colors: [.activeButtonBottom, .activeButtonTop], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 6, x: 2, y: 2)
                        Circle()
                            .stroke(style: .init(lineWidth: 3))
                            .fill(LinearGradient(colors: [.darkBlue, .activeButtonTop], startPoint: .leading, endPoint: .trailing))
                            .blur(radius: 6)
                            .frame(width: 47, height: 47)
                        Circle()
                            .stroke(style: .init(lineWidth: 2))
                            .fill(LinearGradient(colors: [.activeButtonTop, .activeButtonBottom], startPoint: .topLeading, endPoint: .bottomTrailing))
                    }
                )
        })
        .padding(.horizontal, 10)
    }
    
    private var optionSelectorsView: some View {
        HStack {
            ColorPicker("", selection: $selectedColor)
                .frame(width: 40, height: 40)
            Spacer()
            stepperView
            Spacer()
            Image(systemName: Constants.docImageName)
                .foregroundStyle(.icon)
                .padding(.trailing, 10)
        }
        .frame(maxWidth: .infinity)
        .background(
            RadialGradient(colors: [selectedColor.opacity(0.2), .darkShadow.opacity(0.6)], center: .center, startRadius: 10, endRadius: 200)
                .blur(radius: 30)
        )
    }
    
    private var stepperView: some View {
        HStack {
            Button(action: {
                if value > range.lowerBound {
                    value -= 1
                }
            }, label: {
                Image(systemName: Constants.decreaseButtonImage)
                    .font(.system(size: 14))
                    .frame(width: 20, height: 40)
                    .shadow(color: selectedColor, radius: 20)
            })
            .disabled(!isACOn)
            Spacer()
            Text(String(format: Constants.degreesFormatRule, isACOn ? value : savedValue))
                .foregroundStyle(.white)
                .font(.custom(Constants.avenirBoldFontName, size: 32))
                .offset(x: 3)
            Spacer()
            Button(action: {
                if value < range.upperBound {
                    value += 1
                }
            }, label: {
                Image(systemName: Constants.increaseButtonImage)
                    .font(.system(size: 14))
                    .frame(width: 20, height: 40)
                    .shadow(color: selectedColor, radius: 20)
            })
            .disabled(!isACOn)
            
        }
        .shadow(color: selectedColor, radius: 50)
        .padding(.horizontal, 5)
        .frame(width: 140, height: 48)
        .foregroundStyle(.icon)
    }
    
    private var optionsView: some View {
        HStack {
            Text(Constants.onText)
            Spacer()
            Text(Constants.ventText)
        }
        .foregroundStyle(.icon)
        .padding(.horizontal, 10)
    }
}

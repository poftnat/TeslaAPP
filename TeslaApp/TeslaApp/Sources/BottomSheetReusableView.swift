//
//  BottomSheetReusableView.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 15.05.2024.
//

import SwiftUI

struct ClimateBottomSheetTestView: View {
    @State var isACOn = false {
        didSet {
            if !isACOn {
                selectedColor = .darkShadow
            }
        }
    }
    @State var selectedColor: Color = .white
    
    @State var value = 15.000 {
        didSet {
            if value > 30 && value < 15 {
                value = 4
            }
        }
    }
    
    var body: some View {
        ClimateBottomSheetView(isACOn: $isACOn, selectedColor: $selectedColor, value: $value, range: 15...30)
    }
    
}

struct ClimateBottomSheetView: View {
    
    @Binding var isACOn: Bool
    @Binding var selectedColor: Color
    @Binding var value: Double
    var range: ClosedRange<Double>
    
    var body: some View {
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.darkShadow)
                        .frame(width: 100, height: 3)
                        .padding(.bottom, 10)
                    HStack {
                        VStack {
                            Text(isACOn ? "A/C is ON" : "A/C is OFF")
                                .font(.custom("Avenir-Bold", size: 22))
                                .foregroundStyle(isACOn ? .white : .labelSecondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Tap to turn off or swipe up for a fast setup")
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
            }
        }, label: {
            Image(systemName: "power")
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
            Image(systemName: "doc.fill")
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
                Image(systemName: "chevron.left")
                        .font(.system(size: 14))
                        .frame(width: 20, height: 40)
                        .shadow(color: selectedColor, radius: 20)
            })
            Spacer()
            Text(String(format: "%2.f˚", value))
                .foregroundStyle(.white)
                .font(.custom("Avenir-Bold", size: 32))
                .offset(x: 3)
            Spacer()
            Button(action: {
                if value < range.upperBound {
                    value += 1
                }
            }, label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .frame(width: 20, height: 40)
                    .shadow(color: selectedColor, radius: 20)


            })
        }
        .shadow(color: selectedColor, radius: 50)
        .padding(.horizontal, 5)
        .frame(width: 140, height: 48)
        .foregroundStyle(.icon)
    }
    
    private var optionsView: some View {
        HStack {
            Text("On")
            Spacer()
            Text("Vent")
        }
        .foregroundStyle(.icon)
        .padding(.horizontal, 10)
    }
}

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
                    let maxHeight = UIScreen.main.bounds.height * 0.3
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

#Preview {
    ClimateBottomSheetTestView()
}

//
//  ContentView.swift
//  TeslaApp
//
//  Created by Наталья Владимировна Пофтальная on 13.05.2024.
//

import SwiftUI

struct MainView: View {
    
    @State var isCarClosed = false
    @State var tagSelected = 0
    
    var body: some View {
        backgroundStackView {
            VStack {
                HStack {
                    headerView
                    NavigationLink(destination: UnlockView()) {
                        Image(systemName: "person.fill")
                            .regularCircleBackground()
                        .padding(.trailing, 20)
                    }
                }
                carView
                controlPanelView
                Spacer()
                if tagSelected == 1 {
                    lockCarView
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    var gradient: LinearGradient {
        LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .top, endPoint: .bottom)
    }
    
    var backgroundGradient: LinearGradient {
        LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .top, endPoint: .bottom)
    }
    
    var controlPanelView: some View {
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
//                    Image("\(index)")
//                        .resizable()
//                        .frame(width: 20, height: 20)
//                        .padding()
//                        .overlay(
//                            Circle()
//                                .stroke(gradient, lineWidth: 2)
//                                .opacity(tagSelected == index ? 1 : 0)
//                        )
                })
                
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 50).fill(.basic))
        .neumorfismNonSelectedStyle()
    }
    
    private func createPanelButton(index: Int, tagSelected: Binding<Int>) -> some View {
        Image("\(index)")
            .resizable()
            .frame(width: 20, height: 20)
            .padding()
            .overlay(
                Circle()
                    .stroke(gradient, lineWidth: 2)
                    .opacity($tagSelected.wrappedValue == index ? 1 : 0)
            )
    }
    
    var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
            Text("Tesla")
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .foregroundStyle(.textcolor)
                Label {
                    Text("189 km")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .opacity(0.4)
                } icon: {
                    Image(systemName: "battery.75percent")
                        .foregroundStyle(.gray)
                }
            }
            Spacer()
        }
        .padding(.all, 25)
    }
    
    var carView: some View {
        Image(isCarClosed ? "closeCar" : "car")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 150)
            .padding(.horizontal)
            .padding(.bottom, 40)
            .shadow(color: .textcolor.opacity(0.5), radius: 15, x: 10, y: 10)
    }
    
    private var lockCarView: some View {
        Button {
            withAnimation() {
                isCarClosed.toggle()
            }
        } label: {
            HStack {
                Label {
                    Text(isCarClosed ? "Unlock" : "Lock")
                } icon: {
                    Image(systemName: isCarClosed ? "lock.open.fill" : "lock.fill")
                        .renderingMode(.template)
                        .neumorfismCircleStyle()
                }

            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 50).fill(.basic))
            .neumorfismSelectedStyle()
        }
        .frame(width: 300)
    }
    
    func backgroundStackView<Content: View>(content: () -> Content ) -> some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(colors: [.white.opacity(0.3), .basic, .basic], startPoint: .top, endPoint: .bottom))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
            content()
        }
    }
}

#Preview {
    MainView()
}

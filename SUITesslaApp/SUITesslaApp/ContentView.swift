//
//  ContentView.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 31.01.2023.
//

import SwiftUI



struct ContentView: View {

    @State var isCarClosed = false
    @State var tagSelected = 0
    var body: some View {
        backgroundStackView {
            VStack {
                headerView
                controllPanelView
                Spacer()
                    .frame(height: 40)
                if tagSelected == 1 {
                    closeCarControllView
                }
                Spacer()
            }
        }
    }

    var gradient: LinearGradient {
        LinearGradient(colors: [Color("TopGradient"), Color("BottomGradient")], startPoint: .bottom, endPoint: .top)
    }

    var controllPanelView: some View {
        HStack(spacing: 30) {
            ForEach(1..<5) { index in
                Button {
                    withAnimation {
                        tagSelected = index
                    }
                } label: {
                    Image("\(index)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .neumorfismUnSelectedCircleStyle()
                        .overlay(
                            Circle()
                                .stroke(gradient, lineWidth: 2)
                                .opacity(tagSelected == index ? 1 : 0)
                        )
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 50).fill(Color("NBackground")))
        .neumorfismUnselectedStyle()
        .offset(y: -70)
    }

    // MARK: - Private properties

    var headerView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Tesla")
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("187 km")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .opacity(0.4)
                carView
            }
            Spacer()
        }
        .padding()
    }

    var carView: some View {
        Image(isCarClosed ? "closeCar" : "car")
            .resizable()
            .scaledToFit()
            .frame(height: 250)
            .padding(.leading, 30)
            .padding(.bottom, 40)
            .shadow(color: .white.opacity(0.6), radius: 15, x: 10, y: 1)
    }

    var closeCarControllView: some View {
        Button {
            withAnimation {
                isCarClosed.toggle()
            }
        } label: {
            HStack {
                Label {
                    Text(isCarClosed ? "Закрыть" : "Открыть")
                } icon: {
                    Image(systemName: isCarClosed ? "lock" : "lock.fill")
                        .renderingMode(.template)
                        .neumorfismUnSelectedCircleStyle()
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 50).fill(Color("NBackground")))
            .neumorfismSelectedStyle()
        }
        .frame(width: 300)
    }

    // MARK: - Private methods

    private func backgroundStackView<Content: View> (content: () -> Content) -> some View {
        ZStack {
            Rectangle()
                .fill(Color("NBackground"))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            content()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}

struct NeumorfismUnselected: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color("LightShadow"), radius: 5, x: -5, y: -5)
            .shadow(color: Color("DarkShadow"), radius: 5, x: 5, y: 5)
    }
}

struct NeumorfismSelected: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color("LightShadow"), radius: 5, x: 5, y: 5)
            .shadow(color: Color("DarkShadow"), radius: 5, x: -5, y: -5)
    }
}

struct NeumorfismUnSelectedCircle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 10)
            .background(Circle().fill(Color("NBackground")))
            .neumorfismUnselectedStyle()
    }
}

extension View {
    func neumorfismUnselectedStyle() -> some View {
        modifier(NeumorfismUnselected())
    }

    func neumorfismSelectedStyle() -> some View {
        modifier(NeumorfismSelected())
    }

    func neumorfismUnSelectedCircleStyle() -> some View {
        modifier(NeumorfismUnSelectedCircle())
    }
}

//  TabbarContentView.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 04.02.2023.
//

import SwiftUI

// Стартовый табвью
struct CustomTabView<Content: View>: View {

    // MARK: - Public Properties

    @Binding var selection: Int

    var body: some View {
        contentView
    }

    // MARK: - Private Properties

    @StateObject private var customTabViewModel = CustomTabViewModel()

    @Namespace private var tabBarItem

    private var content: Content

    private var contentView: some View {
        ZStack(alignment: .bottom) {
            content
            CustomTabViewBackground()
                .fill(Color.black)
                .shadow(color: .gray, radius: 3)
                .ignoresSafeArea()
            HStack {
                tabsView
            }
        }
        .onPreferenceChange(TabItemPreferenceKey.self) { value in
            customTabViewModel.tabs = value
        }
    }

    private var tabsView: some View {
        ForEach(Array(customTabViewModel.tabs.enumerated()), id: \.offset) { index, element in
            Spacer()
            Image(systemName: element.icon)
                .modifier(
                    TabItemImageModifire(
                        selection: selection,
                        tabBarItem: tabBarItem,
                        index: index
                    )
                )
                .onTapGesture {
                    withAnimation {
                        selection = index
                    }
                }
            Spacer()
        }
    }

    // MARK: - Init

    public init(selection: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.content = content()
        _selection = selection
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        StartTabView()
            .environment(\.colorScheme, .dark)
    }
}

//
//  RootTabBarFeature.swift
//  TMDBLibrary
//
//  Created by 鍾秉辰 on 2023/11/21.
//

import Foundation
import ComposableArchitecture

public typealias RootViewIndex = Int

public enum RootViewData {
    case upcoming
    case tv
    case actors
    case search
}

public enum TabBarItem: Equatable {
    case upcoming(RootViewIndex)
    case tv(RootViewIndex)
    case actors(RootViewIndex)
    case search(RootViewIndex)
}

public struct TabBarItemsData: Equatable {
    
    public let items: [TabBarItem]
    
    public init(items: [TabBarItem]) {
        self.items = items
    }
}


public struct RootTabBarFeature: Reducer {
    
    public init() {}
    
    public struct State: Equatable {
        /// Emits the array of views.
        public var views: [RootViewData]
        
        /// Emits data for setting tab bar item styles
        public var tabBarData: TabBarItemsData
        
        public init() {
            views = []
            tabBarData = TabBarItemsData(items: [])
        }
    }
    
    public enum Action {
        case onAppear
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.views = generateStandardView()
                state.tabBarData = tabData()
                return .none
            }
        }
    }
}



private func generateStandardView() -> [RootViewData] {
    return [.upcoming, .tv, .search, .actors]
}

private func tabData() -> TabBarItemsData {
    let items: [TabBarItem] = [
        .upcoming(0),
        .tv(1),
        .search(2),
        .actors(3)
    ]
    
    return TabBarItemsData(items: items)
}

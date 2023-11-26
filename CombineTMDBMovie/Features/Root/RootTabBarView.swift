//
//  RootTabBarView.swift
//  CombineTMDBMovie
//
//  Created by 鍾秉辰 on 2023/11/21.
//

import SwiftUI
import ComposableArchitecture
import TMDBLibrary

struct RootTabBarView: View {
    
    var store: StoreOf<RootTabBarFeature> = Store(
        initialState: RootTabBarFeature.State(), 
        reducer: { RootTabBarFeature() }
    )
    
    var body: some View {
        
        TabView {
            WithViewStore(store, observe: { $0.views }) { viewStore in
                ForEach(viewStore.state, id: \.hashValue) { viewData in
                    switch viewData {
                    case .home:
                        HomeViews()
                            .homeTab()
                    case .trending:
                        Text("trending")
                            .trendingTab()
                    case .actors:
                        Text("actors")
                            .actorTab()
                    }
                }
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
        .environment(\.colorScheme, .dark)
    }
}


#Preview {
    RootTabBarView()
}

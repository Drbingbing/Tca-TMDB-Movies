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
                    case .upcoming:
                        UpcomingMoviesView()
                            .upcomingTab()
                    case .actors:
                        Text("actor")
                            .actorTab()
                    case .tv:
                        TvShowsView()
                            .tvTab()
                    case .search:
                        Text("search")
                            .searchTab()
                    }
                }
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}


#Preview {
    RootTabBarView()
}

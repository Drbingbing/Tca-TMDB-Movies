//
//  TvShowsView.swift
//  CombineTMDBMovie
//
//  Created by 鍾秉辰 on 2023/11/24.
//

import SwiftUI
import TMDBLibrary
import ComposableArchitecture

struct TvShowsView: View {
    
    var store: StoreOf<TvShowsFeature>
    
    init() {
        store = Store(initialState: TvShowsFeature.State()) { TvShowsFeature() }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    WithViewStore(store, observe: \.tvShows) { viewStore in
                        ForEach(viewStore.state, id: \.tvID) { tvShow in
                            PreviewCardView(
                                image: tvShow.posterPath,
                                name: tvShow.title
                            )
                            .asButton()
                            .buttonStyle(.scaled)
                            .id(tvShow.tvID)
                            .onAppear {
                                print("id: \(tvShow.tvID)")
                                store.send(.cellWillDisplay(tvShow))
                            }
                        }
                    }
                }
                .padding(20)
                WithViewStore(store, observe: \.isLoadingTvShows) { viewStore in
                    if viewStore.state {
                        ProgressView().frame(width: 28, height: 28)
                    }
                }
            }
            .navigationTitle(Text("TVs"))
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                store.send(.onAppear)
            }
        }
    }
    
    
    private var columns: [GridItem] {
        [
            GridItem(.flexible(minimum: 120, maximum: .infinity), spacing: 12),
            GridItem(.flexible(minimum: 120, maximum: .infinity), spacing: 12)
        ]
    }
}


#Preview {
    TvShowsView()
}

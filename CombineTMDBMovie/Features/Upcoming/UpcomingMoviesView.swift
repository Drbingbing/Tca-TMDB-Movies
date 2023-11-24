//
//  UpcomingMoviesView.swift
//  CombineTMDBMovie
//
//  Created by 鍾秉辰 on 2023/11/21.
//

import Foundation
import ComposableArchitecture
import TMDBLibrary
import SwiftUI

struct UpcomingMoviesView: View {
    
    var store: StoreOf<UpcomingMoviesFeature>
    
    init() {
        store = Store(
            initialState: UpcomingMoviesFeature.State(),
            reducer: { UpcomingMoviesFeature() }
        )
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    WithViewStore(store, observe: \.movies) { viewStore in
                        ForEach(viewStore.state, id: \.movieID) { movie in
                            PreviewCardView(
                                image: movie.posterPath,
                                name: movie.title
                            )
                            .asButton()
                            .buttonStyle(.scaled)
                            .id(movie.movieID)
                            .onAppear {
                                store.send(.cellWillDisplay(movie))
                            }
                        }
                    }
                }
                .padding(20)
                WithViewStore(store, observe: \.isLoadingMovies) { viewStore in
                    if viewStore.state {
                        ProgressView()
                            .frame(width: 28, height: 28)
                    }
                }
            }
            .navigationTitle(Text("Upcoming Movies"))
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
    UpcomingMoviesView()
}

//
//  SearchView.swift
//  CombineTMDBMovie
//
//  Created by 鍾秉辰 on 2023/11/27.
//

import SwiftUI
import ComposableArchitecture
import TMDBLibrary

struct SearchView: View {
    
    var store: StoreOf<SearchFeature>
    
    init(store: StoreOf<SearchFeature>) {
        self.store = store
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            WithViewStore(store, observe: { $0 }) { viewStore in
                if viewStore.searchText.isEmpty {
                    SearchPlaceholder()
                        .padding(.top, 48)
                }
                else if viewStore.isSearchingMovie {
                    VStack {
                        Spacer()
                        ProgressView().frame(width: 32, height: 32)
                        Spacer()
                    }
                    .padding(.top, 48)
                }
                else if !viewStore.searchedMovies.isEmpty {
                    SearchMovieResultView(movies: viewStore.searchedMovies)
                        .padding(.top, 48)
                }
            }
            WithViewStore(store, observe: \.searchText) { viewStore in
                SearchHeader(
                    searchText: viewStore.binding(get: { $0 }, send: { .searchTextChanged($0) })
                ) {
                    Image("back")
                        .resize(width: 32, height: 32)
                        .button(
                            action: { store.send(.closeSearch) },
                            style: .scaled
                        )
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.richBlack.ignoresSafeArea()
        }
    }
}

#Preview {
    SearchView(
        store: Store(initialState: SearchFeature.State()) { SearchFeature() }
    ).environment(\.colorScheme, .dark)
}

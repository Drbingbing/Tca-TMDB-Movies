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
    
    @State private var isBecomeFirstResponder = false
    
    init(store: StoreOf<SearchFeature>) {
        self.store = store
        store.send(.viewInit)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            WithViewStore(store, observe: { $0 }) { viewStore in
                SearchPlaceholder(
                    topRatedMovies: viewStore.topRatedMovies,
                    popularPeople: viewStore.latestPeople
                )
                .padding(.top, 48)
                
                if viewStore.isSearchingMovie {
                    progressView
                }
                if !viewStore.searchedMovies.isEmpty {
                    SearchMovieResultView(movies: viewStore.searchedMovies)
                        .padding(.top, 48)
                }
                SearchHeader(
                    searchText: viewStore.binding(get: \.searchText, send: { .searchTextChanged($0) })
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
    
    private var progressView: some View {
        VStack {
            Spacer()
            ProgressView().frame(width: 32, height: 32)
            Spacer()
        }
        .padding(.top, 48)
    }
}

#Preview {
    SearchView(
        store: Store(initialState: SearchFeature.State()) { SearchFeature() }
    ).environment(\.colorScheme, .dark)
}

//
//  ActorListView.swift
//  CombineTMDBMovie
//
//  Created by 鍾秉辰 on 2023/11/27.
//

import SwiftUI
import ComposableArchitecture
import TMDBLibrary

struct ActorListView: View {
    
    var store: StoreOf<PopularPeopleFeature>
    
    init() {
        store = Store(initialState: PopularPeopleFeature.State()) { PopularPeopleFeature() }
        store.send(.viewInit)
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 8) {
                WithViewStore(store, observe: \.people) { viewStore in
                    ForEach(viewStore.state, id: \.personID) { person in
                        PersonRow(
                            path: person.profilePath,
                            name: person.name
                        )
                        .button(
                            action: {},
                            style: .scaled
                        )
                        .onAppear {
                            store.send(.cellWillDisplay(person))
                        }
                    }
                }
            }
            .padding(12)
        }
    }
    
    private var columns: [GridItem] {
        [
            GridItem(.flexible(minimum: 80, maximum: .infinity), spacing: 8),
            GridItem(.flexible(minimum: 80, maximum: .infinity), spacing: 8),
            GridItem(.flexible(minimum: 80, maximum: .infinity), spacing: 8)
        ]
    }
}

#Preview {
    ActorsView()
        .environment(\.colorScheme, .dark)
}

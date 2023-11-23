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
                LazyVGrid(columns: columns, spacing: 20) {
                    PreviewCardView(
                        image: "https://image.tmdb.org/t/p/w185/dbABBH3DvFLkBUKwPUG0BlTYdmh.jpg",
                        name: "Movie"
                    )
                    .asButton()
                    .buttonStyle(.scaled)
                    PreviewCardView(
                        image: "https://image.tmdb.org/t/p/w185/k3waqVXSnvCZWfJYNtdamTgTtTA.jpg",
                        name: "Movie"
                    )
                    .asButton()
                    .buttonStyle(.scaled)
                    PreviewCardView(
                        image: "https://image.tmdb.org/t/p/w185/jDQPkgzerGophKRRn7MKm071vCU.jpg",
                        name: "君たちはどう生きるか"
                    )
                    .asButton()
                    .buttonStyle(.scaled)
                }
                .padding(20)
            }
            .navigationTitle(Text("Upcoming Movies"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var columns: [GridItem] {
        [
            GridItem(.flexible(minimum: 80, maximum: .infinity), spacing: 20),
            GridItem(.flexible(minimum: 80, maximum: .infinity), spacing: 8)
        ]
    }
}

#Preview {
    UpcomingMoviesView()
}

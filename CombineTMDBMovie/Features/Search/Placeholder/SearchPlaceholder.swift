//
//  SearchPlaceholder.swift
//  CombineTMDBMovie
//
//  Created by Bing Bing on 2023/11/27.
//

import SwiftUI
import ComposableArchitecture
import TMDBLibrary
import TMDBApi

struct SearchPlaceholder: View {
    
    var topRatedMovies: [Movie]
    var popularPeople: [Person]
    @State private var offset: CGPoint = .zero
    
    init(
        topRatedMovies: [Movie],
        popularPeople: [Person]
    ) {
        self.topRatedMovies = topRatedMovies
        self.popularPeople = popularPeople
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                SearchPeoplePlaceholder(people: popularPeople)
                
                SearchMovieResultView(movies: topRatedMovies)
            }
        }
        .dismissKeyboardWhenDeceratingIsBegin()
    }
}


#Preview {
    SearchPlaceholder(topRatedMovies: [], popularPeople: [])
        .background {
            Color.richBlack.ignoresSafeArea()
        }
        .environment(\.colorScheme, .dark)
}

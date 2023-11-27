//
//  SearchMoviesPlaceholder.swift
//  CombineTMDBMovie
//
//  Created by Bing Bing on 2023/11/27.
//

import SwiftUI
import Kingfisher
import TMDBApi
import ComposableArchitecture

struct SearchMoviesPlaceholder: View {
    
    var movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("節目與電影推薦")
                .padding(.horizontal, 10)
            ScrollView(showsIndicators: false) {
                ForEach(movies, id: \.movieID) { movie in
                    SearchMoviesPlaceholderRow(
                        path: movie.backdropPath,
                        title: movie.title
                    )
                }
            }
        }
    }
}

private struct SearchMoviesPlaceholderRow: View {
    
    @Dependency(\.posterBaseURL) var posterBaseURL
    
    var path: String?
    var title: String
    
    var body: some View {
        HStack(spacing: 12) {
            if let path {
                KFImage(URL(string: posterBaseURL + path))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .overlay {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(lineWidth: 1)
                            .fill(.sonicSilver)
                    }
            }
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.white)
            Spacer()
        }
        .padding(.horizontal, 10)
    }
}

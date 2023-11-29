//
//  SearchMovieResultView.swift
//  CombineTMDBMovie
//
//  Created by Bing Bing on 2023/11/27.
//

import SwiftUI
import Kingfisher
import TMDBApi
import ComposableArchitecture

struct SearchMovieResultView: View {
    
    var movies: [Movie]
    
    @State private var offset: CGPoint = .zero
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("節目與電影推薦")
                .padding(.horizontal, 10)
            ScrollView {
                ForEach(movies, id: \.movieID) { movie in
                    SearchMovieResultRow(
                        path: movie.backdropPath,
                        title: movie.title
                    )
                }
            }
            .onChange(of: offset) { oldValue, newValue in
                print("fssffdsfdfds")
            }
        }
    }
}

private struct SearchMovieResultRow: View {
    
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

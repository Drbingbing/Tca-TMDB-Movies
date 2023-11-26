//
//  RecommendMovieView.swift
//  CombineTMDBMovie
//
//  Created by Bing Bing on 2023/11/25.
//

import SwiftUI
import TMDBLibrary
import Kingfisher
import ComposableArchitecture

struct RecommendMovieView<Actions: View>: View {
    
    @Dependency(\.genres) var genres
    
    var actions: Actions
    var store: StoreOf<RecommendMovieFeature>
    
    init(@ViewBuilder actions: () -> Actions) {
        self.actions = actions()
        store = Store(initialState: RecommendMovieFeature.State()) { RecommendMovieFeature() }
        store.send(.viewInit)
    }
    
    private var posterBaseURL = "https://image.tmdb.org/t/p/w500"
    
    var body: some View {
        ZStack(alignment: .bottom) {
            WithViewStore(store, observe: \.movie) { viewStore in
                if let movie = viewStore.state {
                    if let posterPath = movie.posterPath {
                        KFImage(
                            URL(string: posterBaseURL + posterPath)
                        )
                        .placeholder { _ in
                            Color.clear
                                .frame(minWidth: 400, minHeight: 200)
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    }
                    
                    EpisodeInfoView(
                        title: Text(movie.title),
                        subTitle: Text(movie.originalTitle),
                        genre: Text(genreNames(ids: movie.genreIDs)),
                        buttons: { actions }
                    )
                } else {
                    ProgressView()
                        .frame(minWidth: 200, minHeight: 350)
                }
            }
        }
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 1)
                .fill(.separator)
        }
        .padding(20)
    }
    
    private func genreNames(ids: [Int]) -> String {
        genres.getMovieGenresName(ids)
            .joined(separator: "・")
    }
}

private struct EpisodeInfoView<Buttons: View>: View {
    
    var buttons: Buttons
    var title: Text
    var subTitle: Text
    var genre: Text
    
    init(
        title: Text,
        subTitle: Text,
        genre: Text,
        @ViewBuilder buttons: () -> Buttons
    ) {
        self.title = title
        self.subTitle = subTitle
        self.genre = genre
        self.buttons = buttons()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                title
                    .font(.system(size: 32, weight: .bold))
                   
                subTitle
                    .font(.system(size: 12, weight: .medium))
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
            }
            .foregroundStyle(.white)
            
            Color.clear.frame(height: 10)
            
            genre
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
            
            HStack { buttons }
            .padding(12)
        }
        .padding(.top, 4)
        .background {
            LinearGradient(
                colors: [
                    Color.black, 
                    Color.black.opacity(0.75),
                    Color.black.opacity(0.45),
                    Color.clear.opacity(0.2)
                ],
                startPoint: .bottom,
                endPoint: .top
            )
        }
        
    }
}

#Preview {
    RecommendMovieView {
        PlayButton(action: {})
        AddFavoriteButton(action: {})
    }
}

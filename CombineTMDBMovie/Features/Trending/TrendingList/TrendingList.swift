//
//  TrendingList.swift
//  CombineTMDBMovie
//
//  Created by Bing Bing on 2023/11/26.
//

import SwiftUI
import ComposableArchitecture
import TMDBLibrary
import Kingfisher
import TMDBApi

private enum TrendingSectionID: String {
    case upcoming = "即將上線"
    case trending = "大家都在看"
}

struct TrendingList: View {
    
    @Binding var selectedSort: String
    
    var store: StoreOf<TrendingFeature>
    
    init(sort: Binding<String>) {
        _selectedSort = sort
        store = Store(initialState: TrendingFeature.State()) { TrendingFeature() }
        store.send(.viewInit)
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    WithViewStore(store, observe: \.upcomingMovies) { viewStore in
                        ForEach(viewStore.state, id: \.movieID) { movie in
                            TrendingRow(movie: movie)
                        }
                    }
                }
                .asTrendingSection(
                    icon: Image("popcorn"),
                    header: Text("即將上線")
                        .id(TrendingSectionID.upcoming.rawValue)
                )
                
                Color.clear.frame(height: 28)
                
                LazyVStack {
                    WithViewStore(store, observe: \.trendingMovies) { viewStore in
                        ForEach(viewStore.state, id: \.movieID) { movie in
                            TrendingRow(movie: movie)
                                .button(
                                    action: { selectedSort = "即將上線" },
                                    style: .scaled
                                )
                        }
                    }
                }
                .asTrendingSection(
                    icon: Image("fire"),
                    header: Text("大家都在看")
                        .id(TrendingSectionID.trending.rawValue)
                )
                
            }
            .onChange(of: selectedSort) { oldSort, newSort in
                guard oldSort != newSort else { return }
                withAnimation {
                    proxy.scrollTo(newSort, anchor: .top)
                }
            }
        }
        
    }
}

private struct TrendingRow: View {
    
    private var posterBaseURL = "https://image.tmdb.org/t/p/w500"
    @Dependency(\.dateComposer) private var dateComposer
    
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                Text("\(dateComposer.month(movie.releaseDate))月")
                    .font(.system(size: 14))
                    .foregroundStyle(.sonicSilver)
                Text("\(dateComposer.day(movie.releaseDate))")
                    .font(.system(size: 26, weight: .semibold))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                if let backdropPath = movie.backdropPath {
                    KFImage(URL(string: posterBaseURL + backdropPath))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                TrendingInfoView(
                    title: Text(movie.title),
                    releaseDate: movie.releaseDate
                )
                TrendingOverview(Text(movie.overview))
                TrendingGenreView(movie.genreIDs)
            }
        }
        .padding(.horizontal, 10)
    }
}

private struct TrendingInfoView: View {
    
    @Dependency(\.dateComposer) private var dateComposer
    
    var title: Text
    var releaseDate: String
    
    init(title: Text, releaseDate: String) {
        self.title = title
        self.releaseDate = releaseDate
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    title
                        .font(.system(size: 40, weight: .bold))
                }
                
                Spacer()
                
                HStack {
                    TrendingButton(
                        image: Image("notification"),
                        label: Text("提醒我")
                    )
                    TrendingButton(
                        image: Image("info"),
                        label: Text("資訊")
                    )
                }
                .padding(.horizontal, 12)
            }
            Text("即將在\(month)月\(day)日上線")
        }
    }
    
    private var month: String {
        "\(dateComposer.month(releaseDate))"
    }
    
    private var day: String {
        "\(dateComposer.day(releaseDate))"
    }
}

private struct TrendingButton: View {
    
    var image: Image
    var label: Text
    var action: () -> Void
    
    init(action: @escaping () -> Void = {}, image: Image, label: Text) {
        self.action = action
        self.image = image
        self.label = label
    }
    
    var body: some View {
        VStack {
            image
                .resizable()
                .renderingMode(.template)
                .frame(width: 28, height: 28)
                .foregroundStyle(.white)
            label
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
        }
        .button(action: action, style: .scaled)
    }
}

private struct TrendingOverview: View {
    
    var text: Text
    
    init(_ text: Text) {
        self.text = text
    }
    
    var body: some View {
        text
            .font(.system(size: 14))
            .foregroundStyle(.sonicSilver)
    }
}

private struct TrendingGenreView: View {
    
    @Dependency(\.genres) private var genres
    
    var ids: [Int]
    
    init(_ ids: [Int]) {
        self.ids = ids
    }
    
    var body: some View {
        HStack {
            Text(name)
                .font(.system(size: 14))
            .foregroundStyle(.white)
            Spacer()
        }
    }
    
    private var name: String {
        genres.getMovieGenresName(ids).joined(separator: "・")
    }
}

private extension View {
    func asTrendingSection<Header: View>(
        icon: Image,
        header: Header
    ) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                icon
                    .resize(width: 20, height: 20, rederingMode: .original)
                header
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 10)
            self
        }
    }
}

#Preview {
    TrendingView()
        .environment(\.colorScheme, .dark)
}

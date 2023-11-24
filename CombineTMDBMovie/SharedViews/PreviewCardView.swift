//
//  PreviewCardView.swift
//  CombineTMDBMovie
//
//  Created by 鍾秉辰 on 2023/11/21.
//
import SwiftUI
import Kingfisher
import ComposableArchitecture

struct PreviewCardView: View {
    
    @Dependency(\.posterBaseURL) var posterBaseURL
    
    var image: String?
    var name: String
    
    var body: some View {
        VStack(alignment: .leading) {
            if let image = image {
                KFImage(URL(string: posterBaseURL + image))
                    .placeholder { _ in
                        ProgressView()
                            .frame(minWidth: 140, minHeight: 200)
                    }
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 275)
//                AsyncImage(
//                    url: URL(string: posterBaseURL + image),
//                    content: { phase in
//                        switch phase {
//                        case .empty:
//                            ProgressView()
//                                .frame(minWidth: 185, minHeight: 270)
//                        case .success(let image):
//                            image.resizable()
//                                .aspectRatio(contentMode: .fit)
//                        case .failure:
//                            Image(systemName: "photo")
//                        @unknown default:
//                            // Since the AsyncImagePhase enum isn't frozen,
//                            // we need to add this currently unused fallback
//                            // to handle any new cases that might be added
//                            // in the future:
//                            EmptyView()
//                        }
//                    }
//                )
            }
        }
//        .padding(.bottom, 8)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: .black.opacity(0.15), radius: 4)
    }
}

#Preview {
    PreviewCardView(
        image: "https://image.tmdb.org/t/p/w185/jDQPkgzerGophKRRn7MKm071vCU.jpg",
        name: "Movie"
    )
}

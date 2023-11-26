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
    
    @Dependency(\.posterBaseURL) private var posterBaseURL
    
    var image: String?
    
    init(image: String? = nil) {
        self.image = image
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let image = image {
                KFImage(URL(string: posterBaseURL + image))
                    .placeholder { _ in
                        Color.blackChocolate
                            .background(.regularMaterial)
                            .frame(minWidth: 80, minHeight: 160)
                    }
                    .resizable()
            }
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

#Preview {
    PreviewCardView(image: "/jDQPkgzerGophKRRn7MKm071vCU.jpg")
}

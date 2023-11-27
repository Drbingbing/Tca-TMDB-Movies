//
//  PersonRow.swift
//  CombineTMDBMovie
//
//  Created by 鍾秉辰 on 2023/11/27.
//

import SwiftUI
import ComposableArchitecture
import Kingfisher

struct PersonRow: View {
    
    @Dependency(\.posterBaseURL) var posterBaseURL
    
    var path: String?
    var name: String
    
    var body: some View {
        VStack(alignment: .leading) {
            if let path = path {
                KFImage(URL(string: posterBaseURL + path))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            Text(name)
                .foregroundStyle(.white)
                .font(.system(size: 16, weight: .medium))
                .lineLimit(1)
        }
    }
}

#Preview {
    PersonRow(path: "/q1NRzyZQlYkxLY07GO9NVPkQnu8.jpg", name: "Jenna Ortega")
        .environment(\.colorScheme, .dark)
}

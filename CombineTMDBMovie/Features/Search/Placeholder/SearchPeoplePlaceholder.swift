//
//  SearchPeoplePlaceholder.swift
//  CombineTMDBMovie
//
//  Created by Bing Bing on 2023/11/27.
//

import SwiftUI
import Kingfisher
import TMDBApi
import ComposableArchitecture

struct SearchPeoplePlaceholder: View {
    
    var people: [Person]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("公眾人物")
                .padding(.horizontal, 10)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(
                    rows: [GridItem(.flexible(minimum: 110, maximum: .infinity))]
                ) {
                    ForEach(people, id: \.personID) { person in
                        SearchPeoplePlaceholderRow(person: person)
                            .frame(width: 80)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
                
            }
            .background(.clear)
            .frame(height: 110 * 1.4)
        }
    }
}

private struct SearchPeoplePlaceholderRow: View {
    @Dependency(\.posterBaseURL) var posterBaseURL
    
    var person: Person
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            if let path = person.profilePath {
                KFImage(URL(string: posterBaseURL + path))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            } else {
                Color.clear
                    .frame(width: 100)
            }
            Text(person.name)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.white)
        }
    }
}

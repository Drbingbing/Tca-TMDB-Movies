//
//  SearchHeader.swift
//  CombineTMDBMovie
//
//  Created by 鍾秉辰 on 2023/11/27.
//

import SwiftUI
import TMDBLibrary
import SwiftUIIntrospect

struct SearchHeader<Back: View>: View {
    
    enum FocusField: Hashable {
        case search
    }
    
    @Binding var searchText: String
     
    var back: Back
    
    init(
        searchText: Binding<String>,
        back: () -> Back
    ) {
        _searchText = searchText
        self.back = back()
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                back
                HStack {
                    Image("magnifying-glass")
                        .resize(width: 16, height: 16)
                        .foregroundStyle(.sonicSilver)
                    TextField("搜尋人物、節目、電影⋯⋯", text: $searchText)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.primaryGray)
                }
            }
            .padding(.leading, 10)
            .padding(.trailing, 20)
            Spacer()
        }
    }
}

#Preview {
    SearchHeader(searchText: .constant("")) {
        Image("back")
            .resize(width: 32, height: 32)
    }
    .background {
        Color.richBlack.ignoresSafeArea()
    }
    .environment(\.colorScheme, .dark)
}

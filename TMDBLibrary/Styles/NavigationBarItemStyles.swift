//
//  NavigationBarItemStyles.swift
//  TMDBLibrary
//
//  Created by Bing Bing on 2023/11/26.
//

import SwiftUI

extension Image {
    
    public func asThumbnail() -> some View {
        self.resizable()
            .renderingMode(.template)
            .frame(width: 26, height: 26)
    }
}

//
//  Appearance.swift
//  TMDBLibrary
//
//  Created by 鍾秉辰 on 2023/11/23.
//

import UIKit

public struct Appearance {
    
    public static func setupAppearance(backgroundColor: UIColor = .white, foregroundColor: UIColor = .black) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            .foregroundColor: foregroundColor,
            .font: UIFont.systemFont(ofSize: 21, weight: .bold)
        ]
        appearance.backgroundColor = backgroundColor
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

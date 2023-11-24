//
//  Array+Extension.swift
//  TMDBLibrary
//
//  Created by 鍾秉辰 on 2023/11/24.
//

import Foundation

func canLoadNextPage<Element: Hashable>(
    trigger: @autoclosure () -> Element,
    totalItems: [Element],
    metric: Int = 3
) -> Bool {
    let element = trigger()
    return totalItems.suffix(metric).contains(element)
}

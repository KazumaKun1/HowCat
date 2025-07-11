//  CatMainScreenState.swift
//  HowCat
//
//  Created by Refactor Bot on 7/2/25.

import Foundation

enum CatScreenState: Equatable {
    case main
    case factScreen(content: CatContentModel)
}

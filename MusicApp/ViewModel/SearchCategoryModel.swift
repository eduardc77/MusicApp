//
//  SearchCategoryModel.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct SearchCategoryModel: Hashable {
    var id = UUID()
    var image: String
    var title: String
    var tag: Int
    
    static let example = SearchCategoryModel(image: "category1", title: "Placeholder Placeholder", tag: 0)
}

var searchCategories = [
    SearchCategoryModel(image: "category1", title: "Placeholder", tag: 0),
    SearchCategoryModel(image: "category2", title: "Placeholder Placeholder", tag: 1),
    SearchCategoryModel(image: "category3", title: "Placeholder Placeholder", tag: 2),
    SearchCategoryModel(image: "category4", title: "Placeholder", tag: 3),
    SearchCategoryModel(image: "category5", title: "Placeholder", tag: 4),
    SearchCategoryModel(image: "category6", title: "Placeholder Placeholder", tag: 5),
    SearchCategoryModel(image: "category7", title: "Placeholder Placeholder", tag: 6),
    SearchCategoryModel(image: "category8", title: "Placeholder", tag: 7),
    SearchCategoryModel(image: "category9", title: "Placeholder", tag: 8),
    SearchCategoryModel(image: "category10", title: "Placeholder", tag: 9)
]


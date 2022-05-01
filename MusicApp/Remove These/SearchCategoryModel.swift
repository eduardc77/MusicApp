
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
}

var searchCategories = [
    SearchCategoryModel(image: "category1", title: "Spatial Audio", tag: 0),
    SearchCategoryModel(image: "category2", title: "Hits", tag: 1),
    SearchCategoryModel(image: "category3", title: "Hip-Hop", tag: 2),
    SearchCategoryModel(image: "category4", title: "Pop", tag: 3),
    SearchCategoryModel(image: "category5", title: "Feel Good", tag: 4),
    SearchCategoryModel(image: "category6", title: "Motivation", tag: 5),
    SearchCategoryModel(image: "category7", title: "Charts", tag: 6),
    SearchCategoryModel(image: "category8", title: "Rock", tag: 7),
    SearchCategoryModel(image: "category9", title: "Fitness", tag: 8),
    SearchCategoryModel(image: "category10", title: "Party", tag: 9),
    SearchCategoryModel(image: "category11", title: "Classical", tag: 10),
    SearchCategoryModel(image: "category12", title: "Chill", tag: 11),
    SearchCategoryModel(image: "category13", title: "Dance", tag: 12),
    SearchCategoryModel(image: "category14", title: "Alternative", tag: 13),
    SearchCategoryModel(image: "category15", title: "Focus", tag: 14),
    SearchCategoryModel(image: "category16", title: "Kids", tag: 15),
    SearchCategoryModel(image: "category17", title: "Romance", tag: 16),
    SearchCategoryModel(image: "category18", title: "Dj Mixes", tag: 17),
    SearchCategoryModel(image: "category19", title: "Sleep", tag: 18),
    SearchCategoryModel(image: "category20", title: "R&B/Soul", tag: 19),
    SearchCategoryModel(image: "category1", title: "Music Video", tag: 20),
    SearchCategoryModel(image: "category2", title: "Jazz", tag: 21),
    SearchCategoryModel(image: "category3", title: "Commuting", tag: 22),
    SearchCategoryModel(image: "category4", title: "Acoutic", tag: 23),
    SearchCategoryModel(image: "category5", title: "Metal", tag: 24),
    SearchCategoryModel(image: "category6", title: "Classic Rock", tag: 25),
    SearchCategoryModel(image: "category7", title: "K-Pop", tag: 26),
    SearchCategoryModel(image: "category8", title: "Hard Rock", tag: 27),
    SearchCategoryModel(image: "category9", title: "Wellness", tag: 28),
    SearchCategoryModel(image: "category10", title: "Live Music", tag: 29),
    
]


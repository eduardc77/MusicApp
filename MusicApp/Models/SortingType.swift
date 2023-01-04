//
//  SortingType.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 09.05.2022.
//

enum SortingType: Equatable {
  case noSorting
  case search(searchTerm: String)
  case filter(iD: String)
}

enum StorageSortingType: String, Identifiable, CaseIterable {
  case name
  case date = "release date"
  case genre
  
  var id: String { rawValue }
}

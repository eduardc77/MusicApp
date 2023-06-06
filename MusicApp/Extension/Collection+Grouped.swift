//
//  Collection+Grouped.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation

extension Collection {
  // group values in a collection by the specified number
  func grouped(by number: Int) -> [[Element]] {
    var array: [[Element]] = []
    
    for (index, item) in self.enumerated() {
      let groupIndex = index / number
      if array.count == groupIndex {
        array.append([item])
        continue
      }
      array[groupIndex].append(item)
    }
    
    return array
  }
}

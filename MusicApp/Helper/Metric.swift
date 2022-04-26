//
//  Metric.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 19.04.2022.
//

import SwiftUI

enum Metric {
    static let playerSmallImageSize: CGFloat = 48
    static let searchResultImageSize: CGFloat = 56
    static let searchResultCornerRadius: CGFloat = 4
    
    static let playerHeight: CGFloat = 66
    static let regularSpacing: CGFloat = 16
    static let yOffset: CGFloat = -48
    static let capsuleWidth: CGFloat = 36
    static let capsuleHeight: CGFloat = 5
    static let largeMediaImage: CGFloat = UIScreen.main.bounds.height / 3.33
    
    //Horizontal List and Library List
    static let smallImageSize: CGFloat = 50
    static let mediumImageSize: CGFloat = 162
    static let largeImageSize: CGFloat = 186
    
    static let smallRowHeight: CGFloat = 55
    static let mediumRowHeight: CGFloat = 220
    static let largeRowHeight: CGFloat = UIScreen.main.bounds.height * 0.373
}

enum ImageSizeType {
    case small
    case medium
    case large
}

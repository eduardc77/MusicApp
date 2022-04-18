//
//  LargePictureModel.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation

struct LargePictureModel: Hashable {
    var id = UUID()
    var type: String
    var name: String
    var description: String
    var image: String
}

var selectedStatiions = [
    LargePictureModel(type: "Placeholder", name: "Placeholder", description: "AppleMusic", image: "bigradio1"),
    LargePictureModel(type: "Placeholder", name: "Placeholder", description: "AppleMusic", image: "bigradio2"),
    LargePictureModel(type: "Placeholder", name: "Placeholder", description: "AppleMusic", image: "bigradio3"),
    LargePictureModel(type: "Placeholder", name: "Placeholder", description: "Placeholder", image: "bigradio4"),
    LargePictureModel(type: "Placeholder", name: "Placeholder", description: "Placeholder", image: "bigradio5")
]

var selectedMusic = [
    [
        LargePictureModel(type: "Placeholder", name: "Placeholder", description: "Placeholder", image: "bigradio2"),
        LargePictureModel(type: "Placeholder", name: "Placeholder", description: "AppleMusic", image: "bigradio3")
    ],
    
    [
        LargePictureModel(type: "Placeholder", name: "Placeholder", description: "AppleMusic", image: "bigradio4"),
        LargePictureModel(type: "Placeholder", name: "Placeholder", description: "AppleMusic", image: "bigradio5")
    ],
    
    [
        LargePictureModel(type: "Placeholder", name: "Placeholder", description: "Placeholder", image: "bigradio1"),
        LargePictureModel(type: "Placeholder", name: "Placeholder", description: "Placeholder", image: "bigradio2")
    ]
]

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
    LargePictureModel(type: "Live", name: "Beats1 Live", description: "AppleMusic", image: "bigradio1"),
    LargePictureModel(type: "Dance", name: "Record", description: "AppleMusic", image: "bigradio2"),
    LargePictureModel(type: "Hip-Hop", name: "Classic", description: "AppleMusic", image: "bigradio3"),
    LargePictureModel(type: "Classic", name: "Mega Hits", description: "AppleMusic", image: "bigradio4"),
    LargePictureModel(type: "Pop", name: "Like FM", description: "AppleMusic", image: "bigradio5"),
    LargePictureModel(type: "Laid-Back", name: "Chill", description: "AppleMusic", image: "bigradio6")
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
    ],
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
    ],
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
    ],
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
    ],
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
    ],
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

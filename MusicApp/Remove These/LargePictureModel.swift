//
//  LargePictureModel.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation

struct LargePictureModel: Hashable, Identifiable {
    var id = UUID()
    var type: String
    var name: String
    var description: String
    var image: String
}

var selectedStations = [
    LargePictureModel(type: "podcast", name: "Music1 Live", description: "Apple Music", image: "bigradio0"),
    LargePictureModel(type: "podcast", name: "Beats1 Live", description: "Apple Music", image: "bigradio1"),
    LargePictureModel(type: "mix", name: "Record", description: "Apple Music", image: "bigrsadio2"),
    LargePictureModel(type: "podcast", name: "Classic", description: "Apple Music", image: "bigradio3"),
    LargePictureModel(type: "album", name: "Mega Hits", description: "Apple Music", image: "bigradio4"),
    LargePictureModel(type: "artist", name: "Like FM", description: "Apple Music", image: "bigradio5"),
    LargePictureModel(type: "podcast", name: "Chill", description: "Apple Music", image: "bigradio6"),
    LargePictureModel(type: "mix", name: "Rock", description: "Apple Music", image: "bigradio7")
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

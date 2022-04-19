//
//  SmallPictureModel.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation

struct SmallPictureModel: Hashable, Identifiable {
    var id = UUID()
    var image: String
    var name: String
    var description: String
}
var radioStations = [
    SmallPictureModel(image: "smallradio1", name: "Placeholder", description: "Placeholder"),
    SmallPictureModel(image: "smallradio2", name: "John Legend", description: "Placeholder"),
    SmallPictureModel(image: "smallradio3", name: "Placeholder", description: "Placeholder"),
    SmallPictureModel(image: "smallradio4", name: "Placeholder", description: "Placeholder"),
    SmallPictureModel(image: "smallradio5", name: "Billie Eilish", description: "Placeholder"),
    SmallPictureModel(image: "smallradio6", name: "Boston", description: "Placeholder")
]

var musicPlaylists = [
    [
        SmallPictureModel(image: "smallradio1", name: "Placeholder 2.0", description: "Placeholder Placeholder Placeholder"),
        SmallPictureModel(image: "smallradio2", name: "John Legend", description: "Placeholder"),
        SmallPictureModel(image: "smallradio3", name: "Placeholder", description: "Placeholder"),
        SmallPictureModel(image: "smallradio4", name: "Placeholder Placeholder", description: "Placeholder Placeholder Placeholder"),
        SmallPictureModel(image: "smallradio5", name: "Billie Eilish", description: "Placeholder"),
        SmallPictureModel(image: "smallradio6", name: "Placeholder: Boston", description: "Placeholder")
    ],
    
    [
        SmallPictureModel(image: "smallradio2", name: "John Legend", description: "Placeholder"),
        SmallPictureModel(image: "smallradio3", name: "Placeholder", description: "Placeholder"),
        SmallPictureModel(image: "smallradio4", name: "Placeholder", description: "Placeholder Placeholder Placeholder"),
        SmallPictureModel(image: "smallradio5", name: "Billie Eilish", description: "Placeholder"),
        SmallPictureModel(image: "smallradio6", name: "Placeholder: Boston", description: "Placeholder"),
        SmallPictureModel(image: "smallradio1", name: "Placeholder 2.0", description: "Placeholder XXI Placeholder")
    ],
    
    [
        SmallPictureModel(image: "smallradio3", name: "Placeholder Placeholder", description: "Placeholder"),
        SmallPictureModel(image: "smallradio4", name: "Placeholder Placeholder", description: "Placeholder Placeholder Placeholder"),
        SmallPictureModel(image: "smallradio5", name: "Billie Eilish", description: "Placeholder"),
        SmallPictureModel(image: "smallradio6", name: "Placeholder: Boston", description: "Placeholder"),
        SmallPictureModel(image: "smallradio1", name: "Placeholder 2.0", description: "Placeholder XXI Placeholder"),
        SmallPictureModel(image: "smallradio2", name: "John Legend Placeholder", description: "Placeholder")
    ],
    [
        SmallPictureModel(image: "smallradio1", name: "Placeholder 2.0", description: "Placeholder Placeholder Placeholder"),
        SmallPictureModel(image: "smallradio2", name: "John Legend", description: "Placeholder"),
        SmallPictureModel(image: "smallradio3", name: "Placeholder", description: "Placeholder"),
        SmallPictureModel(image: "smallradio4", name: "Placeholder Placeholder", description: "Placeholder Placeholder Placeholder"),
        SmallPictureModel(image: "smallradio5", name: "Billie Eilish", description: "Placeholder"),
        SmallPictureModel(image: "smallradio6", name: "Placeholder: Boston", description: "Placeholder")
    ],
    
    [
        SmallPictureModel(image: "smallradio2", name: "John Legend", description: "Placeholder"),
        SmallPictureModel(image: "smallradio3", name: "Placeholder", description: "Placeholder"),
        SmallPictureModel(image: "smallradio4", name: "Placeholder", description: "Placeholder Placeholder Placeholder"),
        SmallPictureModel(image: "smallradio5", name: "Billie Eilish", description: "Placeholder"),
        SmallPictureModel(image: "smallradio6", name: "Placeholder: Boston", description: "Placeholder"),
        SmallPictureModel(image: "smallradio1", name: "Placeholder 2.0", description: "Placeholder XXI Placeholder")
    ],
    
    [
        SmallPictureModel(image: "smallradio3", name: "Placeholder Placeholder", description: "Placeholder"),
        SmallPictureModel(image: "smallradio4", name: "Placeholder Placeholder", description: "Placeholder Placeholder Placeholder"),
        SmallPictureModel(image: "smallradio5", name: "Billie Eilish", description: "Placeholder"),
        SmallPictureModel(image: "smallradio6", name: "Placeholder: Boston", description: "Placeholder"),
        SmallPictureModel(image: "smallradio1", name: "Placeholder 2.0", description: "Placeholder XXI Placeholder"),
        SmallPictureModel(image: "smallradio2", name: "John Legend Placeholder", description: "Placeholder")
    ],
    [
        SmallPictureModel(image: "smallradio1", name: "Placeholder 2.0", description: "Placeholder Placeholder Placeholder"),
        SmallPictureModel(image: "smallradio2", name: "John Legend", description: "Placeholder"),
        SmallPictureModel(image: "smallradio3", name: "Placeholder", description: "Placeholder"),
        SmallPictureModel(image: "smallradio4", name: "Placeholder Placeholder", description: "Placeholder Placeholder Placeholder"),
        SmallPictureModel(image: "smallradio5", name: "Billie Eilish", description: "Placeholder"),
        SmallPictureModel(image: "smallradio6", name: "Placeholder: Boston", description: "Placeholder")
    ],
    
    [
        SmallPictureModel(image: "smallradio2", name: "John Legend", description: "Placeholder"),
        SmallPictureModel(image: "smallradio3", name: "Placeholder", description: "Placeholder"),
        SmallPictureModel(image: "smallradio4", name: "Placeholder", description: "Placeholder Placeholder Placeholder"),
        SmallPictureModel(image: "smallradio5", name: "Billie Eilish", description: "Placeholder"),
        SmallPictureModel(image: "smallradio6", name: "Placeholder: Boston", description: "Placeholder"),
        SmallPictureModel(image: "smallradio1", name: "Placeholder 2.0", description: "Placeholder XXI Placeholder")
    ],
    
    [
        SmallPictureModel(image: "smallradio3", name: "Placeholder Placeholder", description: "Placeholder"),
        SmallPictureModel(image: "smallradio4", name: "Placeholder Placeholder", description: "Placeholder Placeholder Placeholder"),
        SmallPictureModel(image: "smallradio5", name: "Billie Eilish", description: "Placeholder"),
        SmallPictureModel(image: "smallradio6", name: "Placeholder: Boston", description: "Placeholder"),
        SmallPictureModel(image: "smallradio1", name: "Placeholder 2.0", description: "Placeholder XXI Placeholder"),
        SmallPictureModel(image: "smallradio2", name: "John Legend Placeholder", description: "Placeholder")
    ],
    [
        SmallPictureModel(image: "smallradio1", name: "Placeholder 2.0", description: "Placeholder Placeholder Placeholder"),
        SmallPictureModel(image: "smallradio2", name: "John Legend", description: "Placeholder"),
        SmallPictureModel(image: "smallradio3", name: "Placeholder", description: "Placeholder"),
        SmallPictureModel(image: "smallradio4", name: "Placeholder Placeholder", description: "Placeholder Placeholder Placeholder"),
        SmallPictureModel(image: "smallradio5", name: "Billie Eilish", description: "Placeholder"),
        SmallPictureModel(image: "smallradio6", name: "Placeholder: Boston", description: "Placeholder")
    ],
    
    [
        SmallPictureModel(image: "smallradio2", name: "John Legend", description: "Placeholder"),
        SmallPictureModel(image: "smallradio3", name: "Placeholder", description: "Placeholder"),
        SmallPictureModel(image: "smallradio4", name: "Placeholder", description: "Placeholder Placeholder Placeholder"),
        SmallPictureModel(image: "smallradio5", name: "Billie Eilish", description: "Placeholder"),
        SmallPictureModel(image: "smallradio6", name: "Placeholder: Boston", description: "Placeholder"),
        SmallPictureModel(image: "smallradio1", name: "Placeholder 2.0", description: "Placeholder XXI Placeholder")
    ],
    
    [
        SmallPictureModel(image: "smallradio3", name: "Placeholder Placeholder", description: "Placeholder"),
        SmallPictureModel(image: "smallradio4", name: "Placeholder Placeholder", description: "Placeholder Placeholder Placeholder"),
        SmallPictureModel(image: "smallradio5", name: "Billie Eilish", description: "Placeholder"),
        SmallPictureModel(image: "smallradio6", name: "Placeholder: Boston", description: "Placeholder"),
        SmallPictureModel(image: "smallradio1", name: "Placeholder 2.0", description: "Placeholder XXI Placeholder"),
        SmallPictureModel(image: "smallradio2", name: "John Legend Placeholder", description: "Placeholder")
    ],
    [
        SmallPictureModel(image: "smallradio1", name: "Placeholder 2.0", description: "Placeholder Placeholder Placeholder"),
        SmallPictureModel(image: "smallradio2", name: "John Legend", description: "Placeholder"),
        SmallPictureModel(image: "smallradio3", name: "Placeholder", description: "Placeholder"),
        SmallPictureModel(image: "smallradio4", name: "Placeholder Placeholder", description: "Placeholder Placeholder Placeholder"),
        SmallPictureModel(image: "smallradio5", name: "Billie Eilish", description: "Placeholder"),
        SmallPictureModel(image: "smallradio6", name: "Placeholder: Boston", description: "Placeholder")
    ],
    
    [
        SmallPictureModel(image: "smallradio2", name: "John Legend", description: "Placeholder"),
        SmallPictureModel(image: "smallradio3", name: "Placeholder", description: "Placeholder"),
        SmallPictureModel(image: "smallradio4", name: "Placeholder", description: "Placeholder Placeholder Placeholder"),
        SmallPictureModel(image: "smallradio5", name: "Billie Eilish", description: "Placeholder"),
        SmallPictureModel(image: "smallradio6", name: "Placeholder: Boston", description: "Placeholder"),
        SmallPictureModel(image: "smallradio1", name: "Placeholder 2.0", description: "Placeholder XXI Placeholder")
    ],
    
    [
        SmallPictureModel(image: "smallradio3", name: "Placeholder Placeholder", description: "Placeholder"),
        SmallPictureModel(image: "smallradio4", name: "Placeholder Placeholder", description: "Placeholder Placeholder Placeholder"),
        SmallPictureModel(image: "smallradio5", name: "Billie Eilish", description: "Placeholder"),
        SmallPictureModel(image: "smallradio6", name: "Placeholder: Boston", description: "Placeholder"),
        SmallPictureModel(image: "smallradio1", name: "Placeholder 2.0", description: "Placeholder XXI Placeholder"),
        SmallPictureModel(image: "smallradio2", name: "John Legend Placeholder", description: "Placeholder")
    ]
]

var searchMusic = [
    SmallPictureModel(image: "smallradio1", name: "Placeholder 2.0", description: "Placeholder XXI Placeholder"),
    SmallPictureModel(image: "smallradio2", name: "John Legend Placeholder", description: "Радио"),
    SmallPictureModel(image: "smallradio3", name: "Placeholder Placeholder", description: "Радио"),
    SmallPictureModel(image: "smallradio4", name: "Placeholder Placeholder", description: "Placeholder Placeholder Placeholder"),
    SmallPictureModel(image: "smallradio5", name: "Billie Eilish", description: "Радио"),
    SmallPictureModel(image: "smallradio6", name: "Placeholder: Boston", description: "Радио")
]

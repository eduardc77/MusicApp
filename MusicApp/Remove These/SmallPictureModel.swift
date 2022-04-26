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
    SmallPictureModel(image: "smallradio0", name: "Up Next", description: "Apple Music"),
    SmallPictureModel(image: "smallradio1", name: "Africa Now", description: "Apple Music"),
    SmallPictureModel(image: "smallradio2", name: "John Legend", description: "Apple Music"),
    SmallPictureModel(image: "smallradio3", name: "Placeholder", description: "Apple Music"),
    SmallPictureModel(image: "smallradio4", name: "Billie Eilish", description: "Apple Music"),
    SmallPictureModel(image: "smallradio5", name: "Placeholder", description: "Apple Music"),
    SmallPictureModel(image: "smallradio6", name: "Placeholder", description: "Apple Music")
]

var musicPlaylists = [
    [
        SmallPictureModel(image: "smallradio0", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio1", name: "Africa Now", description: "Apple Music"),
        SmallPictureModel(image: "smallradio2", name: "John Legend", description: "Radio 2.0"),
        SmallPictureModel(image: "smallradio3", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio4", name: "Billie Eilish", description: "Placeholder"),
        SmallPictureModel(image: "smallradio5", name: "Augstana", description: "Apple Music"),
        SmallPictureModel(image: "smallradio6", name: "Placeholder: Boston", description: "Radio Station"),
        SmallPictureModel(image: "smallradio7", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio8", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio9", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio10", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio11", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio12", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio13", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio14", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio15", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio16", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio17", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio18", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio19", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio20", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio21", name: "Placeholder", description: "Listen Now"),
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
        SmallPictureModel(image: "p0", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "p1", name: "Africa Now", description: "Apple Music"),
        SmallPictureModel(image: "p2", name: "John Legend", description: "Radio 2.0"),
        SmallPictureModel(image: "p3", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "p4", name: "Billie Eilish", description: "Placeholder"),
        SmallPictureModel(image: "p5", name: "Augstana", description: "Apple Music"),
        SmallPictureModel(image: "p6", name: "Placeholder: Boston", description: "Radio Station"),
        SmallPictureModel(image: "p7", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "p8", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "p9", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "p10", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "p11", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "p12", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "p13", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "p14", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio14", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio15", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio16", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio17", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio18", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio19", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio20", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio21", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio14", name: "Placeholder", description: "Listen Now"),
        SmallPictureModel(image: "smallradio15", name: "Placeholder", description: "Listen Now")
        
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

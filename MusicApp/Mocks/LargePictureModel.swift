//
//  LargePictureModel.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

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
    LargePictureModel(type: "mix", name: "Record", description: "Apple Music", image: "bigradio2"),
    LargePictureModel(type: "podcast", name: "Classic", description: "Apple Music", image: "bigradio3"),
    LargePictureModel(type: "album", name: "Mega Hits", description: "Apple Music", image: "bigradio4"),
    LargePictureModel(type: "artist", name: "Like FM", description: "Apple Music", image: "bigradio5"),
    LargePictureModel(type: "podcast", name: "Chill", description: "Apple Music", image: "bigradio6"),
    LargePictureModel(type: "mix", name: "Rock", description: "Apple Music", image: "bigradio7")
]

func highlightContent() -> [Media] {
    var highlights = [Media]()
    
    selectedStations.forEach { station in
        highlights.append(Media(mediaResponse: MediaResponse(id: UUID().uuidString,
                                                             wrapperType: station.type,
                                                             kind: "Album",
                                                             name: station.name,
                                                             artistName: station.description,
                                                             collectionName: station.type,
                                                             description: station.description,
                                                             releaseDate: Date().ISO8601Format(),
                                                             artwork: UIImage(named: station.image)
                                                            ))
        )
    }
    
    return highlights
}

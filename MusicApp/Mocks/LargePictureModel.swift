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
      highlights.append(Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: station.type, kind: "Album", name: station.name, artistName: station.description, collectionName: station.type, trackName: "", collectionCensoredName: "", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "", discCount: 1, discNumber: 1, trackCount: 0, trackNumber: 1, trackTimeMillis: 0, country: "", currency: "", primaryGenreName: "", description: station.description, longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: station.image), composer: "", isCompilation: nil)))
   }
   
   return highlights
}

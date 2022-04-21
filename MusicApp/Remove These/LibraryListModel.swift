//
//  LibraryListModel.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation

struct LibraryListModel: Identifiable, Hashable {
    var id = UUID()
    var icon: String
    var title: String
}

var libraryList = [
    LibraryListModel(icon: "music.note.list", title: "Placehodler"),
    LibraryListModel(icon: "music.mic", title: "Placehodler"),
    LibraryListModel(icon: "rectangle.stack", title: "Placehodler"),
    LibraryListModel(icon: "music.note", title: "Placehodler"),
    LibraryListModel(icon: "tv", title: "Placehodler Placehodler"),
    LibraryListModel(icon: "music.note.tv", title: "Placehodler"),
    LibraryListModel(icon: "guitars", title: "Placehodler"),
    LibraryListModel(icon: "person.crop.rectangle.stack", title: "Placehodler"),
    LibraryListModel(icon: "music.quarternote.3", title: "Placehodler"),
    LibraryListModel(icon: "arrow.down.circle", title: "Placehodler"),
    LibraryListModel(icon: "music.note.house", title: "Placehodler Placehodler")
]

//
//  LibraryListItem.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 30.04.2022.
//

import Foundation

struct LibraryListItem: Hashable, Codable {
    var title: String
    var systemImage: String
 
    init(_ title: String, systemImage: String) {
        self.title = title
        self.systemImage = systemImage
    }
    
    static var libraryList = [
        LibraryListItem("Playlists", systemImage: "music.note.list"),
        LibraryListItem("Artists", systemImage: "music.mic"),
        LibraryListItem("Albums", systemImage: "rectangle.stack"),
        LibraryListItem("Songs", systemImage: "music.note"),
        LibraryListItem("Made For You", systemImage: "person.crop.square"),
        LibraryListItem("TV & Movies", systemImage: "tv"),
        LibraryListItem("Music Videos", systemImage: "music.note.tv"),
        LibraryListItem("Genres", systemImage: "guitars"),
        LibraryListItem("Compilations", systemImage: "person.2.crop.square.stack"),
        LibraryListItem("Composers", systemImage: "music.quarternote.3"),
        LibraryListItem("Downloaded", systemImage: "arrow.down.circle"),
        LibraryListItem("Home Sharing", systemImage: "music.note.house")
    ]
    
    static var defaultLibraryList = [
        LibraryListItem("Playlists", systemImage: "music.note.list"),
        LibraryListItem("Artists", systemImage: "music.mic"),
        LibraryListItem("Albums", systemImage: "rectangle.stack"),
        LibraryListItem("Songs", systemImage: "music.note"),
        LibraryListItem("Genres", systemImage: "guitars"),
        LibraryListItem("Compilations", systemImage: "person.2.crop.square.stack"),
        LibraryListItem("Composers", systemImage: "music.quarternote.3"),
    ]
}



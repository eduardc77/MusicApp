//
//  LibraryObservableObject.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.04.2022.
//

import MediaPlayer
import SwiftUI

final class LibraryObservableObject: ObservableObject {
    private var albumsItemCollection: [MPMediaItemCollection]?
    @Published var albums = [Media]()
    
    func refreshAlbums() {
        self.makeAlbumsQuery()
        self.setAlbums()
    }
    
    private func setAlbums() {
        albums.removeAll()
        albumsItemCollection?.forEach({ libraryAlbumItemCollection in
            guard let libraryAlbum = libraryAlbumItemCollection.representativeItem else { return }
            var image: Image?
            var uiImage: UIImage?
            if let artwork = libraryAlbum.artwork?.image(at: CGSize(width: 1024, height: 1024)) {
                image = Image(uiImage: artwork)
                uiImage = artwork
            }
            
            
            let newLibraryAlbum = Media(id: libraryAlbum.persistentID.description, trackName: libraryAlbum.title, artistName: libraryAlbum.artist, description: libraryAlbum.description, trackPrice: "", artworkUrl100: libraryAlbum.assetURL, artwork: image, artworkUIImage: uiImage, collectionName: libraryAlbum.albumTitle, trackTimeMillis: libraryAlbum.playbackDuration, releaseDate: libraryAlbum.releaseDate)
            
            guard !newLibraryAlbum.id.isEmpty else { return }
            
            albums.append(newLibraryAlbum)
        })
    }
    
    private func makeAlbumsQuery() {
        if let collections = MPMediaQuery.albums().collections {
            albumsItemCollection = collections
            if let playlists = MPMediaQuery.playlists().collections {
                albumsItemCollection = collections + playlists
            }
        } else {
            self.albumsItemCollection = nil
        }
        
    }
}


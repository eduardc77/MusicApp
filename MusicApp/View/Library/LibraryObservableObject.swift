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
    @Published private var albums = [Media]()
    
    func getAlbum(at index: Int) -> Media {
        if index < 0 || index >= albums.count {
            return Media(id: DefaultString.undefined)
        }
        return albums[index]
    }
    
    func refreshAlbums() {
        self.makeAlbumsQuery()
        self.setAlbums()
    }
    
    private func setAlbums() {
        albums.removeAll()
        albumsItemCollection?.forEach({ libraryAlbumItemCollection in
            let libraryAlbum = libraryAlbumItemCollection.representativeItem
            var image: UIImage? = nil
            if let artwork = libraryAlbum?.artwork?.image(at: CGSize(width: 1024, height: 1024)) {
                image = artwork
            }
            
            let newLibraryAlbum = Media(id: libraryAlbum?.albumPersistentID.description ?? "", trackName: libraryAlbum?.title, artistName: libraryAlbum?.artist, description: libraryAlbum?.description, trackPrice: "", artworkUrl100: libraryAlbum?.assetURL, artwork: image == nil ? nil : Image(uiImage: image ?? UIImage()), collectionName: libraryAlbum?.albumTitle, trackTimeMillis: libraryAlbum?.playbackDuration, releaseDate: libraryAlbum?.releaseDate)
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
    
    func getAlbumsCount() -> Int {
        return albums.count
    }
}


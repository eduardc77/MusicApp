//
//  ArtistViewObservableObject.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 09.05.2022.
//

import Combine

final class ArtistViewObservableObject: ObservableObject {
   // MARK: - Properties
   
   private let networkService: NetworkServiceProtocol
   private var anyCancellable: Set<AnyCancellable> = []
   let media: Media
   
   // MARK: - Publishers
   
   @Published private(set) var trackResults: [Media] = []
   @Published private(set) var albumResults: [Media] = []
   @Published private(set) var musicVideoResults: [Media] = []
   @Published private(set) var loadingTracks: Bool = true
   @Published private(set) var loadingAlbums: Bool = true
   @Published private(set) var loadingMusicVideos: Bool = true
   @Published private(set) var presenter: Presenter? = nil
   @Published var errorState: ErrorState = .init(isError: false, descriptor: nil)
   
   var artistFeatureAlbum: Media? {
      guard let featureAlbum = albums.first else { return nil }
      return featureAlbum
   }
   
   var albums: [Media] {
      guard !albumResults.isEmpty else { return [] }
      
      var albumResults = albumResults
      albumResults.removeFirst()
      var albums: [Media] = []
      
      albumResults.forEach { album in
         if !album.collectionName.contains("Single"), !album.collectionName.contains("EP"), !album.collectionName.contains(media.artistName) {
            albums.append(album)
         }
      }
      
      return albums
   }
   
   var singlesAndEps: [Media] {
      guard !albumResults.isEmpty else { return [] }
      
      var albumResults = albumResults
      albumResults.removeFirst()
      var singlesAndEps: [Media] = []
      
      albumResults.forEach { album in
         if !album.collectionName.contains(media.artistName) && (album.collectionName.contains("Single") || album.collectionName.contains("EP")) {
            singlesAndEps.append(album)
         }
      }
      
      return singlesAndEps
   }
   
   var appearsOn: [Media] {
      guard !albumResults.isEmpty else { return [] }
      
      var albumResults = albumResults
      albumResults.removeFirst()
      var appearsOn: [Media] = []
      
      albumResults.forEach { album in
         if album.collectionName.contains(media.artistName), album.artistName != media.artistName {
            appearsOn.append(album)
         }
      }
      
      return appearsOn
   }
   
   var tracks: [Media] {
      guard !trackResults.isEmpty else { return [] }
      
      var tracks = trackResults
      tracks.removeFirst()
      
      return tracks
   }
   
   var musicVideos: [Media] {
      guard !musicVideoResults.isEmpty else { return [] }
      
      var musicVideos = musicVideoResults
      musicVideos.removeFirst()
      
      return musicVideos
   }
   
   var loadingComplete: Bool {
      if loadingTracks || loadingAlbums || loadingMusicVideos {
         return false
      } else {
         return true
      }
   }
   
   // MARK: - Initialization
   
   init(networkService: NetworkService = .init(), media: Media) {
      self.networkService = networkService
      self.media = media
      
      fetchAllArtistMedia(for: media.id)
   }
   
   deinit {
      print("deinit ArtistViewObservableObject")
   }
   
   // MARK: - Public Methods
   
   func fetchAllArtistMedia(for artistId: String) {
      fetchSongs(for: artistId)
      fetchAlbums(for: artistId)
      fetchMusicVideos(for: artistId)
   }
   
   func fetchSongs(for artistId: String) {
      guard trackResults.isEmpty else { return }
      cleanErrorState()
      
      networkService.request(endpoint: .getInfo(by: .lookup(id: artistId, entity: "song", media: "music", attribute: "songTerm", limit: "100", sort: "ratingIndex")))
         .compactMap { $0 as ITunesAPIResponse }
         .catch(handleError)
            .map(\.results)
            .map { $0.map(Media.init) }
      
         .sink { [weak self] results in
            self?.trackResults = results
            self?.loadingTracks = false
         }
         .store(in: &anyCancellable)
   }
   
   func fetchAlbums(for artistId: String) {
      guard albumResults.isEmpty else { return }
      cleanErrorState()
      
      networkService.request(endpoint: .getInfo(by: .lookup(id: artistId, entity: "album", media: "music", attribute: "albumTerm", limit: "100", sort: "recent")))
         .compactMap { $0 as ITunesAPIResponse }
         .catch(handleError)
            .map(\.results)
            .map { $0.map(Media.init) }
      
         .sink { [weak self] results in
            self?.albumResults = results
            self?.loadingAlbums = false
         }
         .store(in: &anyCancellable)
   }
   
   func fetchMusicVideos(for artistId: String) {
      guard musicVideoResults.isEmpty else { return }
      cleanErrorState()
      
      networkService.request(endpoint: .getInfo(by: .lookup(id: artistId, entity: "musicVideo", media: "musicVideo", attribute: "songTerm", limit: "100", sort: "recent")))
         .compactMap { $0 as ITunesAPIResponse }
         .catch(handleError)
            .map(\.results)
            .map { $0.map(Media.init) }
      
         .sink { [weak self] results in
            self?.musicVideoResults = results
            self?.loadingMusicVideos = false
         }
         .store(in: &anyCancellable)
   }
}

// MARK: - Types

extension ArtistViewObservableObject {
   enum AlbumType {
      case album
      case singlesAndEp
      case appearsOn
   }
}

// MARK: - Private methods

private extension ArtistViewObservableObject {
   func handleError(_ error: NetworkError) -> Empty<ITunesAPIResponse, Never> {
      errorState = .init(
         isError: true,
         descriptor: .init(
            title: error.errorTitle,
            description: error.localizedDescription
         )
      )
      return .init()
   }
   
   func cleanErrorState() {
      guard errorState.isError else { return }
      errorState = .init(isError: false, descriptor: nil)
   }
   
   
}

//
//  SearchResultsRow.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct SearchResultsRow: View {
    @EnvironmentObject private var playerObservableObject: PlayerObservableObject
    var media: Media
    @State var playing: Bool = false
    
    init(media: Media, isPlaying: Binding<Bool>) {
        self.media = media
        _playing = State(wrappedValue: isPlaying.wrappedValue)
    }
    
    var body: some View {
        HStack {
            if let uiImage = media.artwork {
                MediaImageView(artworkImage: uiImage, sizeType: .searchRow, playing: $playing)
            } else {
                MediaImageView(imagePath: media.artworkPath.resizedPath(size: 100), sizeType: .searchRow, playing: $playing)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    MediaItemName(name: media.name, explicitness: media.trackExplicitness, font: .callout)
                    
                    Text("\(media.kind.title) · \(media.artistName)")
                        .foregroundColor(.secondary)
                        .font(.callout)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "ellipsis")
                    .padding(.trailing, 6)
            }
        }
        .onTapGesture {
            // FIXME: - Pass the player
            MPMusicPlayerController.applicationMusicPlayer.setQueue(with: [media.id])
            MPMusicPlayerController.applicationMusicPlayer.play()
        }
    }
}

//struct SearchResultsRow_Previews: PreviewProvider {
//    struct SearchResultsRowExample: View {
//        let media = MediaResponse(id: 0, name: "Placeholder", artistName: "Placeholder")
//        
//        var body: some View {
//            SearchResultsRow(media: media)
//        }
//    }
//    
//    static var previews: some View {
//        SearchResultsRowExample()
//    }
//}

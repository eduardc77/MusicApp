//
//  SmallMediaRowItem.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 25.04.2022.
//

import SwiftUI
import MediaPlayer

struct SmallMediaRowItem: View {
    var media: Media
    var imageData: Data?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let uiImage = media.artwork {
                    MediaImageView(artworkImage: uiImage, size: Size(width: Metric.smallImageSize, height: Metric.smallImageSize))
                } else {
                    MediaImageView(imagePath: media.artworkPath.resizedPath(size: 160), size: Size(width: Metric.smallImageSize, height: Metric.smallImageSize))
                }
                
                VStack(alignment: .leading) {
                    Divider()
                    
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(media.name)
                                .foregroundColor(.primary)
                            
                            Text(media.artistName)
                                .foregroundColor(.secondary)
                                .font(.caption)
                        }
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                        
                        Image(systemName: "ellipsis")
                            .padding(.trailing)
                    }
                    
                    Spacer()
                }
            }
            .onTapGesture {
                guard media.wrapperType == .track else { return }
                
                // FIXME: - Pass the player
                MPMusicPlayerController.applicationMusicPlayer.setQueue(with: [media.id])
                MPMusicPlayerController.applicationMusicPlayer.play()
            }
        }
        .frame(width: UIScreen.main.bounds.width - 34)
    }
}



//
//struct SmallMediaRowItem_Previews: PreviewProvider {
//    struct SmallMediaRowItemExample: View {
//        let media = Media(artistName: "Placeholder Artist", trackName: "Placeholder Name", description: "Placeholder Description", artwork: Image("bigradio1"))
//        
//        var body: some View {
//            SmallMediaRowItem(media: media)
//        }
//    }
//    
//    static var previews: some View {
//        SmallMediaRowItemExample()
//    }
//}

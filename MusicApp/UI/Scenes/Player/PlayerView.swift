//
//  PlayerView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct PlayerView: View {
   @EnvironmentObject private var model: PlayerModel
   @State private var offset: CGFloat = .zero
   @State private var visibleSide: FlipViewSide = .front
   
   var expand: Bool {
      model.expand
   }
   
   var body: some View {
      VStack(spacing: .zero) {
         handleBar
         
         HStack(spacing: .zero) {
            mediaView
            
            if !expand {
               smallPlayerViewDetails
                  .padding(.leading, 12)
                  .padding(.trailing, 4)
            }
         }
         .padding(.leading, expand ? .zero : nil)
         .frame(height: expand ? Metric.screenHeight / 2 :  Metric.playerHeight)
         
         if expand {
            VStack(spacing: .zero) {
               HStack(spacing: 4) {
                  expandedMediaDetails
                  Spacer()
                  ellipsisButton
               }
               .padding(.bottom)
               
               expandedControlsBlock.padding(.horizontal)
            }
            .frame(height: expand ? Metric.screenHeight / 2.74 : .zero)
            .opacity(expand ? 1 : .zero)
            .transition(.move(edge: .bottom))
         }
      }
      .frame(maxHeight: expand ? .infinity : Metric.playerHeight)
      .background(playerBackground.clipShape(.rect(cornerRadius: expand ? UIScreen.main.displayCornerRadius : 0)))
      .offset(y: expand ? .zero : Metric.tabBarHeight)
      .offset(y: offset)
      .ignoresSafeArea()
      .gesture(DragGesture().onEnded(onEnded).onChanged(onChanged))
      
      .onReceive(NotificationCenter.default.publisher(for: .MPMusicPlayerControllerPlaybackStateDidChange)) { _ in
         model.playbackState = PlayerModel.audioPlayer.playbackState
      }
      .onReceive(NotificationCenter.default.publisher(for: .MPMusicPlayerControllerNowPlayingItemDidChange)) { _ in
         guard let mediaItem = PlayerModel.audioPlayer.nowPlayingItem else { return }
         DispatchQueue.main.async {
            model.setNowPlaying(media: mediaItem)
         }
      }
   }
}

// MARK: - Private Methods

private extension PlayerView {
   // Drag Player
   func onChanged(value: DragGesture.Value) {
      withAnimation(.linear) {
         if value.translation.height > .zero && expand {
            offset = value.translation.height
         }
      }
   }
   
   // Close Player
   func onEnded(value: DragGesture.Value) {
      withAnimation(.closePlayer) {
         if value.translation.height > Metric.screenHeight / 12 {
            model.expand = false
         }
         offset = .zero
      }
   }
   
   func expandPlayer() {
      withAnimation(.openPlayer) {
         model.expand = true
      }
   }
}

// MARK: - Subviews

private extension PlayerView {
   @ViewBuilder
   var handleBar: some View {
      Capsule()
         .fill(Color.lightGrayColor2)
         .frame(width: Metric.capsuleWidth, height: expand ? Metric.capsuleHeight : .zero)
         .opacity(expand ? 1 : .zero)
   }
   
   @ViewBuilder
   var mediaView: some View {
      if PlayerModel.playerType == .audio {
         MediaImageView(imagePath: model.nowPlayingItem.artworkPath.resizedPath(size: 600), artworkImage: model.nowPlayingItem.artwork, sizeType: expand ? .largePlayerArtwork : .smallPlayerAudio, shadowProminence: expand ? .full : .none, visibleSide: $visibleSide)
            .scaleEffect((model.isPlaying && expand) ? 1.33 : 1)
            .animation(expand ? .scaleCard : .none, value: model.playbackState)
         
            .onTapGesture {
               guard expand else {
                  expandPlayer()
                  return
               }
               visibleSide.toggle()
            }
         
      } else {
         PlayerModel.videoPlayer
            .frame(width: expand ? SizeType.none.size.width : SizeType.smallPlayerVideo.size.width, height: expand ? SizeType.none.size.height : SizeType.smallPlayerVideo.size.height)
            .cornerRadius(expand ?  SizeType.none.cornerRadius : SizeType.smallPlayerVideo.cornerRadius)
         
      }
   }
   
   @ViewBuilder
   var smallPlayerViewDetails: some View {
      HStack {
         Text(model.nowPlayingItem.trackName)
            .lineLimit(1)
            .font(.title3)
         Spacer(minLength: 4)
         
         HStack(spacing: .zero) {
            Button {
               model.isPlaying ? PlayerModel.audioPlayer.pause() : PlayerModel.audioPlayer.play()
            } label: {
               model.isPlaying ? Image(systemName: "pause.fill") : Image(systemName: "play.fill")
            }
            .font(.title).imageScale(.medium)
            .buttonStyle(.circle)
            
            Button {
               PlayerModel.audioPlayer.skipToNextItem()
            } label: {
               Image(systemName: "forward.fill")
            }
            .font(.title).imageScale(.small)
            .buttonStyle(.circle)
         }
         .foregroundStyle(!model.nowPlayingItem.name.isEmpty ? .primary : Color.secondary)
      }
   }
   
   @ViewBuilder
   var expandedMediaDetails: some View {
      VStack(alignment: .leading, spacing: .zero) {
         InfiniteScrollText(text: model.nowPlayingItem.mediaResponse.trackName != nil ? model.nowPlayingItem.trackName : "Not Playing", explicitness: model.nowPlayingItem.trackExplicitness, font: UIFont.systemFont(ofSize: 20, weight: .semibold))
         
         Menu {
            Button { } label: {
               VStack {
                  Label("Go to Album", systemImage: "square.stack")
                  Text(model.nowPlayingItem.collectionName)
               }
            }
            
            Button { } label: {
               VStack {
                  Label("Go to Artist", systemImage: "music.mic")
                  Text(model.nowPlayingItem.artistName)
               }
            }
         } label: {
            InfiniteScrollText(text: model.nowPlayingItem.artistName, textColor: PlayerModel.playerType == .audio ? .lightGrayColor : .accentColor)
         }
      }
   }
   
   @ViewBuilder
   var ellipsisButton: some View {
      Group {
         switch PlayerModel.playerType {
            case .audio:
               MenuButton(circled: true, font: .title, foregroundColor: .white)
            case .video:
               MenuButton(circled: true, font: .title)
         }
      }
      .padding(.trailing, 30)
   }
   
   @ViewBuilder
   var expandedControlsBlock: some View {
      VStack(spacing: .zero) {
         TimeSliderView()
         Spacer()
         PlayerControls()
         Spacer()
         VolumeView(playerType: PlayerModel.playerType)
         Spacer()
         BottomToolbar(playerType: PlayerModel.playerType)
      }
   }
   
   @ViewBuilder
   var playerBackground: some View {
      Group {
         if expand {
            switch PlayerModel.playerType {
               case .audio:
                  if let artworkUIImage = model.nowPlayingItem.artwork {
                     LinearGradient(
                        gradient: Gradient(colors: [Color(artworkUIImage.firstAverageColor ?? .gray),
                                                    Color(artworkUIImage.secondAverageColor ?? .gray)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing)
                  } else {
                     Color.gray
                  }
               case .video:
                  // Video Player Background
                  Color.black
            }
         } else {
            VStack(spacing: .zero) {
               BlurView()
               Divider()
            }
         }
      }
      .scaleEffect(y: 1, anchor: .bottom)
      .onTapGesture {
         guard !expand else { return }
         expandPlayer()
      }
   }
}


// MARK: - Previews

struct PlayerView_Previews: PreviewProvider {
   static var previews: some View {
      VStack {
         Spacer()
         
         PlayerView()
      }
      .ignoresSafeArea()
      .environmentObject(PlayerModel())
   }
}

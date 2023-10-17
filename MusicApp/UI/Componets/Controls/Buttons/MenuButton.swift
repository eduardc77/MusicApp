//
//  MenuButton.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 12.01.2023.
//

import SwiftUI

struct MenuButton: View {
   @State var isPresented = false
   var circled: Bool = false
   var font: Font = .body
   var foregroundColor: Color = .accentColor
   var backgroundColor: Color = .lightGrayColor3
   
   var body: some View {
      Menu {
         ForEach(MenuItem.allCases.reversed(), id: \.self) { menuItem in
            Group {
               switch menuItem {
                  case .viewCredits:
                     Divider()
                     MenuItemButton(isPresented: $isPresented, title: menuItem.title, icon: menuItem.icon)
                  case .deleteFromLibrary:
                        MenuItemButton(isPresented: $isPresented, title: menuItem.title, icon: menuItem.icon, buttonRole: .destructive)
                  case .addToAPlaylist:
                     Divider()
                     MenuItemButton(isPresented: $isPresented, title: menuItem.title, icon: menuItem.icon)
                  case .createStation:
                     Divider()
                     MenuItemButton(isPresented: $isPresented, title: menuItem.title, icon: menuItem.icon)
                  case .suggestLess:
                     Divider()
                     MenuItemButton(isPresented: $isPresented, title: menuItem.title, icon: menuItem.icon)
               default:
                     MenuItemButton(isPresented: $isPresented, title: menuItem.title, icon: menuItem.icon)
               }
            }
            .tag(menuItem)
         }
      } label: {
         Group {
            if circled {
               Image(systemName: "ellipsis.circle.fill")
            } else {
               Image(systemName: "ellipsis")
            }
         }
         .font(font)
         .controlSize(.large)
         .foregroundStyle(foregroundColor, backgroundColor)
         .buttonStyle(.plain)
         .buttonBorderShape(.circle)
         .accessibilityLabel("Menu")
      }
      .sheet(isPresented: self.$isPresented) {
         DefaultView(title: "Detail View")
      }
      
   }
}

struct MenuItemButton: View {
   @Binding var isPresented: Bool
   let title: String
   let icon: String
   var buttonRole: ButtonRole? = .none
   
   var body: some View {
      Button(role: buttonRole) {
         isPresented = true
      } label: {
         Label(title, systemImage: icon)
      }
      .controlSize(.extraLarge)
   }
}

// MARK: - Types

enum MenuItem: Hashable, CaseIterable {
   case viewCredits
   case deleteFromLibrary
   case download
   case addToAPlaylist
   case shareSong
   case shareLyrics
   case goToAlbum
   case createStation
   case love
   case suggestLess
   case reportAConcern
   
   var title: String {
      switch self {
         case .viewCredits:
            return "View Credits"
         case .deleteFromLibrary:
            return "Delete From Library"
         case .download:
            return "Download"
         case .addToAPlaylist:
            return "Add to a Playlist..."
         case .shareSong:
            return "Share Song..."
         case .shareLyrics:
            return "Share Lyrics..."
         case .goToAlbum:
            return "Go To Album"
         case .createStation:
            return "Create Station"
         case .love:
            return "Love"
         case .suggestLess:
            return "Suggest Less"
         case .reportAConcern:
            return "Report a Concern..."
      }
   }
   
   var icon: String {
      switch self {
         case .viewCredits:
            return "info.circle"
         case .deleteFromLibrary:
            return "trash"
         case .download:
            return "arrow.down.circle"
         case .addToAPlaylist:
            return "text.badge.plus"
         case .shareSong:
            return "square.and.arrow.up"
         case .shareLyrics:
            return "arrow.up.message"
         case .goToAlbum:
            return "music.note.list"
         case .createStation:
            return "badge.plus.radiowaves.right"
         case .love:
            return "heart"
         case .suggestLess:
            return "hand.thumbsdown"
         case .reportAConcern:
            return "exclamationmark.bubble"
      }
   }
}


// MARK: - Previews

struct MenuItemButton_Previews: PreviewProvider {
   static var previews: some View {
      MenuItemButton(isPresented: .constant(false), title: MenuItem.addToAPlaylist.title, icon: MenuItem.addToAPlaylist.icon)
   }
}

struct MenuButton_Previews: PreviewProvider {
   static var previews: some View {
      MenuButton()
   }
}

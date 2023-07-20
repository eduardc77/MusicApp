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
   var foregroundColor: Color = .primary
   var backgroundColor: Color = .lightGrayColor3
   
   var body: some View {
      Menu {
         ForEach(MenuItem.allCases, id: \.self) { menuItem in
            Group {
               switch menuItem {
               case .deleteFromLibrary:
                  MenuItemButton(isPresented: $isPresented, buttonRole: .destructive, title: menuItem.rawValue)
                  
               default:
                  MenuItemButton(isPresented: $isPresented, title: menuItem.rawValue)
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
         .foregroundStyle(foregroundColor, backgroundColor)
         .frame(width: 24, height: 24)
         .contentShape(Rectangle())
      }
      .sheet(isPresented: self.$isPresented) {
         DefaultView(title: "Detail View")
      }
      
   }
}

struct MenuItemButton: View {
   @Binding var isPresented: Bool
   var buttonRole: ButtonRole? = .none
   let title: String
   
   var body: some View {
      Button(role: buttonRole) {
         isPresented = true
      } label: {
         Text(title)
      }
      
   }
}


// MARK: - Previews

struct MenuItemButton_Previews: PreviewProvider {
   static var previews: some View {
      MenuItemButton(isPresented: .constant(false), title: "Account Settings")
   }
}


enum MenuItem: String, CaseIterable {
   case deleteFromLibrary
   case download
   case addToAPlaylist
   case shareSong
   case sharePlay
   case viewFullLyrics
   case shareLyrics
   case showAlbum
   case createStation
   case love
   case suggestLessLikeThis
}

// MARK: - Previews

struct MenuButton_Previews: PreviewProvider {
   static var previews: some View {
      MenuButton()
   }
}

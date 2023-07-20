//
//  FavoriteMedia+CoreDataProperties.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation
import CoreData


extension FavoriteMedia {
   
   @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMedia> {
      return NSFetchRequest<FavoriteMedia>(entityName: "FavoriteMedia")
   }
   
   @NSManaged public var id: String
   @NSManaged public var title: String
   @NSManaged public var type: String
   @NSManaged public var image: String?
   @NSManaged public var createdAt: Date
   
   var mediaType: MediaType? {
      get {
         MediaType(rawValue: type) ?? nil
      }
      set {
         if let newValue = newValue {
            type = newValue.rawValue
         }
      }
   }
   
   public override func awakeFromInsert() {
      super.awakeFromInsert()
      
      setPrimitiveValue(Date(), forKey: #keyPath(FavoriteMedia.createdAt))
   }
}

extension FavoriteMedia : Identifiable {}

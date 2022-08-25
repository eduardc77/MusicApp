//
//  String+StripHTML.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

extension String {
  func stripHTML() -> String {
    var text = self.replacingOccurrences(of: "<br />", with: "\n")
    text = text.replacingOccurrences(of: "&#xa0;", with: " ")
    text = text.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    return text
  }
  
  func resizedPath(size: Int) -> String {
    replacingOccurrences(of: "100x100", with: "\(size)x\(size)")
  }
  var getCountryName: String {
    NSLocale(localeIdentifier: NSLocale.current.identifier)
    .displayName(forKey: .countryCode, value: self) ?? "Unknown Country" }
  
  var getCountryFlag: String {
    let base: UInt32 = 127397
    var flag = ""
    for v in self.unicodeScalars {
      flag.unicodeScalars.append(UnicodeScalar(base + v.value)!)
    }
    return String(flag)
  }
  
  var getCountryCode: String {
    let name = self
    for localeCode in NSLocale.isoCountryCodes {
      let identifier = NSLocale(localeIdentifier: "US")
      let countryName = identifier.displayName(forKey: .countryCode, value: localeCode)
      if name.lowercased() == countryName?.lowercased() {
        return localeCode
      }
    }
    return name
  }
  
  func size(withFont font: UIFont) -> CGSize {
    let attributes = [NSAttributedString.Key.font: font]
    let size = self.size(withAttributes: attributes)
    
    return size
  }
}

//
//  Recipe.swift
//  Recipes
//
//  Created by Matt Zawodniak on 4/8/25.
//

import Foundation
import SwiftUI

struct Recipe: Codable {
  var cuisine: String = ""
  var name: String = ""
  var photoUrlLarge: String?
  var photoUrlSmall: String?
  var uuid: String = ""
  var sourceUrl: String?
  var youtubeUrl: String?

//  func getSmallUrl() -> URL? {
//    guard let urlString = photoUrlSmall else { return nil }
//    return URL(string: urlString)
//  }
//
//  func getLargeUrl() -> URL? {
//    guard let urlString = photoUrlLarge else { return nil }
//    return URL(string: urlString)
//  }

//  func getSmallImage() async -> UIImage? {
//    let image = await ImageHandler.shared.getImageUrl(for: photoUrlSmall)
//    return image
//  }
//
//  func getLargeImage() async -> UIImage? {
//    let image = await ImageHandler.shared.getImageUrl(for: photoUrlLarge)
//    return image
//  }
}

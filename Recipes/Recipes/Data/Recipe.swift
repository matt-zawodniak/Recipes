//
//  Recipe.swift
//  Recipes
//
//  Created by Matt Zawodniak on 4/8/25.
//

import Foundation
import SwiftUI

struct Recipe: Codable {
  var cuisine: String
  var name: String
  var photoUrlLarge: String?
  var photoUrlSmall: String?
  var uuid: String
  var sourceUrl: String?
  var youtubeUrl: String?

  init(cuisine: String,
       name: String,
       photoUrlLarge: String? = nil,
       photoUrlSmall: String? = nil,
       uuid: String,
       sourceUrl: String? = nil,
       youtubeUrl: String? = nil) {
    self.cuisine = cuisine
    self.name = name
    self.photoUrlLarge = photoUrlLarge
    self.photoUrlSmall = photoUrlSmall
    self.uuid = uuid
    self.sourceUrl = sourceUrl
    self.youtubeUrl = youtubeUrl
  }
}

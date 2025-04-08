//
//  Recipe.swift
//  Recipes
//
//  Created by Matt Zawodniak on 4/8/25.
//

import Foundation

struct Recipe: Codable {
  var cuisine: String = ""
  var name: String = ""
  var photoUrlLarge: String?
  var photoUrlSmall: String?
  var uuid: String = ""
  var sourceUrl: String?
  var youtubeUrl: String?
}

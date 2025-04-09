//
//  Errors.swift
//  Recipes
//
//  Created by Matt Zawodniak on 4/8/25.
//

import Foundation

enum Errors: Error {
  case invalidURL
  case invalidJSON
  case invalidResponse
  case errorDownloadingPicture
}

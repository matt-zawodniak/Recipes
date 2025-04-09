//
//  Extensions.swift
//  Recipes
//
//  Created by Matt Zawodniak on 4/9/25.
//

import Foundation

extension String {
  func sanitized() -> String {
    return self.components(separatedBy: CharacterSet.punctuationCharacters).joined(separator: "")
  }
}

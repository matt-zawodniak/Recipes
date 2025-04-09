//
//  RecipeAPI.swift
//  Recipes
//
//  Created by Matt Zawodniak on 4/8/25.
//

import Foundation

class RecipeAPI {
  let session: URLSession

  init(session: URLSession = URLSession.shared) {
    self.session = session
  }

  func fetchRecipes() async throws -> [Recipe] {
    let api = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    guard let url = URL(string: api) else {
      throw Errors.invalidURL
    }

    let (data, response) = try await session.data(from: url)

    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
      throw Errors.invalidResponse
    }

    do {
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      let recipes = try decoder.decode(Recipes.self, from: data)
      return recipes.recipes
    } catch {
      throw Errors.invalidJSON
    }
  }
}

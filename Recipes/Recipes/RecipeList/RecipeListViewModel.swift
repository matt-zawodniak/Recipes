//
//  RecipeListViewModel.swift
//  Recipes
//
//  Created by Matt Zawodniak on 4/8/25.
//

import Foundation

@MainActor
class RecipeListViewModel: ObservableObject {
  @Published var recipes: [Recipe] = []
  @Published var selectedRecipe: Recipe?

  init() {
    Task {
      await fetchRecipes()
    }
  }

  func fetchRecipes() async {
    do {
      recipes = try await RecipeAPI.fetchRecipes()
    } catch {
      print("Failed to fetch recipes: \(error)")
    }
  }

  func selectRecipe(recipe: Recipe) {
    selectedRecipe = recipe
  }
}

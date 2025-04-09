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
  @Published var showingError: Bool = false
  @Published var isLoading: Bool = true

  init() {
    Task {
      await fetchRecipes()
      isLoading = false
    }
  }

  func fetchRecipes() async {
    isLoading = true
    do {
      recipes = try await RecipeAPI().fetchRecipes()
    } catch {
      print("Failed to fetch recipes: \(error)")
      showingError = true
    }
    isLoading = false
  }

  func selectRecipe(recipe: Recipe) {
    selectedRecipe = recipe
  }
}

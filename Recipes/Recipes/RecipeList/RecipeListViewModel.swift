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
  @Published var sortMethod: SortMethod = .name

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

  func sortRecipes() {
    switch sortMethod {
      case .name:
      self.recipes.sort { $0.name < $1.name }
    case .cuisine:
      self.recipes.sort { $0.cuisine < $1.cuisine }
    }
  }
}

enum SortMethod: Int, CaseIterable {
  case name = 0
  case cuisine = 1

  var description: String {
    switch self {
    case .name:
      return "Name"
    case .cuisine:
      return "Cuisine"
    }
  }
}

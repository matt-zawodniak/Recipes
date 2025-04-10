//
//  RecipeListViewModel.swift
//  Recipes
//
//  Created by Matt Zawodniak on 4/8/25.
//

import Foundation

@MainActor
class RecipeListViewModel: ObservableObject {
  var recipes: [Recipe] = []
  @Published var selectedRecipe: Recipe?
  @Published var showingError: Bool = false
  @Published var isLoading: Bool = true
  @Published var sortMethod: SortMethod = .name
  @Published var filteredRecipes: [Recipe] = []
  @Published var searchText: String = ""

  init() {
    Task {
      await fetchRecipes()
      filteredRecipes = recipes
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

  func filterRecipes() {
    if !searchText.isEmpty {
      filteredRecipes = recipes.filter({ $0.name.lowercased().contains(searchText.lowercased()) || $0.cuisine.lowercased().contains(searchText.lowercased()) })
    } else {
      filteredRecipes = recipes
    }
  }

  func selectRecipe(recipe: Recipe) {
    selectedRecipe = recipe
  }

  func sortRecipes() {
    switch sortMethod {
      case .name:
      self.filteredRecipes.sort { $0.name < $1.name }
    case .cuisine:
      self.filteredRecipes.sort { $0.cuisine < $1.cuisine }
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

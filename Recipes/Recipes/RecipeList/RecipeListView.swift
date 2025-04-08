//
//  ContentView.swift
//  Recipes
//
//  Created by Matt Zawodniak on 4/8/25.
//

import SwiftUI

struct RecipeListView: View {
  @ObservedObject var vm = RecipeListViewModel()
  @State var showingSelectedRecipe: Bool = false
  var body: some View {
        List {
          ForEach(vm.recipes, id: \.uuid) { recipe in
            RecipeRowView(recipe: recipe)
              .onTapGesture {
                vm.selectRecipe(recipe: recipe)
                showingSelectedRecipe = true
              }
          }
        }
        .listStyle(.plain)
        .padding()
        .refreshable {
          Task {
            await vm.fetchRecipes()
          }
        }
        .sheet(isPresented: $showingSelectedRecipe) {
          if let recipe = vm.selectedRecipe {
            RecipeView(recipe: recipe)
          }
        }
    }
}

#Preview {
    RecipeListView()
}

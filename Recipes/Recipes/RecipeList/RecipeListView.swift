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
    VStack {
      Text("RECIPES")
        .font(.headline)
      HStack {
        Text("Sort By:")
        Picker("Sort", selection: $vm.sortMethod) {
          ForEach(SortMethod.allCases, id: \.self) { val in
            Text(val.description)
          }
        }
        .onChange(of: vm.sortMethod) {
          vm.sortRecipes()
        }
      }
      if vm.recipes.isEmpty && !vm.isLoading && !vm.showingError {
        VStack {
          Spacer()
          Text("No Recipes Found. Please Try Again.")
          Button("Retry") {
            Task {
              await vm.fetchRecipes()
            }
          }
          Spacer()
        }
      } else if vm.showingError {
        VStack {
          Spacer()
          Text("An Error Occurred. Please Try Again.")
          Button("Retry") {
            Task {
              vm.showingError = false
              await vm.fetchRecipes()
            }
          }
          Spacer()
        }
      } else {
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
          await vm.fetchRecipes()
        }
        .sheet(isPresented: $showingSelectedRecipe) {
          if let recipe = vm.selectedRecipe {
            RecipeView(recipe: recipe)
          }
        }
      }
    }
  }
}

#Preview {
    RecipeListView()
}

//
//  RecipeView.swift
//  Recipes
//
//  Created by Matt Zawodniak on 4/8/25.
//

import SwiftUI

struct RecipeView: View {
  @State var recipe: Recipe
    var body: some View {
      VStack {
        AsyncImage(url: recipe.getLargeImage()) { image in
          image
            .resizable()
            .aspectRatio(contentMode: .fit)
        } placeholder: {
          ProgressView()
        }

        Text(recipe.name)
        Text(recipe.cuisine)

        // TODO: Website link that actually links out
        // TODO: Youtube link, embedded or links out
      }
    }
}

#Preview {
  RecipeView(recipe: Recipe())
}

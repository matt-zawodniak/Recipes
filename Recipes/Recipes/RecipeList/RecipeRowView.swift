//
//  RecipeRowView.swift
//  Recipes
//
//  Created by Matt Zawodniak on 4/8/25.
//

import SwiftUI

struct RecipeRowView: View {
  let recipe: Recipe
  var loadingImage: Bool = true
    var body: some View {
      HStack {
        AsyncImage(url: recipe.getSmallUrl()) { image in
          image
            .resizable()
            .aspectRatio(contentMode: .fit)
        } placeholder: {
          ProgressView()
        }
        .frame(width: 50, height: 50)

        Text(recipe.name)
        Spacer()
        Text(recipe.cuisine)
      }
    }
}

#Preview {
  RecipeRowView(recipe: Recipe())
}

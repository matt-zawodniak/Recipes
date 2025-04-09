//
//  RecipeView.swift
//  Recipes
//
//  Created by Matt Zawodniak on 4/8/25.
//

import SwiftUI

struct RecipeView: View {
  @State var recipe: Recipe
  @State var image: UIImage?
    var body: some View {
      VStack {
        if let image = image {
          Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
        } else {
          ProgressView()
            .frame(width: 50, height: 50)
        }

        Text(recipe.name)
        Text(recipe.cuisine)

        // TODO: Website link that actually links out
        // TODO: Youtube link, embedded or links out
      }
      .task {
        image = await ImageHandler.shared.getImage(for: recipe.photoUrlLarge)
      }
    }
}

#Preview {
  RecipeView(recipe: Recipe())
}

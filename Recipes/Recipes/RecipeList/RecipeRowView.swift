//
//  RecipeRowView.swift
//  Recipes
//
//  Created by Matt Zawodniak on 4/8/25.
//

import SwiftUI

struct RecipeRowView: View {
  let recipe: Recipe
  @State var image: UIImage?
    var body: some View {
      HStack {
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
        Spacer()
        Text(recipe.cuisine)
      }
      .task {
        image = await ImageHandler.shared.getLocalImage(for: recipe.photoUrlSmall)
      }
    }
}

#Preview {
  RecipeRowView(recipe: Recipe())
}

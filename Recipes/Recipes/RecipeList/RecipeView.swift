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
    GeometryReader { geometry in
      HStack {
        Spacer()
        VStack {
          if let image = image {
            Image(uiImage: image)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: geometry.size.width / 2, height: geometry.size.width / 2)
          } else {
            ProgressView()
              .frame(width: geometry.size.width / 2, height: geometry.size.width / 2)
          }

          Text(recipe.name)
            .font(.title)
          Text(recipe.cuisine)
            .font(.title2.italic())

          // Website link that actually links out
          // Youtube link, embedded or links out
        }
        Spacer()
      }
      .task {
        image = await ImageHandler.shared.getImage(for: recipe.photoUrlLarge)
      }
    }
  }
}

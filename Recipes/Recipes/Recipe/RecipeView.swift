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

          if let sourceUrlString = recipe.sourceUrl, let url = URL(string: sourceUrlString) {
            Link("Full Recipe Can Be Found By Clicking Here", destination: url)
          }

          if let youtubeUrl = recipe.youtubeUrl {
            VideoView(videoURLString: youtubeUrl)
          }
        }
        Spacer()
      }
      .task {
        image = await ImageHandler.shared.getImage(for: recipe.photoUrlLarge)
      }
    }
  }
}

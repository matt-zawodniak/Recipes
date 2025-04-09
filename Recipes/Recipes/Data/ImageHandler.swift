//
//  ImageHandler.swift
//  Recipes
//
//  Created by Matt Zawodniak on 4/9/25.
//

import Foundation
import SwiftUI

class ImageHandler {
  static let shared = ImageHandler()
  let folderName = "Images"

  private init() {}

  func getAnyImage(for urlString: String?) async -> URL? {
    if let url = urlString {
      if let localImage = getLocalImage(imageName: url, folderName: folderName) {
        return localImage
      } else {
        do {
          let image = try await downloadImage(for: url)
          return image
        } catch let error {
          print("Error downloading image: \(error)")
        }
      }
    }
    return nil
  }

  private func downloadImage(for urlString: String) async throws -> UIImage {
    guard let url = URL(string: urlString) else { throw Errors.invalidURL }

    let (data, response) = try await URLSession.shared.data(from: url)

    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
      throw Errors.invalidResponse
    }

    guard let image = UIImage(data: data) else {
      throw Errors.errorDownloadingPicture
    }

    saveImage(image: image, imageName: urlString, folderName: folderName)

    return image
  }

  func saveImage(image: UIImage, imageName: String, folderName: String) {
    createFolderIfNeeded(folderName: folderName)

    guard let data = image.jpegData(compressionQuality: 1),
          let url = getURLForImage(imageName: imageName, folderName: folderName)
    else { return }

    do {
      try data.write(to: url)
    } catch let error {
      print("Error saving image. Image name: \(imageName). Error: \(error.localizedDescription).")
    }
  }

  func getLocalImage(imageName: String, folderName: String) -> UIImage? {
    guard let url = getURLForImage(imageName: imageName, folderName: folderName),
          FileManager.default.fileExists(atPath: url.path) else { return nil }

    return UIImage(contentsOfFile: url.path)

  }

  private func createFolderIfNeeded(folderName: String) {
    guard let url = getURLForFolder(folderName: folderName) else { return }

    if !FileManager.default.fileExists(atPath: url.path) {
      do {
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: false)
      } catch let error {
        print("Error creating directory: \(error.localizedDescription).")
      }
    }
  }

  private func getURLForFolder(folderName: String) -> URL? {
    guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }

    return url.appendingPathComponent(folderName)
  }

  private func getURLForImage(imageName: String, folderName: String) -> URL? {
    guard let folderURL = getURLForFolder(folderName: folderName) else { return nil }

    return folderURL.appendingPathComponent(imageName)
  }
}

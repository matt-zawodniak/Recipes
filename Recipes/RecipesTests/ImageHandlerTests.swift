//
//  ImageHandlerTests.swift
//  RecipesTests
//
//  Created by Matt Zawodniak on 4/9/25.
//

import Foundation

import XCTest
@testable import Recipes

final class ImageHandlerTests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testGetImageWhenLocalFileExists() async {
    let urlString = "checkmark"
    let folderName = "Images"
    let image = UIImage(systemName: urlString)!
    ImageHandler.shared.saveImage(image: image, imageName: urlString, folderName: folderName)

    if let fetchedImage = await ImageHandler.shared.getImage(for: urlString) {
      XCTAssert(fetchedImage.jpegData(compressionQuality: 1)?.count ?? 0 > 0)
    } else {
      XCTFail("Failed to fetch image")
    }
  }

  func testGetImageWithInvalidURL() async {
    let badURLString = "invalid url"
    let badImage = await ImageHandler.shared.getImage(for: badURLString)
    XCTAssertNil(badImage)
  }
}

//
//  RecipesTests.swift
//  RecipesTests
//
//  Created by Matt Zawodniak on 4/8/25.
//

import XCTest
@testable import Recipes

final class APITests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    MockURLProtocol.requestHandler = nil
    super.tearDown()
  }

  lazy var session: URLSession = {
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [MockURLProtocol.self]
    return URLSession(configuration: configuration)
  }()

  lazy var testAPI: RecipeAPI = {
    RecipeAPI(session: session)
  }()

  func testFetchRecipesWithGoodData() async throws {
    let mockData = MockAPIData().mockData

    MockURLProtocol.requestHandler = { request in
      let response = HTTPURLResponse(
        url: request.url!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil)!
      return (response, mockData)
    }

    let result = try await testAPI.fetchRecipes()

    XCTAssertEqual(result.first?.cuisine, "Microwave")
    XCTAssertEqual(result.first?.name, "Matt Zawodniak")
    XCTAssertEqual(result.first?.photoUrlLarge, "large.jpg")
    XCTAssertEqual(result.first?.photoUrlSmall, "small.jpg")
    XCTAssertEqual(result.first?.sourceUrl, "my.kitchen")
    XCTAssertEqual(result.first?.uuid, "pi")
    XCTAssertEqual(result.first?.youtubeUrl, "youtube")
  }

  func testFetchRecipesWithMalformedData() async throws {
    let malformedData = MockAPIData().malformedData

    MockURLProtocol.requestHandler = { request in
      let response = HTTPURLResponse(
        url: request.url!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil)!
      return (response, malformedData)
    }

    do {
      try await testAPI.fetchRecipes()
    } catch let error {
      XCTAssertEqual(error as! Errors, Errors.invalidJSON)
    }
  }

  func testFetchRecipesWithEmptyData() async throws {
    let emptyData = MockAPIData().emptyData

    MockURLProtocol.requestHandler = { request in
      let response = HTTPURLResponse(
        url: request.url!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil)!
      return (response, emptyData)
    }

    let result = try await testAPI.fetchRecipes()

    XCTAssertEqual(result.count, 0)
  }
}

class MockURLSessionDataTask: URLSessionDataTask {
  private let closure: () -> Void

  init(closure: @escaping () -> Void) {
    self.closure = closure
  }

  override func resume() {
    closure()
  }
}

class MockURLProtocol: URLProtocol {
  override class func canInit(with request: URLRequest) -> Bool {
    true
  }

  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    request
  }

  static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

  override func startLoading() {
    guard let handler = MockURLProtocol.requestHandler else {
      XCTFail("No request handler provided.")
      return
    }

    do {
      let (response, data) = try handler(request)

      client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
      client?.urlProtocol(self, didLoad: data)
      client?.urlProtocolDidFinishLoading(self)
    } catch {
      XCTFail("Error handling the request: \(error)")
    }
  }

  override func stopLoading() {}
}



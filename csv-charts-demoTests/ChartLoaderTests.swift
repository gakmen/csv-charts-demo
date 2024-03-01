//
//  ChartLoaderTests.swift
//  csv-charts-demoTests
//
//  Created by  Gosha Akmen on 23.02.2024.
//

import XCTest
import csv_charts_demo

class ChartLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.messages.isEmpty)
    }
    
    func test_load_requestsDataFromURL() {
        let url = URL(string: "file:///path/to/someFile.csv")!
        let (sut, client) = makeSUT(with: url)
        
        sut.load() { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_load_requestsDataFromURLTwice() {
        let url = URL(string: "file:///path/to/someFile.csv")!
        let (sut, client) = makeSUT(with: url)
        
        sut.load() { _ in }
        sut.load() { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversNoFileErrorOnClientError() {
        let (sut, client) = makeSUT()
        let anyError = NSError(domain: "any error", code: 0)
        
        let exp = expectation(description: "Wait for client completion with error")
        sut.load { receivedError in
            XCTAssertEqual(receivedError, .noFile)
            exp.fulfill()
        }
        
        client.complete(with: anyError)
        
        wait(for: [exp], timeout: 0.1)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(with url: URL = URL(string: "file:///path/to/placeholderFile.csv")!) -> (ChartLoader, LocalClientSpy) {
        let client = LocalClientSpy()
        let sut = ChartLoader(client: client, url: url)
        
        return (sut, client)
    }
    
    private class LocalClientSpy: LocalClient {
        var messages = [(url: URL, completion: (Error) -> Void)]()
        var requestedURLs: [URL] {
            messages.map { $0.url }
        }
        
        func get(from url: URL, completion: @escaping (Error) -> Void) {
            messages.append((url, completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(error)
        }
    }
}

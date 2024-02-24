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
        let (sut, client) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestsDataFromURL() {
        let url = URL(string: "file:///path/to/someFile.csv")!
        let (sut, client) = makeSUT(with: url)
        
        sut.load()
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_load_requestsDataFromURLTwice() {
        let url = URL(string: "file:///path/to/someFile.csv")!
        let (sut, client) = makeSUT(with: url)
        
        sut.load()
        sut.load()
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(with url: URL = URL(string: "file:///path/to/placeholderFile.csv")!) -> (ChartLoader, LocalClientSpy) {
        let client = LocalClientSpy()
        let sut = ChartLoader(client: client, url: url)
        
        return (sut, client)
    }
    
    private class LocalClientSpy: LocalClient {
        var requestedURLs = [URL]()
        
        func get(from url: URL) {
            requestedURLs.append(url)
        }
    }
}

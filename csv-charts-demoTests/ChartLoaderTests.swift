//
//  ChartLoaderTests.swift
//  csv-charts-demoTests
//
//  Created by  Gosha Akmen on 23.02.2024.
//

import XCTest

protocol LocalClient {
    func get(from url: URL)
}

class ChartLoader {
    let client: LocalClient
    let url: URL
    
    init(client: LocalClient, url: URL) {
        self.client = client
        self.url = url
    }
    
    func load() {
        client.get(from: url)
    }
}

class ChartLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let (sut, client) = makeSUT()
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestsDataFromURL() {
        let url = URL(string: "file:///path/to/someFile.csv")!
        let (sut, client) = makeSUT(with: url)
        
        sut.load()
        
        XCTAssertEqual(client.requestedURL, url)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(with url: URL = URL(string: "file:///path/to/placeholderFile.csv")!) -> (ChartLoader, LocalClientSpy) {
        let client = LocalClientSpy()
        let sut = ChartLoader(client: client, url: url)
        
        return (sut, client)
    }
    
    private class LocalClientSpy: LocalClient {
        var requestedURL: URL?
        
        func get(from url: URL) {
            requestedURL = url
        }
    }
}

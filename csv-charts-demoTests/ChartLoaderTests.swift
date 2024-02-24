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
    
    init(client: LocalClient, url: URL = URL(string: "file:///path/to/placeholderFile.csv")!) {
        self.client = client
        self.url = url
    }
    
    func load() {
        client.get(from: url)
    }
}

class LocalClientSpy: LocalClient {
    var requestedURL: URL?
    
    func get(from url: URL) {
        requestedURL = url
    }
}

class ChartLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let client = LocalClientSpy()
        let sut = ChartLoader(client: client)
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestsDataFromURL() {
        let url = URL(string: "file:///path/to/someFile.csv")!
        let client = LocalClientSpy()
        let sut = ChartLoader(client: client, url: url)
        
        sut.load()
        
        XCTAssertEqual(client.requestedURL, url)
    }
}

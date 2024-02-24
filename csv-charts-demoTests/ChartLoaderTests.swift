//
//  ChartLoaderTests.swift
//  csv-charts-demoTests
//
//  Created by  Gosha Akmen on 23.02.2024.
//

import XCTest

class ChartLoader {
    
}

struct LocalStoreSpy {
    var requestedURL: URL?
}

class ChartLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let store = LocalStoreSpy()
        let sut = ChartLoader()
        
        XCTAssertNil(store.requestedURL)
    }
    
}

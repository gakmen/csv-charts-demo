//
//  ChartLoader.swift
//  csv-charts-demo
//
//  Created by  Gosha Akmen on 24.02.2024.
//

public protocol LocalClient {
    func get(from url: URL)
}

public final class ChartLoader {
    private let client: LocalClient
    private let url: URL
    
    public init(client: LocalClient, url: URL) {
        self.client = client
        self.url = url
    }
    
    public func load() {
        client.get(from: url)
    }
}

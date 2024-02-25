//
//  ChartLoader.swift
//  csv-charts-demo
//
//  Created by  Gosha Akmen on 24.02.2024.
//

public protocol LocalClient {
    func get(from url: URL, completion: @escaping (Swift.Error) -> Void)
}

public final class ChartLoader {
    private let client: LocalClient
    private let url: URL
    
    public init(client: LocalClient, url: URL) {
        self.client = client
        self.url = url
    }
    
    public enum Error: Swift.Error {
        case noFile
    }
    
    public func load(completion: @escaping (Error) -> Void) {
        client.get(from: url) { error in
            completion(.noFile)
        }
    }
}

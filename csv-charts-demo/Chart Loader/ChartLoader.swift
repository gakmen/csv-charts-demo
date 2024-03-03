//
//  ChartLoader.swift
//  csv-charts-demo
//
//  Created by  Gosha Akmen on 24.02.2024.
//

public protocol LocalClient {
    typealias ClientResult = Result<Data, Error>
    
    func get(from url: URL, completion: @escaping (ClientResult) -> Void)
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
        case emptyFile
        case invalidCsv
    }
    
    public func load(completion: @escaping (Error) -> Void) {
        client.get(from: url) { result in
            switch result {
            case let .success(data):
                if data.isEmpty { completion(.emptyFile) }
                else { completion(.invalidCsv) }
            case .failure:
                completion(.noFile)
            }
        }
    }
}

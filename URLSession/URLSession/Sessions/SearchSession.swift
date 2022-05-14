//
//  SearchSession.swift
//  URLSession
//

import Foundation

class SearchSession {
    
    private var resultsHandler: (([Result]) -> Void)!
    private let session = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    
    init(resultsHandler: @escaping ([Result]) -> Void) {
        self.resultsHandler = resultsHandler
    }
    
}

extension SearchSession {
    
    func searchMovie(_ text: String) {
        dataTask?.cancel()
        
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search")!
        urlComponents.query = "media=movie&entity=movie&attribute=movieTerm&term=\(text)"
        
        guard let url = urlComponents.url else { return }
        
        dataTask = session.dataTask(with: url) { [weak self] data, response, _ in
            defer {
                self?.dataTask = nil
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data, let results = (try? JSONDecoder().decode(Results.self, from: data))?.results else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.resultsHandler(results)
            }
        }
        
        dataTask?.resume()
    }
    
}

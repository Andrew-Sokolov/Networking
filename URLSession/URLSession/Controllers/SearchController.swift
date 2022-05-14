//
//  SearchController.swift
//  URLSession
//

import UIKit

class SearchController: UISearchController {
    
    private var searchText = String()
    private var resultsHandler: (([Result]) -> Void)!
    private lazy var searchSession = SearchSession(resultsHandler: resultsHandler)
    private var workItem: DispatchWorkItem?
    
    init(resultsHandler: @escaping ([Result]) -> Void) {
        super.init(searchResultsController: nil)
        self.resultsHandler = resultsHandler
        
        searchBar.placeholder = "Search Movie"
        obscuresBackgroundDuringPresentation = false
        searchResultsUpdater = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension SearchController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.replaceWhitespaceWithPluses, text != searchText else { return }
        
        workItem?.cancel()
        searchText = text
        
        guard !text.isEmpty else {
            resultsHandler([])
            return
        }
        
        workItem = DispatchWorkItem { [weak self] in
            self?.searchSession.searchMovie(text)
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1), execute: workItem!)
    }
    
}

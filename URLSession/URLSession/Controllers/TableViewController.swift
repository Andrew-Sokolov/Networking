//
//  TableViewController.swift
//  URLSession
//

import AVKit

class TableViewController: UITableViewController {
    
    private lazy var results = [Result]()
    private lazy var cache = [IndexPath: UITableViewCell]()
    
    private lazy var playHandler: (String) -> Void = { [weak self] previewUrl in
        self?.playVideo(from: previewUrl)
    }
    
}

extension TableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "iTunes Movies (US)"
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = SearchController { [weak self] results in
            self?.reloadTable(newValues: results)
        }
    }
    
}

extension TableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = cache[indexPath] { return cell }
        
        let cell = MovieCell.create()
        cell.setup(with: results[indexPath.row], playHandler: playHandler)
        cache[indexPath] = cell
        return cell
    }
    
}

extension TableViewController {
    
    private func reloadTable(newValues: [Result]) {
        results = newValues
        cache = [:]
        tableView.reloadData()
    }
    
    private func playVideo(from previewUrl: String) {
        guard let url = URL(string: previewUrl) else { return }
        
        let controller = AVPlayerViewController()
        controller.player = AVPlayer(url: url)
        
        present(controller, animated: true) {
            controller.player?.play()
        }
    }
    
}

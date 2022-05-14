//
//  MovieCell.swift
//  URLSession
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var trailerButton: UIButton!
    @IBOutlet private weak var artworkView: UIImageView!
    
    private var play: (() -> Void)?
    
}

extension MovieCell {
    
    func setup(with result: Result, playHandler: @escaping (String) -> Void) {
        selectionStyle = .none
        
        nameLabel.text = result.movieName
        genreLabel.text = result.movieGenre
        timeLabel.text = result.movieTime
        ratingLabel.text = result.movieRating
        descriptionLabel.text = result.movieDescription
        
        trailerButton.setCornerRadius(.cornerRadius)
        ratingLabel.setCornerRadius(.cornerRadius)
        ratingLabel.setBorder(width: .borderWidth, color: ratingLabel.textColor)
        
        if let previewUrl = result.previewUrl {
            play = { playHandler(previewUrl) }
            trailerButton.addTarget(self, action: #selector(trailerButtonClicked), for: .touchUpInside)
        } else {
            trailerButton.isUserInteractionEnabled = false
            trailerButton.backgroundColor = .systemGray
        }
        
        guard let artworkUrl100 = result.artworkUrl100, let url = URL(string: artworkUrl100) else { return }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.artworkView.image = UIImage(data: data)
            }
        }
    }
    
    @objc private func trailerButtonClicked() {
        play?()
    }
    
}

extension MovieCell {
    
    static func create() -> MovieCell {
        UINib(nibName: "MovieCell", bundle: nil).instantiate(withOwner: self, options: nil).last as! MovieCell
    }
    
}

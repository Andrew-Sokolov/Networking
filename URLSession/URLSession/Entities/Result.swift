//
//  Result.swift
//  URLSession
//

struct Results: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let trackName: String?
    let previewUrl: String?
    let artworkUrl100: String?
    let releaseDate: String?
    let trackTimeMillis: Int?
    let primaryGenreName: String?
    let contentAdvisoryRating: String?
    let longDescription: String?
}

extension Result {
    
    var movieName: String {
        var name = trackName ?? "-----"
        
        if let date = releaseDate {
            let year = String(date.prefix(4))
            name += " (" + year + ")"
        }
        
        return name
    }
    
    var movieGenre: String {
        primaryGenreName ?? "-----"
    }
    
    var movieTime: String {
        var hours = "-"
        var minutes = "--"
        
        if let ms = trackTimeMillis {
            var min = (ms / 1000) / 60
            let h = min / 60
            min -= h * 60
            
            hours = String(h)
            minutes = String(min)
        }
        
        return "\(hours)h \(minutes)min"
    }
    
    var movieRating: String {
        let rating = contentAdvisoryRating ?? "-"
        let indent = "  "
        return indent + rating + indent
    }
    
    var movieDescription: String {
        longDescription ?? "-----"
    }
    
}

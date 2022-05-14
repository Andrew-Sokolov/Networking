//
//  String.swift
//  URLSession
//

extension String {
    
    var replaceWhitespaceWithPluses: String {
        let components = self.components(separatedBy: .whitespaces)
        return components.filter { !$0.isEmpty }.joined(separator: "+")
    }
    
}

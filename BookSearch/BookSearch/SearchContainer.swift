//
//  SearchContainer.swift
//  BookSearch
//
//  Created by MCS on 12/19/19.
//  Copyright © 2019 PaulRenfrew. All rights reserved.
//

import Foundation

struct SearchContainer: Decodable {
    let searchFound: Int
    let searchResult: [SearchResult]
    
    enum CodingKeys: String, CodingKey {
        case searchFound = "numFound"
        case searchResult = "docs"
    }
}

struct SearchResult: Decodable {
    let title: String
    let publishYear: Int?
    
    enum CodingKeys: String, CodingKey{
        case title
        case publishYear = "first_publish_year"
    }
}

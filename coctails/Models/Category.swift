//
//  Category.swift
//  coctails
//
//  Created by Macbook Air on 13.09.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import Foundation

struct Category: Decodable {
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case title = "strCategory"
    }
}

struct Catigories: Decodable {
    var all: [Category]
    
    enum CodingKeys: String, CodingKey {
        case all = "drinks"
    }
}

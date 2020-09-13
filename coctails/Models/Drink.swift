//
//  Cocktail.swift
//  coctails
//
//  Created by Macbook Air on 11.09.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import Foundation

struct Drinks: Decodable {
    let all: [Drink]
    
    enum CodingKeys: String, CodingKey {
        case all = "drinks"
    }
}

struct Drink: Decodable {
    let title: String
    let thumbnailUrl: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case title = "strDrink"
        case thumbnailUrl = "strDrinkThumb"
    }
}

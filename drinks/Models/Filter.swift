//
//  Filter.swift
//  coctails
//
//  Created by Macbook Air on 13.09.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import Foundation

struct Filter {
    var allCategories: [Category]
    var indicesOfSelectedCategories: [Int]
    
    var selectedCategories: [Category] {
        indicesOfSelectedCategories.map { allCategories[$0] }
    }
}

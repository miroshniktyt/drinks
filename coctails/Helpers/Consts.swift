//
//  Consts.swift
//  coctails
//
//  Created by Macbook Air on 13.09.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

struct Consts {
    static let prefetchingNumber = 5 // on witch cell before the end of the list we should fetch more items
    static let spacing: CGFloat = 8
    static let inset: CGFloat = 20
    static let largeInset: CGFloat = 32
    static let checkmarkSize: CGSize = .init(width: 25, height: 25)
    static let thumbnailSize: CGSize = .init(width: 100, height: 100)
    static let applyButtonHeight: CGFloat = 52
    static var estimatedRowHeight: CGFloat { Consts.thumbnailSize.height + 2 * Consts.inset }
}

//
//  UIFont+.swift
//  coctails
//
//  Created by Macbook Air on 13.09.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

extension UIFont {
    static func robotoRegular(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "Roboto-Regular", size: size)
    }
    
    static func robotoMedium(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "Roboto-Medium", size: size)
    }
    
    static func robotoBold(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "Roboto-Bold", size: size)
    }
}

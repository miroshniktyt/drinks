//
//  InAppButton.swift
//  coctails
//
//  Created by Macbook Air on 13.09.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

extension UIButton {
    static func inAppButton(withTitle title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .label
        button.setTitleColor(.systemBackground, for: .normal)
        button.titleLabel?.font = .robotoBold(ofSize: 16)
        button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

//
//  CategoryHeaderView.swift
//  coctails
//
//  Created by Macbook Air on 13.09.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class CategoryHeaderView: UIView {
    init(title: String) {
        super.init(frame: .zero)
        
        let label = UILabel()
        label.font = .robotoRegular(ofSize: 16)
        label.text = title
        self.addSubview(label)
        label.fillSuperview(insets: .init(top: 20, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

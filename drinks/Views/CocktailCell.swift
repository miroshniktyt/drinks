//
//  DrinkCell.swift
//  coctails
//
//  Created by Macbook Air on 11.09.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit
import SDWebImage

class DrinkCell: UITableViewCell {
    
    var cocktail: Drink? {
        didSet {
            thumbView.sd_setImage(with: URL(string: cocktail?.thumbnailUrl ?? ""))
            titleLable.text = cocktail?.title
        }
    }
    
    private let titleLable: UILabel = {
        let label = UILabel()
        label.font = .robotoRegular(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let thumbView: UIImageView = {
        let view = UIImageView()
        view.ancherSize(size: Consts.thumbnailSize)
        view.contentMode = .scaleAspectFit
        view.image = #imageLiteral(resourceName: <#T##String#>).withRenderingMode(.alwaysOriginal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let stack = UIStackView(arrangedSubviews: [thumbView, titleLable])
        stack.spacing = Consts.spacing
        self.contentView.addSubview(stack)
        stack.fillSuperview(insets: .init(top: Consts.inset, left: Consts.inset, bottom: Consts.inset, right: Consts.inset))
    }
}

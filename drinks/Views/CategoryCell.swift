//
//  CategoryCell.swift
//  coctails
//
//  Created by Macbook Air on 11.09.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    var category: Category? {
        didSet {
            titleLable.text = category?.title
        }
    }
    
    private let titleLable: UILabel = {
        let label = UILabel()
        label.font = .robotoRegular(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let checkmark: UIImageView = {
        let view = UIImageView()
        view.ancherSize(size: Consts.checkmarkSize)
        view.contentMode = .scaleAspectFit
        view.image = #imageLiteral(resourceName: "checkmark")
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
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkmark.isHidden = selected ? false : true
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
    
    private func setupUI() {
        selectionStyle = .none
        let stack = UIStackView(arrangedSubviews: [titleLable, checkmark])
        stack.spacing = Consts.spacing
        self.contentView.addSubview(stack)
        stack.fillSuperview(insets: .init(top: Consts.largeInset, left: Consts.largeInset, bottom: Consts.largeInset, right: Consts.largeInset))
    }
}

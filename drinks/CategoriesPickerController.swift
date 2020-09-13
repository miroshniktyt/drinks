//
//  CategoriesPickerController.swift
//  coctails
//
//  Created by Macbook Air on 11.09.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

protocol CategoriesPickerControllerDelegate: class {
    func categoriesDidSet(_ selectedIndices: [Int])
}

class CategoriesPickerViewModel: UITableViewController {
    
    private let filter: Filter
    
    weak var delegate: CategoriesPickerControllerDelegate?
    
    private var selectedIndices: [Int] { tableView.indexPathsForSelectedRows?.map { $0.row }.sorted() ?? [] }
    
    private lazy var applyButton: UIButton = {
        let button = UIButton.inAppButton(withTitle: "APPLY")
        button.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(filter: Filter) {
        self.filter = filter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        title = "Drinks"
        tableView.register(CategoryCell.self, forCellReuseIdentifier: NSStringFromClass(CategoryCell.self))
        tableView.allowsMultipleSelection = true
        tableView.separatorStyle = .none
        tableView.contentInset = .init(top: 0, left: 0, bottom: Consts.applyButtonHeight + Consts.inset, right: 0)
        navigationItem.leftBarButtonItem = .init(image: #imageLiteral(resourceName: "arrow").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backButtonTapped))

        self.view.addSubview(applyButton)
        NSLayoutConstraint.activate([
            applyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Consts.inset),
            applyButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Consts.inset),
            applyButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Consts.inset),
            applyButton.heightAnchor.constraint(equalToConstant: Consts.applyButtonHeight),
        ])
    }
    
    private func apply() {
        delegate?.categoriesDidSet(selectedIndices)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func applyButtonTapped() {
        if selectedIndices == filter.indicesOfSelectedCategories {
            presentNoChangesAlert()
        } else {
            apply()
        }
    }
    
    @objc private func backButtonTapped() {
        print(selectedIndices, filter.indicesOfSelectedCategories)
        if selectedIndices == filter.indicesOfSelectedCategories {
            navigationController?.popViewController(animated: true)
        } else {
            presentApplyOrNotAlert()
        }
    }
    
    func presentNoChangesAlert() {
        let alert = UIAlertController(title: "Looks like you didn't make any changes", message: nil, preferredStyle: .actionSheet)
        let goBackAction = UIAlertAction(title: "Go back anyways", style: .default) { _ in self.navigationController?.popViewController(animated: true) }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        [goBackAction, cancelAction].forEach { alert.addAction($0) }
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentApplyOrNotAlert() {
        let alert = UIAlertController(title: "You didn't apply filters", message: nil, preferredStyle: .actionSheet)
        let applyAction = UIAlertAction(title: "Apply", style: .default) { _ in self.navigationController?.popViewController(animated: true) }
        let dontApplyAction = UIAlertAction(title: "Don't apply", style: .default) { _ in self.dismiss(animated: true, completion: nil) }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        [applyAction, dontApplyAction, cancelAction].forEach { alert.addAction($0) }
        self.present(alert, animated: true, completion: nil)
    }
}

extension CategoriesPickerViewModel {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filter.allCategories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(CategoryCell.self), for: indexPath) as? CategoryCell else { return UITableViewCell() }
        cell.category = filter.allCategories[indexPath.row]
        let isSelected = filter.indicesOfSelectedCategories.contains { $0 == indexPath.row}
        if isSelected { tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none) }
        return cell
    }
}

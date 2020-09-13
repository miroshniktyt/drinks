//
//  RootViewController.swift
//  coctails
//
//  Created by Macbook Air on 10.09.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class DrinksViewController: UITableViewController {
    
    private var currentNumberOfSections = 0
    private var filter = Filter(allCategories: [], indicesOfSelectedCategories: [])
    private var drinksPerCategory = [String: Drinks]()
        
    init() {
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchCocktailsTypes()
    }
    
    private func setupUI() {
        tableView.register(CocktailCell.self, forCellReuseIdentifier: NSStringFromClass(CocktailCell.self))
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = Consts.estimatedRowHeight
        title = "Drinks"
    }
    
    private func fetchCocktailsTypes() {
        Service().fetchCategories { [weak self] (result) in
            switch result {
            case .failure(let err):
                print(err)
                self?.present(err.alert, animated: true, completion: nil)
            case .success(let categories):
                let indicesOfSelectedCategories = Array(0..<categories.count) // setting all selected as a default filter
                self?.filter = .init(allCategories: categories, indicesOfSelectedCategories: indicesOfSelectedCategories)
                self?.fetchNextSection()
                self?.navigationItem.rightBarButtonItem = .init(image: #imageLiteral(resourceName: "filter"), style: .plain, target: self, action: #selector(self?.filterButtonTaped))
            }
        }
    }
    
    private func fetchNextSection() {
        let nextSelectedIndex = currentNumberOfSections
        guard nextSelectedIndex < filter.selectedCategories.count else {
            print("Reached the last selected category")
            return
        }
        let categoryToFetch = filter.selectedCategories[nextSelectedIndex]
        
        // get stored coctails if we have one (we could have fetched it before)
        if drinksPerCategory[categoryToFetch.title] != nil {
            currentNumberOfSections += 1
            tableView.insertSections(.init(integer: nextSelectedIndex), with: .top)
            return
        }
        
        Service().fetchDrinks(forCategory: categoryToFetch.title) { [weak self] (result) in
            switch result {
            case .failure(let err):
                print(err)
                self?.present(err.alert, animated: true, completion: nil)
            case .success(let coctails):
                self?.drinksPerCategory[categoryToFetch.title] = coctails
                self?.currentNumberOfSections += 1
                self?.tableView.insertSections(.init(integer: nextSelectedIndex), with: .top)
            }
        }
    }

    @objc private func filterButtonTaped() {
        let vc = CategoriesPickerViewModel(filter: filter)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension DrinksViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int { currentNumberOfSections }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = filter.selectedCategories[section].title
        return drinksPerCategory[key]?.all.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = filter.selectedCategories[section].title
        let view = CategoryHeaderView(title: title)
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(CocktailCell.self), for: indexPath) as? CocktailCell else { return UITableViewCell() }
        let key = filter.selectedCategories[indexPath.section].title
        cell.cocktail = drinksPerCategory[key]?.all[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let isRowToMakePrefetchOn = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - Consts.prefetchingNumber
        let isLastSection = indexPath.section == tableView.numberOfSections - 1
        let isTimeToFetchMore = isLastSection && isRowToMakePrefetchOn
        if isTimeToFetchMore {
            print("Time to fetching more items")
            fetchNextSection()
        }
    }
}

extension DrinksViewController: CategoriesPickerControllerDelegate {
    
    func categoriesDidSet(_ selectedIndices: [Int]) {
        self.filter.indicesOfSelectedCategories = selectedIndices
        currentNumberOfSections = 0
        tableView.reloadData()
        fetchNextSection()
    }

}

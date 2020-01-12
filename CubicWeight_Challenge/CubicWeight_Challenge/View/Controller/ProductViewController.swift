//
//  ViewController.swift
//  CubicWeight_Challenge
//
//  Created by iOS Developer on 1/11/20.
//  Copyright © 2020 kogan. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var averageCubicWeightLabel: UILabel!
    
    var viewModel: ProductViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProductViewModel()
        setupTableView()
        bindUI()
        viewModel.loadNextPage()
        self.title = "Products"
    }
    
    @IBAction func nextButtonClick(_ sender: Any) {
        viewModel.loadNextPage()
    }
}

// MARK: Private functions
extension ProductViewController {
    private func setupTableView() {
        tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 600
        tableView.register(UINib(nibName: Constants.CellIdentifier.productCell, bundle: nil), forCellReuseIdentifier: Constants.CellIdentifier.productCell)
    }
    
    private func bindUI() {
        viewModel.reloadTable =  { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.averageCubicWeightLabel.text = "\(self?.viewModel.calculateACAverageCubicWeight() ?? 0)kg"
            }
        }
        
        viewModel.showAlertClosure = { [weak self] error in
            DispatchQueue.main.async {
                self?.alert(title: "Error", message: error, okButtonTitle: "Ok")
            }
        }
    }
}

// MARK: TableView Datasource
extension ProductViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getProductCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.productCell, for: indexPath) as! ProductCell
        cell.setupCell(title: viewModel.getTitle(at: indexPath.row) ?? "", category: viewModel.getCategory(at: indexPath.row) ?? "")
        return cell
    }
}



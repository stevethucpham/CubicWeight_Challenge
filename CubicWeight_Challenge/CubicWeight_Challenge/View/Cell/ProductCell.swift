//
//  ProductCell.swift
//  CubicWeight_Challenge
//
//  Created by iOS Developer on 1/11/20.
//  Copyright © 2020 kogan. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    func setupCell(title: String, category: String) {
        self.titleLabel.text = title
        self.categoryLabel.text = category
        if category == "Air Conditioners" {
            self.backgroundColor = .lightGray
        } else {
            self.backgroundColor = .white
        }
    }
}

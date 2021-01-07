//
//  TableViewCell.swift
//  DictVsArray
//
//  Created by Petra Čačkov on 05/01/2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet private var titleLabel: UILabel?
    @IBOutlet private var valueLabel: UILabel?
    
    var title: String? {
        didSet { titleLabel?.text = title }
    }
    
    var value: String? {
        didSet { valueLabel?.text = value }
    }
    
}

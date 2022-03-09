//
//  HistoryTranslateCell.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 07.03.2022.
//

import UIKit

class HistoryTranslateCell: UITableViewCell {

    static let reuseIdentifier = "HistoryTranslateCell"
    
    @IBOutlet weak var original: UILabel!
    @IBOutlet weak var translation: UILabel!
    
    func setupCell(original: String, translation: String) {
        self.original.text = original
        self.translation.text = translation
    }

}

//
//  HoneyTableViewCell.swift
//  Assessment3
//
//  Created by Colton Brenneman on 6/8/23.
//

import UIKit

protocol HoneyTableViewCellDelegate: AnyObject {
    func toggleCompletionState(cell: HoneyTableViewCell)
}

class HoneyTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tasksCountLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: HoneyTableViewCellDelegate?
    
    // MARK: - Functions
    func configure(with honey: Honey) {
        nameLabel.text = honey.choreName
        tasksCountLabel.text = "\(honey.choreCount)"
        
    }
    
    // MARK: - Actions
    @IBAction func completeButtonTapped(_ sender: Any) {
        delegate?.toggleCompletionState(cell: self)
    }
} // End of class

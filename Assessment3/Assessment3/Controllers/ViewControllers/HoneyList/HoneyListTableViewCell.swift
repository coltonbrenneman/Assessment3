//
//  HoneyListTableViewCell.swift
//  Assessment3
//
//  Created by Colton Brenneman on 8/30/23.
//

import UIKit

protocol HoneyListTableViewCellDelegate: AnyObject {
    func toggleIsCompleteButtonWasTapped(cell: HoneyListTableViewCell)
}

class HoneyListTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var honeyCountLabel: UILabel!
    
    // MARK: - Properties
    weak var delegate: HoneyListTableViewCellDelegate? // COLTON DON'T FORGET TO HIRE THE DELEGATE IDIOT
    
    // MARK: - Functions
    func updateUI(honey: Honey) {
        itemNameLabel.text = honey.honeyName
        honeyCountLabel.text = "\(honey.honeyItem.count)"
        
        let image = honey.honeyCompleted ? UIImage(systemName: "checkmark.diamond.fill") : UIImage(systemName: "checkmark.diamond")
        isCompleteButton.setImage(image, for: .normal)
    } // End of updateUI
    
    // MARK: - Actions
    
    @IBAction func isCompleteButtonTapped(_ sender: Any) {
        delegate?.toggleIsCompleteButtonWasTapped(cell: self)
    }
    
} // End of class

//
//  HoneyDetailTableViewCell.swift
//  Assessment3
//
//  Created by Colton Brenneman on 8/30/23.
//

import UIKit

protocol HoneyDetailTableViewCellDelegate: AnyObject {
    func toggleChoreIsCompletedButtonWasTapped(cell: HoneyDetailTableViewCell)
}

class HoneyDetailTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var choreNameLabel: UILabel!
    @IBOutlet weak var choreIsCompletedButton: UIButton!
    
    // MARK: - Properties
    var item: Item? {
        didSet {
            
        }
    }
    weak var delegate: HoneyDetailTableViewCellDelegate? // Don't forget the delegate again Colton
    
    // MARK: - Functions
    func updateUI() {
        guard let item = item else { return }
        choreNameLabel.text = item.itemName
        
        let imageName = item.itemCompleted ? "checkmark.square.fill" : "checkmark.square"
        let image = UIImage(systemName: imageName)
        choreIsCompletedButton.setImage(image, for: .normal)
    } // End of updateUI
    
    // MARK: - Actions

    @IBAction func choreIsCompletedButtonTapped(_ sender: Any) {
        delegate?.toggleChoreIsCompletedButtonWasTapped(cell: self)
    }
} // End of class

//
//  HoneyDetailTableViewController.swift
//  Assessment3
//
//  Created by Colton Brenneman on 8/30/23.
//

import UIKit

class HoneyDetailTableViewController: UITableViewController {

    // MARK: - Outlets
    @IBOutlet weak var choreNameLabel: UITextField!
    
    // MARK: - Properties
    var honeySentViaSegue: Honey?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Actions
    @IBAction func addChoreButtonTapped(_ sender: Any) {
        guard let honey = honeySentViaSegue,
        let newHoneyName = choreNameLabel.text else { return }
        if newHoneyName.isEmpty {
            presentUnnamedHoneyAlertController()
        } else {
            ItemController.createItem(newItemName: newHoneyName, honey: honey)
        }
        tableView.reloadData()
    }
    
    // MARK: - Alert
    private func presentClearAllChoresAlertController() {
        let alertController = UIAlertController(title: "Done?", message: "Remove these items?", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Keep it", style: .cancel)
        let clearItems = UIAlertAction(title: "Clear Honey", style: .default) { _ in
            guard let honeySentViaSegue = self.honeySentViaSegue else { return }
            ItemController.clearAllItems(honey: honeySentViaSegue)
            self.tableView.reloadData()
        }
        
        let confirmDeleteHoney = UIAlertAction(title: "Delete Honey", style: .destructive) { _ in
            guard let honey = self.honeySentViaSegue else { return }
            ChoreController.shared.deleteHoney(honeyToRemove: honey)
            self.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(dismissAction)
        alertController.addAction(confirmDeleteHoney)
        alertController.addAction(clearItems)
        present(alertController, animated: true)
    } // End of func
    
    private func presentUnnamedHoneyAlertController() {
        let alertController = UIAlertController(title: "Emptry", message: "Please create a honey", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    } // End of func
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return honeySentViaSegue?.honeyItem.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "choreCell", for: indexPath) as? HoneyDetailTableViewCell, let honey = honeySentViaSegue else { return UITableViewCell() }

        let honeyRecieved = honey.honeyItem[indexPath.row]
        cell.item = honeyRecieved
        cell.delegate = self

        return cell
    }
  
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let honey = honeySentViaSegue else { return }
            let deleteHoney = honey.honeyItem[indexPath.row]
            ItemController.deleteItem(itemToBeDelted: deleteHoney, honey: honey)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

} // End of class

// MARK: - Extension
extension HoneyDetailTableViewController: HoneyDetailTableViewCellDelegate {
    func toggleChoreIsCompletedButtonWasTapped(cell: HoneyDetailTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell),
              let honeyRecieved = honeySentViaSegue else { return }
        let honey = honeyRecieved.honeyItem[indexPath.row]
        ItemController.toggleItemIsCompleted(item: honey)
        cell.updateUI()
        checkAllCompleted()
    }
    private func checkAllCompleted() {
        guard let honey = honeySentViaSegue else { return }
        for honey in honey.honeyItem {
            if honey.itemCompleted == false {
                return
            }
        }
        presentClearAllChoresAlertController()
    }
}

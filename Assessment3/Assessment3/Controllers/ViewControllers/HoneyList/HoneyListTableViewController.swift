//
//  HoneyListTableViewController.swift
//  Assessment3
//
//  Created by Colton Brenneman on 8/30/23.
//

import UIKit

class HoneyListTableViewController: UITableViewController {

    // MARK: - Properties
    @IBOutlet weak var honeyNameTextField: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func createHoneyButtonTapped(_ sender: Any) {
        guard let newHoneyName = honeyNameTextField.text else { return }
        if newHoneyName.isEmpty {
            presentHoneyAlertController()
        } else {
            ChoreController.shared.createHoney(name: newHoneyName)
        }
        tableView.reloadData()
    }
    
    // MARK: - Function
    private func presentHoneyAlertController() {
        let alertController = UIAlertController(title: "The text field is empty...", message: "Fill it out ya dummy...", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "AHAHA", style: .default)
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    } // End of presentHoneyAlertController
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChoreController.shared.honey.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "createCell", for: indexPath) as? HoneyListTableViewCell else { return UITableViewCell() }

        let honey = ChoreController.shared.honey[indexPath.row]
        cell.updateUI(honey: honey)
        cell.delegate = self
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deleteHoney = ChoreController.shared.honey[indexPath.row]
            ChoreController.shared.deleteHoney(honeyToRemove: deleteHoney)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let destination = segue.destination as? HoneyDetailTableViewController {
                    let honeySent = ChoreController.shared.honey[indexPath.row]
                    destination.honeySentViaSegue = honeySent
                }
            }
        }
    }
} // End of class

// MARK: - Extension
extension HoneyListTableViewController: HoneyListTableViewCellDelegate {
    func toggleIsCompleteButtonWasTapped(cell: HoneyListTableViewCell) {
        guard let honeyCell = tableView.indexPath(for: cell) else { return }
        let honey = ChoreController.shared.honey[honeyCell.row]
        ChoreController.shared.toggleHoneyIsCompleted(honey: honey)
        cell.updateUI(honey: honey)
    }
}

//
//  HoneyDoListTableViewController.swift
//  Assessment3
//
//  Created by Colton Brenneman on 6/8/23.
//

import UIKit

class HoneyDoListTableViewController: UITableViewController {

    // MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    
    // MARK: - Properties
    var honeys: [Honey] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }

    // MARK: - DataTask
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return honeys.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HoneyDoCell", for: indexPath) as? HoneyTableViewCell else { return UITableViewCell() }
            let honey = honeys[indexPath.row]
            cell.configure(with: honey)
            cell.delegate = self
            return cell
        }
        
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                honeys.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            }
        
    // MARK: - Actions
    @IBAction func createHoneyDo(_ sender: UIButton) {
        guard let honeyDoName = nameTextField.text, !honeyDoName.isEmpty else {
            return
        }
            HoneyController.sharedInstance.createHoney(choreName: honeyDoName, choreCount: 0)
            tableView.reloadData()
            nameTextField.text = ""
        }
    
    
    // MARK: - Navigatoin
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toDetailVC",
              let indexPath = tableView.indexPathForSelectedRow,
              let destination = segue.destination as? HoneyDoDetailTableViewController else { return }
        let honey = honeys[indexPath.row]
            
        destination.task = honey
    }
        } //end of class
// MARK: - Extensions
extension HoneyDoListTableViewController: HoneyTableViewCellDelegate {
    func toggleCompletionState(cell: HoneyTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        let honeyDo = honeys[indexPath.row]
        HoneyController.sharedInstance.toggleAllCompleted()

        let alert = UIAlertController(title: "Delete Honey-Do?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.honeys.remove(at: indexPath.row)
            self?.tableView.deleteRows(at: [indexPath], with: .automatic)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(alert, animated: true, completion: nil)
    }
}

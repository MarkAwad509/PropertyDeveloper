//
//  DepenseTableViewController.swift
//  ProjetLivrable1
//
//  Created by Maxim Proulx on 2023-03-14.
//

import UIKit

class DepenseTableViewController: UITableViewController {
    @IBOutlet weak var lbl_desc: UILabel!
    @IBOutlet weak var lbl_title: UILabel!
    var depenses: [Depense] = []
    var projet: Projet!
    override func viewDidLoad() {
        if let proj = projet{
            self.depenses = DepenseDAO.shared.Depenses(projet: projet)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.depenses.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "depenseCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.depenses[indexPath.row].raison
        
        return cell
    }

    @IBAction func ajouterDepense(_ sender: Any) {
        let alert = UIAlertController(title: "Ajout d'une dépense", message: "", preferredStyle: .alert)
        alert.addTextField{(textfield) in
            textfield.placeholder = "Raison"
            textfield.textColor = UIColor.blue
        }
        alert.addTextField{(textfield) in
            textfield.placeholder = "Somme"
            textfield.textColor = UIColor.red
        }
        alert.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
            textField.placeholder = "Compte Bancaire"
            let button = UIButton(type: .custom)
            button.setTitle("Select", for: .normal)
            button.menu = UIMenu(children: (0...1).map({ num in
                UIAction(title: String(num)) { action in
                    textField.text = String(CompteBancaireDAO.shared.ComptesBancaire()[num].nom!)
                }
            }))
            button.showsMenuAsPrimaryAction = true
            textField.rightView = button
            textField.rightViewMode = .always
        })
        
        //Actions
        let saveAction = UIAlertAction(title: "Ajouter", style: .default, handler: { _ in
            if let raison = alert.textFields?[0].text, let montant = Double(alert.textFields?[1].text ?? "0") {
                //Ajout a la bcContext
                let depense = DepenseDAO.shared.addDepense(raison: raison, montant: montant)
                
                //Mise a jour de l'affichage tableview
                self.depenses.append(depense)
                self.tableView.reloadData()
            }
        })
        let cancelAction = UIAlertAction(title: "Annuler", style: .default, handler: {
            _ in
        })
        
        //Add action to alert
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        //Present alert
        present(alert, animated: true)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destination = segue.destination as? AddDepenseViewController
        destination?.projet = self.projet
    }
}

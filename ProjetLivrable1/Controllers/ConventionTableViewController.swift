//
//  ConventionTableViewController.swift
//  ProjetLivrable1
//
//  Created by Maxim Proulx on 2023-03-14.
//

import UIKit

class ConventionTableViewController: UITableViewController {

    var conventions: [Convention] = []
    override func viewDidLoad() {
        self.conventions = ConventionDAO.shared.Conventions()
        //MaxDataManager.shared.initDatas()
        //super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.conventions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "conventionCell", for: indexPath)

        // Configure the cell...
        cell.textLabel!.text = "Domaine: \(String(describing: self.conventions[indexPath.row].domaine!))"
        cell.detailTextLabel!.text = "Fournisseur: \(String(describing: self.conventions[indexPath.row].fournisseur ?? "Pas de fournisseur"))"
        

        return cell
    }

    @IBAction func ajouterConvention(_ sender: Any) {
        let alert = UIAlertController(title: "Ajout d'une convention", message: "", preferredStyle: .alert)
        alert.addTextField{(textfield) in
            textfield.placeholder = "Domaine"
            textfield.textColor = UIColor.blue
        }
        alert.addTextField{(textfield) in
            textfield.placeholder = "Fournisseur"
            textfield.textColor = UIColor.systemPink
        }
        
        //Actions
        let saveAction = UIAlertAction(title: "Ajouter", style: .default, handler: { _ in
            if let domaine = alert.textFields?[0].text, let fournisseur = alert.textFields?[1].text {
                //Ajout a la bcContext
                let convention = ConventionDAO.shared.addConvention(domaine: domaine, fournisseur: fournisseur)
                //Mise a jour de l'affichage tableview
                self.conventions.append(convention)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

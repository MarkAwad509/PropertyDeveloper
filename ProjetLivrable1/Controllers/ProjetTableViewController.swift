//
//  ProjetTableViewController.swift
//  ProjetLivrable1
//
//  Created by Maxim Proulx on 2023-03-14.
//

import UIKit

class ProjetTableViewController: UITableViewController {
    var projets: [Projet] = []
    override func viewDidLoad() {
        //super.viewDidLoad()
        MaxDataManager.shared.removeAllDatas()
        MaxDataManager.shared.initDatas()
        self.projets = ProjetDAO.shared.projets()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.projets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projetCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.projets[indexPath.row].nom

        return cell
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
        // Recuperer l'index de la cellule sur lequel le user tapotte
        let cell = sender as! UITableViewCell
        let index = tableView.indexPath(for: cell)!.row
        
        //envoyer l'adresse à PeopleViewTableController
        let destination = segue.destination as? DepenseTableViewController
        destination?.projet = self.projets[index]
    }
    

}

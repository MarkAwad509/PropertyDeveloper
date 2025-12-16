//
//  ProjetDetailViewController.swift
//  ProjetLivrable1
//
//  Created by Mark Awad on 2023-03-15.
//

import UIKit

class ProjetDetailViewController: UIViewController {
    var projet: Projet!
    @IBOutlet weak var titre: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titre.text = projet.nom
        desc.text = projet.desc
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

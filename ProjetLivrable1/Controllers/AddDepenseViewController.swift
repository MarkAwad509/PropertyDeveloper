//
//  AddDepenseViewController.swift
//  ProjetLivrable1
//
//  Created by Maxim Proulx on 2023-03-15.
//

import UIKit

class AddDepenseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var input_montant: UITextField!
    @IBOutlet weak var dropdown_compte: UIPickerView!
    @IBOutlet weak var input_raison: UITextField!
    var comptes: [CompteBancaire] = []
    var compteSelected: String = ""
    var projet: Projet?
    
    override func viewDidLoad() {
        self.dropdown_compte.delegate = self
        self.dropdown_compte.dataSource = self
        self.comptes = CompteBancaireDAO.shared.ComptesBancaire()
        super.viewDidLoad()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.comptes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.comptes[row].nom
    }
    
    @IBAction func ajouterDepense(_ sender: Any) {
        var raison = self.input_raison.text! ?? ""
        var somme = Double(self.input_montant.text!) ?? 0.0
        let depense = DepenseDAO.shared.addDepense(raison: raison, montant: somme)
        DepenseDAO.shared.addDepenseToProjet(depense: depense, projet: projet!, nomCompteBancaire: self.compteSelected)
        self.input_raison.text = ""
        self.input_montant.text = ""
        
        let alert = UIAlertController(title: "La dépense a été ajoutée avec succès", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .default, handler: {
            _ in
        })
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.compteSelected = self.comptes[row].nom ?? "BC1_RBC"
    }
}

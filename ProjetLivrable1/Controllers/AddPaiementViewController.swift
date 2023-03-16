//
//  AddPaiementViewController.swift
//  ProjetLivrable1
//
//  Created by Maxim Proulx on 2023-03-15.
//

import UIKit

class AddPaiementViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var input_montant: UITextField!
    @IBOutlet weak var date_debut: UIDatePicker!
    @IBOutlet weak var date_fin: UIDatePicker!
    @IBOutlet weak var date_paiement: UIDatePicker!
    @IBOutlet weak var picker_modePaiement: UIPickerView!
    @IBOutlet weak var picker_convention: UIPickerView!
    var compte: CompteBancaire!
    var conventions: [Convention] = []
    var modePaiements: [String] = [Mode.Cheque.rawValue, Mode.Espece.rawValue]
    var selectedConvention: String = ""
    var selectedMode: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker_convention.delegate = self
        self.picker_convention.dataSource = self
        self.picker_modePaiement.delegate = self
        self.picker_modePaiement.dataSource = self
        self.picker_convention.tag = 1
        self.picker_modePaiement.tag = 2
        self.conventions = ConventionDAO.shared.Conventions()
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag{
            case 1:
                return self.modePaiements.count
            case 2:
                return self.conventions.count
        default:
                return 1
        }
    }
    
    @IBAction func ajouterPaiement(_ sender: Any) {
        var montant = Double(self.input_montant.text!) ?? 0
        let paiement = PaiementDAO.shared.addPaiement(dateDebut: self.date_debut.date, dateFin: self.date_fin.date, datePaiement: self.date_paiement.date, mode: Mode(rawValue: self.selectedMode) ?? Mode.Espece, montant: montant)
        PaiementDAO.shared.addPaiementToCompte(paiement: paiement, compteBancaire: self.compte, nomConvention: selectedConvention)
        let alert = UIAlertController(title: "Le paiement a été ajouté avec succès", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .default, handler: {
            _ in
        })
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag{
        case 1:
            self.selectedMode = self.modePaiements[row]
        case 2:
            self.selectedConvention = self.conventions[row].description
        default:
            break
        }
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

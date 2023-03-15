//
//  DepenseDAO.swift
//  ProjetLivrable1
//
//  Created by Maxim Proulx on 2023-03-14.
//

import Foundation

protocol IDepenseDAO{
    func Depenses(projet: Projet) -> [Depense]
    func addDepense(raison: String, montant: Double) ->  Depense
    func addDepenseToProjet(depense: Depense, projet: Projet, nomCompteBancaire: String)
    func removeDepense(raison: String, montant: Double, projet: Projet)
}

class DepenseDAO: IDepenseDAO{
    static let shared = DepenseDAO()
    
    func Depenses(projet: Projet) -> [Depense] {
        return MaxDataManager.shared.Depenses(projet: projet)
    }
    
    func addDepense(raison: String, montant: Double) -> Depense {
        return MaxDataManager.shared.initDepense(raison: raison, montant: montant)
    }
    
    func addDepenseToProjet(depense: Depense, projet: Projet, nomCompteBancaire: String) {
        MaxDataManager.shared.addDepenseToProjet(depense: depense, nomCompteBancaire: nomCompteBancaire, projet: projet)
    }
    
    func removeDepense(raison: String, montant: Double, projet: Projet) {
        MaxDataManager.shared.deleteDepense(raison: raison, montant: montant, projet: projet)
    }
}

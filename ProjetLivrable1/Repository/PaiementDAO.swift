//
//  PaiementDAO.swift
//  ProjetLivrable1
//
//  Created by Maxim Proulx on 2023-03-14.
//

import Foundation

protocol IPaiementDAO{
    func Paiements(compte: CompteBancaire) -> [Paiement]
    func addPaiement(dateDebut: Date, dateFin: Date, datePaiement: Date, mode: Mode, montant: Double) -> Paiement
    func addPaiementToCompte(paiement: Paiement, compteBancaire: CompteBancaire, nomConvention: String)
    func removePaiement(date: Date, mode: Mode, montant: Double, compte: CompteBancaire)
}

class PaiementDAO: IPaiementDAO{
    
    static let shared = PaiementDAO()
    
    func Paiements(compte: CompteBancaire) -> [Paiement] {
        return MaxDataManager.shared.Paiements(compte: compte)
    }
    
    func addPaiement(dateDebut: Date, dateFin: Date, datePaiement: Date, mode: Mode, montant: Double) -> Paiement {
        return MaxDataManager.shared.initPaiement(dateDebut: dateDebut, dateFin: dateFin, datePaiement: datePaiement, mode: mode, montant: montant)
    }
    
    func addPaiementToCompte(paiement: Paiement, compteBancaire: CompteBancaire, nomConvention: String){
        MaxDataManager.shared.addPaiementToCompte(paiement: paiement, compteBancaire: compteBancaire, nomConvention: nomConvention)
    }
    
    func removePaiement(date: Date, mode: Mode, montant: Double, compte: CompteBancaire) {
        MaxDataManager.shared.deletePaiement(date: date, mode: mode, montant: montant, compte: compte)
    }
}

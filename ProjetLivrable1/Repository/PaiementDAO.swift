//
//  PaiementDAO.swift
//  ProjetLivrable1
//
//  Created by Maxim Proulx on 2023-03-14.
//

import Foundation

protocol IPaiementDAO{
    func Paiements() -> [Paiement]
    func addPaiement(date: Date, mode: Mode, montant: Double) -> Paiement
    func removePaiement(date: Date, mode: Mode, montant: Double)
}

class PaiementDAO: IPaiementDAO{
    
    static let shared = PaiementDAO()
    
    func Paiements() -> [Paiement] {
        return MaxDataManager.shared.Paiements()
    }
    
    func addPaiement(date: Date, mode: Mode, montant: Double) -> Paiement {
        return MaxDataManager.shared.initPaiement(date: date, mode: mode, montant: montant)
    }
    
    func removePaiement(date: Date, mode: Mode, montant: Double) {
        MaxDataManager.shared.deletePaiement(date: date, mode: mode, montant: montant)
    }
}

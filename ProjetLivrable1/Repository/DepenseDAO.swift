//
//  DepenseDAO.swift
//  ProjetLivrable1
//
//  Created by Maxim Proulx on 2023-03-14.
//

import Foundation

protocol IDepenseDAO{
    func Depenses() -> [Depense]
    func addDepense(raison: String, montant: Double) ->  Depense
    func removeDepense(raison: String, montant: Double)
}

class DepenseDAO: IDepenseDAO{
    static let shared = DepenseDAO()
    
    func Depenses() -> [Depense] {
        return MaxDataManager.shared.Depenses()
    }
    
    func addDepense(raison: String, montant: Double) -> Depense {
        return MaxDataManager.shared.initDepense(raison: raison, montant: montant)
    }
    
    func removeDepense(raison: String, montant: Double) {
        MaxDataManager.shared.deleteDepense(raison: raison, montant: montant)
    }
}

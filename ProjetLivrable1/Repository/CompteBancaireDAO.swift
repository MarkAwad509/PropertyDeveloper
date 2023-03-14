//
//  CompteBancaireDAO.swift
//  ProjetLivrable1
//
//  Created by Maxim Proulx on 2023-03-14.
//

import Foundation

protocol ICompteBancaireDAO{
    func ComptesBancaire() -> [CompteBancaire]
}

class CompteBancaireDAO: ICompteBancaireDAO{
    
    static let shared = CompteBancaireDAO()
    
    func ComptesBancaire() -> [CompteBancaire] {
        return MaxDataManager.shared.Comptes()
    }
}

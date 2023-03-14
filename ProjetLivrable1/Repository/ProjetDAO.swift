//
//  ProjetDAO.swift
//  ProjetLivrable1
//
//  Created by Maxim Proulx on 2023-03-08.
//

import Foundation

protocol IProjetDAO{
    func projets() -> [Projet]
}

class ProjetDAO: IProjetDAO{
    
    static let shared = ProjetDAO()
    
    func projets() -> [Projet] {
        return MaxDataManager.shared.Projets()
    }
}

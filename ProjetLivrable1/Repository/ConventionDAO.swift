//
//  ConventionDAO.swift
//  ProjetLivrable1
//
//  Created by Maxim Proulx on 2023-03-14.
//

import Foundation

protocol IConventionDAO{
    func Conventions() -> [Convention]
}

class ConventionDAO: IConventionDAO{
    
    static let shared = ConventionDAO()
    
    func Conventions() -> [Convention] {
        return MaxDataManager.shared.Conventions()
    }
}

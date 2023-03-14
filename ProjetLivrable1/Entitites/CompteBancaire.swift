//
//  CompteBancaire.swift
//  ProjetLivrable1
//
//  Created by Maxim Proulx on 2023-03-08.
//

import Foundation

extension CompteBancaire{

    func withdrawAccepted(montant: Double) -> Bool{
        return montant <= self.somme
    }
    
    func retirerSomme(montant: Double){
        if withdrawAccepted(montant: montant){
            self.somme -= montant
        }
    }
}

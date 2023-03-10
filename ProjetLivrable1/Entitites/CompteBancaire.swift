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
    
    func toString() -> String{
        var to_return = "{\"compagnieBancaire\": \(self.compagnieBancaire), \"montant\": \(self.somme )}"
        for (var depense in self.)
    }
}

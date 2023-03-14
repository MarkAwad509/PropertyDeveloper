//
//  Paiement.swift
//  ProjetLivrable1
//
//  Created by Maxim Proulx on 2023-03-12.
//

import Foundation

enum Mode: String{
    case Cheque = "Cheque"
    case Espece = "Espece"
}

extension Paiement{
    var modeDePaiement: Mode{
        get{
            return Mode(rawValue: self.mode!)!
        }
        set{
            self.mode = newValue.rawValue
        }
    }
}

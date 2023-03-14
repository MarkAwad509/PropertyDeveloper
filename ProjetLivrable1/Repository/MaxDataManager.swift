//
//  DataManager.swift
//  ProjetLivrable1
//
//  Created by Maxim Proulx on 2023-03-08.
//

import Foundation
import CoreData

class MaxDataManager{
    static let shared = MaxDataManager()
    
    //MARK: Persistent controller initialization
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Demo05")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //MARK: Trouver les projets
    func Projets() -> [Projet] {
        let fetchRequest: NSFetchRequest<Projet> = Projet.fetchRequest()
        
        let context = persistentContainer.viewContext
        do {
            return try context.fetch(fetchRequest)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //MARK: Trouver les comptes
    func Comptes() -> [CompteBancaire]{
        let fetchRequest: NSFetchRequest<CompteBancaire> = CompteBancaire.fetchRequest()
        
        let context = persistentContainer.viewContext
        do {
            return try context.fetch(fetchRequest)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //MARK: Trouver les conventions
    func Conventions() -> [Convention]{
        let fetchRequest: NSFetchRequest<Convention> = Convention.fetchRequest()
        
        let context = persistentContainer.viewContext
        do {
            return try context.fetch(fetchRequest)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //MARK: Trouver les dépenses
    func Depenses() -> [Depense]{
        let fetchRequest: NSFetchRequest<Depense> = Depense.fetchRequest()
        
        let context = persistentContainer.viewContext
        do {
            return try context.fetch(fetchRequest)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //MARK: Trouver les paiements
    func Paiements() -> [Paiement]{
        let fetchRequest: NSFetchRequest<Paiement> = Paiement.fetchRequest()
        
        let context = persistentContainer.viewContext
        do {
            return try context.fetch(fetchRequest)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //MARK: Ajouter dépense
    func initDepense(raison: String, montant: Double) -> Depense{
        let context = persistentContainer.viewContext
        let depense = Depense(context: context)
        depense.raison = raison
        depense.montant = montant
        
        do{
            try context.save()
        } catch {
            let error = error as NSError
            print("Addition did not work: \(error)", error.userInfo)
        }
        return depense
    }
    
    //MARK: Ajouter paiement
    func initPaiement(date: Date, mode: Mode, montant: Double) -> Paiement{
        let context = persistentContainer.viewContext
        let paiement = Paiement(context: context)
        paiement.date = date
        paiement.modeDePaiement = mode
        paiement.montant = montant
        
        do{
            try context.save()
        } catch {
            let error = error as NSError
            print("Addition did not work: \(error)", error.userInfo)
        }
        return paiement
    }
    
    //MARK: Ajouter dépense à un projet
    func addDepenseToProjet(depense: Depense, nomCompteBancaire: String, projet: Projet){
        let context = persistentContainer.viewContext
        let comptes = Comptes()
        
        for compte in comptes{
            if compte.nom == nomCompteBancaire{
                depense.compte = compte
                compte.depenses?.adding(depense)
                compte.retirerSomme(montant: depense.montant)
                break
            }
        }
        
        do{
            projet.depenses?.adding(depense)
            depense.projet = projet
            try context.save()
        } catch {
            let error = error as NSError
            print("Addition did not work: \(error)", error.userInfo)
        }
    }
    
    //MARK: Ajouter paiement à une convention
    func initPaiement(paiement: Paiement, compteBancaire: CompteBancaire, nomConvention: String){
        let context = persistentContainer.viewContext
        let depense = Depense(context: context)
        let conventions = Conventions()
        
        for convention in conventions{
            if convention.domaine == nomConvention{
                paiement.convention = convention
                convention.paiements?.adding(paiement)
                break
            }
        }
        
        do{
            paiement.compte = compteBancaire
            compteBancaire.paiements?.adding(paiement)
            compteBancaire.retirerSomme(montant: paiement.montant)
            try context.save()
        } catch {
            let error = error as NSError
            print("Addition did not work: \(error)", error.userInfo)
        }
    }
    
    //MARK: Delete depense
    func deleteDepense(montant: Double, raison: String){
        let context = persistentContainer.viewContext
        let depenses = Depenses()
        for depense in depenses {
            if depense.montant == montant && depense.raison == raison{
                context.delete(depense)
                break
            }
        }
        do{
            try context.save()
        } catch {
            let error = error as NSError
            print("Addition did not work: \(error)", error.userInfo)
        }
    }
    
    //MARK: Delete paiement
    func deletePaiement(date: Date, mode: Mode, montant: Double){
        let context = persistentContainer.viewContext
        let paiements = Paiements()
        for paiement in paiements {
            if paiement.date == date && paiement.modeDePaiement == mode && paiement.montant == montant{
                context.delete(paiement)
                break
            }
        }
        do{
            try context.save()
        } catch {
            let error = error as NSError
            print("Addition did not work: \(error)", error.userInfo)
        }
    }
}

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
        
        let container = NSPersistentContainer(name: "ProjetLivrable1")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func removeAllDatas(){
        let context = persistentContainer.viewContext
        
        let projets = Projets()
        for projet in projets {
            context.delete(projet)
        }
        
        let comptes = Comptes()
        for compte in comptes {
            context.delete(compte)
        }
        
        let conventions = Conventions()
        for convention in conventions {
            context.delete(convention)
        }
        
        let paiements = Paiements()
        for paiement in paiements {
            context.delete(paiement)
        }

        do {
            try context.save()
        } catch {
            let error = error as NSError
            print("Addition did not work: \(error)", error.userInfo)
        }
    }
    
    //MARK: Init function
    func initDatas(){
        let context = persistentContainer.viewContext
        
        let projet1 = Projet(context: context)
        projet1.nom = "Les Jardins Mercier"
        let projet2 = Projet(context: context)
        projet2.nom = "YUL Condominiums"
        
        let compte1 = CompteBancaire(context: context)
        compte1.nom = "BC1_RBC"
        compte1.somme = 15000
        let compte2 = CompteBancaire(context: context)
        compte2.nom = "BC2_BN"
        compte2.somme = 25000
        
        let convention1 = Convention(context: context)
        convention1.domaine = "Maçonnerie"
        let convention2 = Convention(context: context)
        convention2.domaine = "Plomberie"
        let convention3 = Convention(context: context)
        convention3.domaine = "Électricité"
        let convention4 = Convention(context: context)
        convention4.domaine = "Matériaux de construction"
        let convention5 = Convention(context: context)
        convention5.domaine = "Architecte"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        
        let paiement1 = Paiement(context: context)
        paiement1.datePaiement = formatter.date(from:"25/03/2023")
        paiement1.mode = "cash"
        paiement1.montant = 20000.00
        paiement1.compte = compte2
        paiement1.convention = convention5
        
        let paiement2 = Paiement(context: context)
        paiement2.dateDebut = formatter.date(from:"01/03/2023")
        paiement2.dateFin = formatter.date(from:"30/03/2023")
        paiement2.mode = "cheque"
        paiement2.montant = 2500.00
        paiement2.compte = compte1
        paiement2.convention = convention3
        
        let paiement3 = Paiement(context: context)
        paiement3.dateDebut = formatter.date(from:"01/04/2023")
        paiement3.dateFin = formatter.date(from:"30/04/2023")
        paiement3.mode = "cheque"
        paiement3.montant = 1775.00
        paiement3.compte = compte1
        paiement3.convention = convention3
        
        
        
        do{
            try context.save()
        } catch {
            let error = error as NSError
            print("Addition did not work: \(error)", error.userInfo)
        }
    }
    
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
    
    //MARK: Trouver les dépenses par projets
    func Depenses(projet: Projet) -> [Depense]{
        let fetchRequest: NSFetchRequest<Depense> = Depense.fetchRequest()
        let predicate = NSPredicate(format: "projet = %@", projet)
        fetchRequest.predicate = predicate
        
        let context = persistentContainer.viewContext
        do {
            return try context.fetch(fetchRequest)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //MARK: get all Payments
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
    
    //MARK: Trouver les paiements par compte bancaire
    func PaiementsByBank(compte: CompteBancaire) -> [Paiement]{
        let fetchRequest: NSFetchRequest<Paiement> = Paiement.fetchRequest()
        let predicate = NSPredicate(format: "compte = %@", compte)
        fetchRequest.predicate = predicate
        
        let context = persistentContainer.viewContext
        do {
            return try context.fetch(fetchRequest)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //MARK: Ajouter convention
    func intiConvention(domaine: String, fournisseur: String) -> Convention{
        let context = persistentContainer.viewContext
        let convention = Convention(context: context)
        convention.domaine = domaine
        convention.fournisseur = fournisseur
        
        do{
            try context.save()
        } catch {
            let error = error as NSError
            print("Addition did not work: \(error)", error.userInfo)
        }
        return convention
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
    func initPaiement(dateDebut: Date, dateFin: Date, datePaiement: Date, mode: Mode, montant: Double) -> Paiement{
        let context = persistentContainer.viewContext
        let paiement = Paiement(context: context)
        paiement.dateDebut = dateDebut
        paiement.dateFin = dateFin
        paiement.datePaiement = datePaiement
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
    
    //MARK: Ajouter paiement à un compte bancaire
    func addPaiementToCompte(paiement: Paiement, compteBancaire: CompteBancaire, nomConvention: String){
        let context = persistentContainer.viewContext
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
    
    //MARK: Remove depense
    func deleteDepense(raison: String, montant: Double, projet: Projet){
        let context = persistentContainer.viewContext
        let depenses = Depenses(projet: projet)
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
    
    //MARK: Remove paiement
    func deletePaiement(date: Date, mode: Mode, montant: Double, compte: CompteBancaire){
        let context = persistentContainer.viewContext
        let paiements = PaiementsByBank(compte: compte)
        for paiement in paiements {
            if paiement.datePaiement == date && paiement.modeDePaiement == mode && paiement.montant == montant{
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

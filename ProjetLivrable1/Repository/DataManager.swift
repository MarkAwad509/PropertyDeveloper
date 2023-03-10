//
//  DataManager.swift
//  ProjetLivrable1
//
//  Created by Maxim Proulx on 2023-03-08.
//

import Foundation
import CoreData

class DataManager{
    static let shared = DataManager()
    
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
    func projets() -> [Projet] {
        let fetchRequest: NSFetchRequest<Projet> = Projet.fetchRequest()
        
        let context = persistentContainer.viewContext
        do {
            return try context.fetch(fetchRequest)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //MARK: Trouver les conventions
    func findConventions() -> [Convention]{
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
    func findDepenses() -> [Depense]{
        let fetchRequest: NSFetchRequest<Depense> = Depense.fetchRequest()
        
        let context = persistentContainer.viewContext
        do {
            return try context.fetch(fetchRequest)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //MARK: Trouver les depenses
    func findPayements() -> [Paiement]{
        let fetchRequest: NSFetchRequest<Paiement> = Paiement.fetchRequest()
        
        let context = persistentContainer.viewContext
        do {
            return try context.fetch(fetchRequest)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //MARK: Initializer dépense à un projet
    func initAddresses(){
        let context = persistentContainer.viewContext
        let depense = Depense(context: context)
        
        let projets = projets()
        
        projets.forEach { projet in
            projet.depense = depense
        }
        
        do{
            try context.save()
        } catch {
            let error = error as NSError
            print("Addition did not work: \(error)", error.userInfo)
        }
    }
}

//
//  ManageCoreData.swift
//  CoreDataEx
//
//  Created by William Biondi on 13/05/2019.
//  Copyright © 2019 William Biondi. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ManagerCoreData{
    static let shared = ManagerCoreData()
    var appDelegate : AppDelegate
    var managedObjectContext : NSManagedObjectContext
    private init(){
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
    }
    
    func addUser(name: String, surname: String, date: String?, phone: String?){
        let entityUser = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext)
        let user = User(entity:entityUser!, insertInto: managedObjectContext)
        user.name = name
        user.surname = surname
        user.datebirth = date
        user.phone = phone
        save()
    }
    
    func save(){
        appDelegate.saveContext()
    }
    
    func fetchUserBySurname(surname:String) -> User?{
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "surname=%@", surname)
        do{
           let result = try managedObjectContext.fetch(fetchRequest)
            if !result.isEmpty{
                return result[0]
            }
            else{
                return nil
            }
        }catch let error{
                print(error)
                return nil
            }
        }
    
    func fetchCount() -> [User]?{
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = nil
        do{
            let results = try managedObjectContext.fetch(fetchRequest)
            return results
        }catch let error{
            print(error)
            return nil
        }
    }
    
}


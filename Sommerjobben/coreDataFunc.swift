//
//  coreDataFunc.swift
//  Sommerjobben
//
//  Created by Joakim Nereng Ellestad on 22.12.2015.
//  Copyright © 2015 Joakim Nereng Ellestad. All rights reserved.
//

import Foundation
import UIKit
import CoreData


//retrieve values from Core Data


func retrieveValues( let entityName: String) -> [NSManagedObject]{
    var objects = [NSManagedObject]()
    //1
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    let managedContext = appDelegate.managedObjectContext
    
    //2
    let fetchRequest = NSFetchRequest(entityName: "\(entityName)")
    
    //3
    
    do{
        let result = try managedContext?.executeFetchRequest(fetchRequest)
        objects = result as! [NSManagedObject]
    }catch let error as NSError
    {
        print("Kunne ikke hente data: \(error)")
    }
    return objects
}

func retrieveValuesSpecific( let entityName: String, let transfer: String) -> [NSManagedObject]{
    var objects = [NSManagedObject]()
    //1
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    let managedContext = appDelegate.managedObjectContext
    
    //2
    let fetchRequest = NSFetchRequest(entityName: "\(entityName)")
    
    let compound = NSCompoundPredicate(format: "jobbTittel = %@", transfer)
    fetchRequest.predicate = compound
    
    //3
    
    do{
        let result = try managedContext?.executeFetchRequest(fetchRequest)
        objects = result as! [NSManagedObject]
    }catch let error as NSError
    {
        print("Kunne ikke hente data: \(error)")
    }
    
    return objects
}

func deleteRowAtJob(let transfer: String, let time: NSDate) -> Bool {
    var objects = [NSManagedObject]()
    //1
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    let managedContext = appDelegate.managedObjectContext
    
    //2
    let fetchRequest = NSFetchRequest(entityName: "JobbTime")
    
    let compound = NSCompoundPredicate(format: "jobTitle = %@ AND dato = %@", transfer, time)
    fetchRequest.predicate = compound
    
    do{
        let result = try managedContext?.executeFetchRequest(fetchRequest)
        objects = result as! [NSManagedObject]
        print("\(objects)")
    }catch let error as NSError{
        print("Something went wrong: \(error)")
    }

    if objects.count == 1 {
        print("Should be safe to delete row")
        managedContext?.deleteObject(objects[0])
        do {
            try managedContext?.save()
        
        }catch let error as NSError{
            print("Kunne ikke slette \(error)")
        }
        return true
    }else{
        print("Found several rows...")
        return false
    }
    
    
   
    
}





//Save values to core data

//Not critical
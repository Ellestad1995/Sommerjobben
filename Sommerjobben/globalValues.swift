//
//  globalValues.swift
//  Sommerjobben
//
//  Created by Joakim Nereng Ellestad on 18.12.2015.
//  Copyright © 2015 Joakim Nereng Ellestad. All rights reserved.
//

import Foundation
import UIKit
import CoreData
var transferId: Int?
var transferTitle: String = ""
var sharetext:String = ""
var STTitle = ""
var STMoney = 0
var STHours = ""



//NSDate


//todays date to nice format
func currentDateAsString() ->String{
    let date = NSDate()
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
    let theDate = dateFormatter.stringFromDate(date)
    
return "\(theDate)"
}

func currentDateAsNSDate() -> NSDate{
    let date = NSDate()
    
    return date
}

func formatDateMedium(date: NSDate) -> String{
    let dateValue = date
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
    let theDate = dateFormatter.stringFromDate(dateValue)
    
    return "\(theDate)"
}

//remove text from strings and keep decimals

func extractDecimalFromString(string: String) -> Double{
    let origString = string
    let stringArray = origString.componentsSeparatedByCharactersInSet(
        NSCharacterSet.decimalDigitCharacterSet().invertedSet)
    let newString = NSArray(array: stringArray).componentsJoinedByString("")
    return Double(newString)!
}

    
    func tableData() -> [NSManagedObject]
    {
        var objects = [NSManagedObject]()
        //1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
       let fetchRequest = NSFetchRequest(entityName: "JobbTime")
        
        fetchRequest.returnsObjectsAsFaults = false
        let jobTitle = transferTitle
        //let predicate = NSPredicate(format: "jobTitle = %i", jobTitle!)
        
        let compound = NSCompoundPredicate(format: "jobTitle = %@", jobTitle)
        fetchRequest.predicate = compound
        
        do{
            let result = try managedContext?.executeFetchRequest(fetchRequest)
            objects = result as! [NSManagedObject]
            print("\(objects)")
        
        }catch let error as NSError{
            print("Something went wrong: \(error)")
        }
        return objects
}
func minToString(minutes: Double) -> String{
    let time: Double = minutes
    
    let floorV = time/60
    let hour = floor((time/60))
    let min = floorV - hour
    
    var returnString = ""
    if min != 0{
        returnString = "\(Int(hour))t 30 min"
        print("\(hour)t 30 min")
    }else{
        returnString = "\(Int(hour))t"
        print("\(hour)t")
    }
    return returnString
}


/*

class stats {
    
    var progressValue:Double = 0
    var totalEarnings: Double = 0 //Done
    var moneyGoal: Double = 5000
    var totalHours:NSDate? //Done
    var bestEarning: Double = 0 //wait
    var bestTime: Double = 0    //wait
    var bestDat: NSDate?        //wait
    var objects = [NSManagedObject]()
    
    
    
    func getInfo()
    {
        objects = tableData()
        var timeInterval = NSTimeInterval()
        
        //calculate
        if !objects.isEmpty
        {
            for var index = 0; index < objects.count; ++index
            {
                totalEarnings += objects[index].valueForKey("tjent") as! Double
                
                let time =  objects[index].valueForKey("nsdataTimer") as! NSDate
                timeInterval = time.timeIntervalSinceReferenceDate
                totalHours?.dateByAddingTimeInterval(timeInterval)
            }
        }
    }
    
    
    func setMoneyGoal(goal:Double){
        moneyGoal = goal
    }
    
    
    func saveValue(moneyGoal: Double,){
        print("Values are being stored!")
        //1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity = NSEntityDescription.entityForName("Jobb", inManagedObjectContext: managedContext!)
        let jobb = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        //3

        //4
        
        do{
            try managedContext?.save()
        }catch let error as NSError{
            print("Fungerte ikke: \(error)")
        }
    }

    
    
    
}


*/



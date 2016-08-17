//
//  ViewController03.swift
//  
//
//  Created by Joakim Nereng Ellestad on 07.11.2015.
//
//

import UIKit
import CoreData

class ViewController03: UIViewController {
    
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var progressEarnings: UIProgressView!
    
    @IBOutlet weak var goalTextField: UITextField!
    
    @IBOutlet weak var labelEarnings: UILabel!
    
    @IBOutlet weak var labelTotalMoney: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var labelHours: UILabel!
    
    
    @IBOutlet weak var viewShare: UIView!
    
    @IBOutlet weak var labelBottom: UILabel!
    
    @IBOutlet weak var labelBestEarning: UILabel!
    
    @IBOutlet weak var labelBestHours: UILabel!
    
    @IBOutlet weak var labelBestDate: UILabel!
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var changeGoalButton: UIButton!
    
    @IBAction func goalChange(sender: AnyObject) {
        
        var changeValue: Int = 0
        if let changeValueTest = Int(goalTextField.text!){
            changeValue = changeValueTest
        }else{
            changeValue = 10000
        }
        
        //let changeValue: Int = Int(goalTextField.text!)!
        moneyGoal = Double(changeValue)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        //let entity = NSEntityDescription.entityForName("Jobb", inManagedObjectContext: managedContext!)
        
        let fetchRequest = NSFetchRequest(entityName: "Jobb")
        
        fetchRequest.predicate = NSPredicate(format: "jobbTittel = %@", transferTitle)
        
        var fetchResult: [NSManagedObject]?
        do{
           fetchResult = try appDelegate.managedObjectContext!.executeFetchRequest(fetchRequest) as? [NSManagedObject]
        }catch let error as NSError{
            print("\(error)")
        }

        if fetchResult?.count != 0{
            let managedObject = fetchResult![0]
            managedObject.setValue(changeValue, forKey: "moneyGoal")
            
            do{
                try managedContext?.save()
                print("Oppdaterer!")
            
            }catch let error as NSError{print("\(error)")}
            
        }
        viewDidLoad()
        self.view.endEditing(true)
    }
    
    
    var jobbObjects = [NSManagedObject]()
    var jobbTimeObjects = [NSManagedObject]()
    
    
    var moneyGoal: Double = 10000
    var totalMoney: Double = 0
    var moneyGoalPercent: Double = 0
    var totalHours: Double = 0
    //----Best day
    var bestTjent: Double = 0
    var bestMin: Double = 0
    var bestDate: NSDate = NSDate(timeIntervalSinceReferenceDate: 0)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController03.updateView(_:)), name: "updateView", object: nil)
        
        jobbObjects = retrieveValuesSpecific("Jobb", transfer: transferTitle)
        
        
        //-----labelHours....totalHours
        
        labelHours.layer.cornerRadius = CGFloat(labelHours.layer.frame.size.width/2)
        labelHours.layer.masksToBounds = true
        labelHours.layer.borderWidth = 3
        labelHours.layer.borderColor = UIColor(red: 255, green: 102, blue: 103, alpha: 1).CGColor
        labelTotalMoney.layer.cornerRadius = CGFloat(labelTotalMoney.layer.frame.size.width/2)
        labelTotalMoney.layer.masksToBounds = true
        labelTotalMoney.layer.borderWidth = 3
        labelTotalMoney.layer.borderColor = UIColor(red: 255, green: 102, blue: 103, alpha: 1).CGColor
        
        
        jobbTimeObjects = tableData()
        if jobbTimeObjects.isEmpty{
            //Shit is Empty
            print("JobbTime er tom, ting klikker")
            progressEarnings.progress = Float(0)
            shareButton.enabled = false
            
        }else{
            
            //MoneyGoal
            moneyGoal = jobbObjects[0].valueForKey("moneyGoal") as! Double
            totalStuff()
            goalTextField.text = String(moneyGoal)
            progressEarnings.progress = Float(moneyGoalPercent)
            
            labelHours.text = minToString(totalHours)
            labelTotalMoney.text = "\(Int(totalMoney)) kr"
            
            //-----Your best day
            bestDay()
            labelBestEarning.text = "\(String(bestTjent)) kr"
            labelBestHours.text = minToString(bestMin)
            labelBestDate.text = formatDateMedium(bestDate)
        
        }
        

        // Do any additional setup after loading the view.
    }
    
    func updateView(sender: NSNotification){
        viewDidLoad()
    }
    
    func totalStuff(){
        //Calculate total earnings
        totalMoney = 0
        totalHours = 0
        print("totalStuff funksjon!")
        for index in 0 ..< jobbTimeObjects.count{
            let data = jobbTimeObjects[index]
            //-----total money
            let tjent = data.valueForKey("tjent") as! Double
            let time = data.valueForKey("minutter") as! Double
            let tjentPrMin = (tjent/60)
            totalMoney += tjentPrMin*time
            //------total Hours
            totalHours += (data.valueForKey("minutter") as! Double)
        }
        print("Verdier: \(totalMoney) + \(moneyGoal) + \(totalHours)")
        //---------moneygoal percent
        moneyGoalPercent = (totalMoney / moneyGoal)
    }
    
    func bestDay(){
        //Sort by "tjent"
        var tempJobbTimeObjects = jobbTimeObjects
        
        /*
        tableObjects.sortInPlace({($0.valueForKey("dato") as! NSDate).compare($1.valueForKey("dato") as! NSDate) == NSComparisonResult.OrderedAscending})
        */
        
        tempJobbTimeObjects.sortInPlace({(($0.valueForKey("tjent") as! Double) * ($0.valueForKey("minutter") as! Double))  > (($1.valueForKey("tjent") as! Double) * ($1.valueForKey("minutter") as! Double))})
        let data = tempJobbTimeObjects[0]
        bestTjent = (((data.valueForKey("tjent") as! Double / 60)) * (data.valueForKey("minutter") as! Double))
        bestMin = data.valueForKey("minutter") as! Double
        bestDate = data.valueForKey("dato") as! NSDate
        
    
    }

    
    
    
    @IBAction func shareButton(sender: AnyObject) {
        sharetext = "Jeg har tjent \(totalMoney) kr og jobbet \(minToString(totalHours)) som \(transferTitle)!"
        STMoney = Int(totalMoney)
        STHours = minToString(totalHours)
        STTitle = transferTitle
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("shareView")
        self.presentViewController(vc, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

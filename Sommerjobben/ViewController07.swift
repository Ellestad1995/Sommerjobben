//
//  ViewController07.swift
//  Sommerjobben
//
//  Created by Joakim Nereng Ellestad on 18.12.2015.
//  Copyright © 2015 Joakim Nereng Ellestad. All rights reserved.
//

import UIKit
import CoreData

class ViewController07: UIViewController {
    
    
    @IBOutlet weak var jobbTittel: UITextField!
    
    @IBOutlet weak var lonnOutlet: UITextField!
    
    @IBOutlet weak var arbeidstimerOutlet: UITextField!
    
    @IBOutlet var theView: UIView!
    
    var time: Double?
    
    @IBAction func closeModalView(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    var verdier: [Int] = [0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330, 360, 390, 420, 450, 480, 510, 540, 570, 600, 630, 660, 690, 720]
    @IBOutlet weak var stepperOutlet: UIStepper!
    
    @IBAction func timeStepper(sender: AnyObject) {
        time = Double(verdier[Int(stepperOutlet.value)])
        print("\(time!)")
        arbeidstimerOutlet.text = minToString(Double(verdier[Int(stepperOutlet.value)]))
    }
    
    
    
    
    
    
    
    @IBAction func leggTilAction(sender: AnyObject) {
        //Create values to send to func saveValues
        let lonnV = Double(lonnOutlet.text!)
        let arbeidT = time
        if let tittel = jobbTittel.text, lonn = lonnV, arbeidstimer = arbeidT {
            
                saveValues(tittel, lonn: lonn, arbeidstimer: arbeidstimer)
            }
        else
        {
            
            if #available(iOS 8.0, *) {
                let alert = UIAlertController(title: "Mangler info", message: "Fyll inn manglende felt", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                // Fallback on earlier versions
                print("Make a fallback here!!")
                
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("reloadTableData", object: nil)
    }
    
    //var jobb = NSManagedObject()
    
    
    
    
    func saveValues(tittel: String, lonn: Double, arbeidstimer: Double){
        print("Values are being stored!")
        //1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity = NSEntityDescription.entityForName("Jobb", inManagedObjectContext: managedContext!)
        let jobb = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        //3
        jobb.setValue(tittel, forKey: "jobbTittel")
        jobb.setValue(lonn, forKey: "lonn")
        jobb.setValue(arbeidstimer, forKey: "antallTimer")
        jobb.setValue(10000, forKey: "moneyGoal")
        //4
        
        do{
            try managedContext?.save()
        }catch let error as NSError{
            print("Fungerte ikke: \(error)")
        }
    }
    
    
    func tapGestureFunc(sender: UITapGestureRecognizer? = nil){
        print("I did it!")
        self.view.endEditing(true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        time = 540
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController07.tapGestureFunc(_:)))
        theView.addGestureRecognizer(tapGesture)
        theView.userInteractionEnabled = true
        //tapGesture.delegate = self
        
        stepperOutlet.wraps = true
        stepperOutlet.autorepeat = true
        stepperOutlet.maximumValue = 25
        stepperOutlet.minimumValue = 0
        stepperOutlet.value = 18
        
        arbeidstimerOutlet.text = minToString(time!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

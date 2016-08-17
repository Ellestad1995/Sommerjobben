//
//  ViewController06.swift
//  
//
//  Created by Joakim Nereng Ellestad on 07.11.2015.
//
//

import UIKit
import CoreData

class ViewController06: UIViewController {
    
    
    @IBOutlet weak var dateOutlet: UITextField!
    
    @IBOutlet weak var lonnOutlet: UITextField!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var verdier: [Int] = [0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330, 360, 390, 420, 450, 480, 510, 540, 570, 600, 630, 660, 690, 720]
    
    var time:Double = 0
    var dateValue: NSDate!
    @IBOutlet weak var stepperOutlet: UIStepper!
    
    @IBAction func stepperFunc(sender: AnyObject) {
        time = Double(verdier[Int(stepperOutlet.value)])
        timeLabel.text = minToString(Double(verdier[Int(stepperOutlet.value)]))
        
    }
    
    
    
    
    @IBAction func leggTilButton(sender: AnyObject)
    {
        activityIndicator.hidden = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        let date = dateValue
        let lonn: Double = extractDecimalFromString(lonnOutlet.text!)
        let tid:Double = time
        let titleValue = transferTitle
        //Store these values in core data
        savevalues(date,lonnValue: lonn, tidvalue: tid, titleName: titleValue)
        self.view.endEditing(true)
        let delay = 3 * Double(NSEC_PER_SEC)
        let timeDispatch = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(timeDispatch, dispatch_get_main_queue()) { () -> Void in
            self.activityIndicator.stopAnimating()
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("reloadView", object: nil)
    }
    
    func savevalues(datevalue: NSDate, lonnValue: Double, tidvalue: Double, titleName: String)
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity = NSEntityDescription.entityForName("JobbTime", inManagedObjectContext: managedContext!)
        let jobb = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        //3
        jobb.setValue(datevalue, forKey: "dato")
        jobb.setValue(lonnValue, forKey: "tjent")
        jobb.setValue(tidvalue, forKey: "minutter")
        jobb.setValue(titleName, forKey: "jobTitle")
        
        //4
        
        do{
            try managedContext?.save()
            print("Success!!")
        }catch let error as NSError{
            print("Fungerte ikke: \(error)")
        }

    }
    
    
    @IBAction func datePicker(sender: UITextField)
    {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(ViewController06.datePickerValueChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker)
    {
        let date = sender.date
        dateValue = date
        dateOutlet.text = formatDateMedium(date)
    }
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        activityIndicator.hidden = true
        //Get the current date and place it to date-outlet
        //Get core data stored value for sallary
        //Get ussual workhoures. if change. Change mode on datepicker to time
        
        //Retrieve lonn and antallTimer
        let objects = retrieveValues("Jobb")
        let date = currentDateAsString()
        dateOutlet.text = "\(date)"
        dateValue = currentDateAsNSDate()
        let lonn: String = String(objects[transferId!].valueForKey("lonn")!)
        lonnOutlet.text = "\(lonn) kr"
        
        time = (objects[transferId!].valueForKey("antallTimer")! as? Double)!
        timeLabel.text = minToString(time)
        
        stepperOutlet.maximumValue = 24
        stepperOutlet.minimumValue = 0
        stepperOutlet.autorepeat = true
        stepperOutlet.wraps = true
        let stepperValue = verdier.indexOf(Int(time))
        stepperOutlet.value = Double(stepperValue!)

        
        
        let viewTouch = UITapGestureRecognizer(target: self, action: #selector(ViewController06.touchView(_:)))
        self.view.addGestureRecognizer(viewTouch)
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func touchView(sender: UITapGestureRecognizer){
    self.view.endEditing(true)
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

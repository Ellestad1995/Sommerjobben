//
//  ViewController.swift
//  Sommerjobben
//
//  Created by Joakim Nereng Ellestad on 07.11.2015.
//  Copyright (c) 2015 Joakim Nereng Ellestad. All rights reserved.
//

import UIKit
import CoreData



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    //Scroll Images
    
    @IBOutlet weak var scrollViewImage: UIScrollView!
    
    
    
    
    
    
    

    
    
    var objects: [NSManagedObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.refreshTableData(_:)), name: "reloadTableData", object: nil)

        
        
        
        //createscrollView()
        
        
        
        //self.scrollView.frame.size = CGSizeMake(self.view.frame.size.width, 170)
        let scrollViewHeight = self.scrollViewImage.frame.size.height
        let scrollViewWidth = self.scrollViewImage.frame.size.width//self.scrollView.frame.width
        
        
        //Array of images
        var imageArray = [UIImageView]()
        for _ in 0 ..< 21
        {
            imageArray.append(UIImageView())
        }
        
        
        let imageFrame = UIImageView()
        
        imageFrame.frame.size = CGSizeMake(scrollViewWidth, scrollViewHeight)
        imageFrame.frame.origin.x = CGFloat(0)
        imageFrame.frame.origin.y = CGFloat(0)
        
        
        //Put images in frames
        
        var originLength:CGFloat = 0
        for index in 0 ..< imageArray.count{
            
            //image
            let theImage = UIImage(named: "facts\(index).png")
            let image = imageArray[index]
            image.frame = imageFrame.frame
            image.contentMode = .ScaleAspectFit
            imageFrame.backgroundColor = UIColor.blackColor()
            image.image = theImage
            image.frame.origin.x = originLength
            self.scrollViewImage.addSubview(image)
            originLength += scrollViewWidth
        }
        self.scrollViewImage.contentSize = CGSizeMake(scrollViewWidth*CGFloat(imageArray.count), self.scrollViewImage.frame.size.height)
        
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func refreshTableData(sender: NSNotification){
        tableView.reloadData()
        print("refresh data")
    }
    
    //MARK: - UITableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        objects = retrieveValues("Jobb")
        return objects!.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        
        //cell.labelJobName.text = self.objects.objectAtIndex(indexPath.row) as? String
        
        //cell.labelJobID.text = String(indexPath.row)
        
        let jobName = objects![indexPath.row]
        cell.labelJobName.text = jobName.valueForKey("jobbTittel") as? String
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("segue02", sender: self)
        print("Perform segue")
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            print("Jobber her: \(objects!)")
            managedContext?.deleteObject(objects![indexPath.row] as NSManagedObject)
            
            
            let data = objects![indexPath.row] as NSManagedObject
            let jobName = data.valueForKey("jobbTittel") as! String
            
            let fetchRequest = NSFetchRequest(entityName: "JobbTime")
            let compound = NSCompoundPredicate(format: "jobTitle = %@", jobName)
            fetchRequest.predicate = compound
 
            
            var toDelete = [NSManagedObject]()
            do{
                let result = try managedContext?.executeFetchRequest(fetchRequest)
                toDelete = result as! [NSManagedObject]
                print("to Delete: ---> \(toDelete)")
            }catch let error as NSError{
                print("Something went wrong: \(error)")
            }
            
            if !toDelete.isEmpty {
                print("Should be safe to delete row")
                for i in 0 ..< toDelete.count {
                    print("Sletter: \(i)")
                    managedContext?.deleteObject(toDelete[i])
                }
                do {
                    print("Kommer til å slette: \(managedContext?.deletedObjects)")
                    try managedContext?.save()
                    objects!.removeAtIndex(indexPath.row)
                    self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                }catch let error as NSError{
                    print("Kunne ikke slette \(error)")
                }
            }else{
                print("No rows detected, will delete other stuff though")
                
                do{
                    try managedContext?.save()
                    objects!.removeAtIndex(indexPath.row)
                    self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                }catch let error as NSError{
                    print("SHit...: \(error)")
                
                }
            }
            
           
        }
 
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "segue02")
        
        {
            let upcoming: ViewController02 = segue.destinationViewController as! ViewController02
            
            let indexPath = self.tableView.indexPathForSelectedRow!
            
            let titleString = objects![indexPath.row]
            upcoming.labelJobNameTop = titleString.valueForKey("jobbTittel") as? UILabel
            upcoming.title = titleString.valueForKey("jobbTittel") as? String
            transferId = indexPath.row
            transferTitle = (titleString.valueForKey("jobbTittel") as? String)!
            print("\(transferTitle)")
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        }
    }
    
    
    
    
    
    @IBAction func openSafari(sender: AnyObject) {
        let url = NSURL(string: "http://www.arbeidstilsynet.no/fakta.html?tid=78110")
        UIApplication.sharedApplication().openURL(url!)
    }
    


}


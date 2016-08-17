//
//  ViewControllerTable.swift
//  Sommerjobben
//
//  Created by Joakim Nereng Ellestad on 10.01.2016.
//  Copyright © 2016 Joakim Nereng Ellestad. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerTable: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
        @IBOutlet var uiViewTable: UIView!
        var refreshControll: UIRefreshControl!
    
    
        @IBOutlet weak var tableView2: UITableView!
        var tableObjects = tableData()
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            tableObjects.sortInPlace({($0.valueForKey("dato") as! NSDate).compare($1.valueForKey("dato") as! NSDate) == NSComparisonResult.OrderedDescending})
        tableView2.reloadData()
            
        self.refreshControll = UIRefreshControl()
        self.refreshControll.attributedTitle = NSAttributedString(string: "Oppdater")
        self.refreshControll.addTarget(self, action: #selector(ViewControllerTable.refresh), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView2.addSubview(refreshControll)
            
            
            
            
            
            
            
            
            
            
    }
    func refresh(){
        self.tableView2.reloadData()
        tableObjects = tableData()
        tableObjects.sortInPlace({($0.valueForKey("dato") as! NSDate).compare($1.valueForKey("dato") as! NSDate) == NSComparisonResult.OrderedDescending})
        self.refreshControll.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableObjects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell2 = self.tableView2.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath) as! TableViewCell2
        
        let data = tableObjects[indexPath.row]
        
        let date = data.valueForKey("dato")!
        let time = data.valueForKey("minutter")! as? Double
        let tjent = data.valueForKey("tjent")! as? Double
        let dateTime = formatDateMedium(date as! NSDate)
        
        let tjentSum = ((tjent!/60) * time!)
        print(tjentSum)
        
        cell2.dateLabel.text = dateTime
        cell2.timeLabel.text = minToString(time!)
        cell2.earnedLabel.text = "\(String(tjentSum)) kr"
        
        return cell2
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            print("Will delete this row \(indexPath.row)")
            let rowTime = tableObjects[indexPath.row].valueForKey("dato")! as? NSDate
            print(rowTime)
            if deleteRowAtJob(transferTitle, time: rowTime!) {
                tableObjects.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }else{
                print("Nope...kunne ikke slette")
            }
            
        }
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

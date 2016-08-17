//
//  ViewController04.swift
//  
//
//  Created by Joakim Nereng Ellestad on 07.11.2015.
//
//

import UIKit
import CoreData

class ViewController04: UIViewController {
    
    //@IBOutlet weak var uiViewTable: UIView!
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableData()
        print("It loaded")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vcName = "uiViewtable"
        
        let vc = storyboard.instantiateViewControllerWithIdentifier("\(vcName)") as UIViewController
      
        let subView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width , height: self.view.frame.size.height))
        
        subView.addSubview(vc.view)
        
        self.view.addSubview(subView)
        self.addChildViewController(vc)
        
        vc.didMoveToParentViewController(self)
        
        self.view.bringSubviewToFront(subView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

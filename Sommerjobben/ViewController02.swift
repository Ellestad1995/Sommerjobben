//
//  ViewController02.swift
//  
//
//  Created by Joakim Nereng Ellestad on 07.11.2015.
//
//

import UIKit

class ViewController02: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var labelJobNameTop: UILabel!

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate  = self
        //Creating views used in the swipe container view
        
        let vc01: ViewController04 = ViewController04(nibName: "ViewController04", bundle: nil)  //ViewController04
        let vc02: ViewController06 = ViewController06(nibName: "ViewController06", bundle: nil) //ViewController06
        let vc03: ViewController03 = ViewController03(nibName: "ViewController03", bundle: nil)//ViewController03
        
        //Add each view to the container view hierarchy. View Hierarchy is a stack so put them in opposite order.
        
        
        
        // -3
        self.addChildViewController(vc03)
        var frame3 = vc03.view.frame
        frame3.origin.x = self.view.frame.size.width * 2
        vc03.view.frame = frame3
        
        self.scrollView.addSubview(vc03.view)
        vc03.didMoveToParentViewController(self)
        //-3
        //-2
        self.addChildViewController(vc02)
        var frame2 = vc02.view.frame
        frame2.origin.x = self.view.frame.size.width
        vc02.view.frame = frame2
        
        self.scrollView.addSubview(vc02.view)
        vc02.didMoveToParentViewController(self)
        //-2
        //-1
        self.addChildViewController(vc01)
        let frame1 = vc01.view.frame
        vc01.view.frame = frame1
        
        self.scrollView.addSubview(vc01.view)
        vc01.didMoveToParentViewController(self)
        //-1
        //Setting up the frames of the view controllers to align
        
        
        
        
        
        //Set the size of the scrollview
        let scrollWidth: CGFloat = 3 * self.view.frame.size.width
        let scrollheight: CGFloat = self.view.frame.size.height - 66
        self.scrollView.contentSize = CGSizeMake(scrollWidth, scrollheight)
        
        
        
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

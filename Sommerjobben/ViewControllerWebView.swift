//
//  ViewControllerWebView.swift
//  Sommerjobben
//
//  Created by Joakim Nereng Ellestad on 06.02.2016.
//  Copyright © 2016 Joakim Nereng Ellestad. All rights reserved.
//

import UIKit

class ViewControllerWebView: UIViewController {
    
    
    @IBOutlet weak var webView: UIWebView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL(string: "http://www.arbeidstilsynet.no/fakta.html?tid=78110")
        let reqUrl = NSURLRequest(URL: url!)
        webView.loadRequest(reqUrl)
        
        // Do any additional setup after loading the view.
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

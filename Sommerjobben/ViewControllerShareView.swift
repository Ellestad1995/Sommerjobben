//
//  ViewControllerShareView.swift
//  Sommerjobben
//
//  Created by Joakim Nereng Ellestad on 07.02.2016.
//  Copyright © 2016 Joakim Nereng Ellestad. All rights reserved.
//

import UIKit

class ViewControllerShareView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var bottomLabel: UILabel!
    
    @IBOutlet weak var bottomLabelSecond: UILabel!
    
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var addPhoto: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

        bottomLabel.layer.cornerRadius = (bottomLabel.frame.width/2)
        bottomLabelSecond.layer.cornerRadius = (bottomLabelSecond.frame.width/2)
        
        bottomLabel.clipsToBounds = true
        bottomLabelSecond.clipsToBounds = true
        
        topLabel.text = STTitle
        bottomLabel.text = "\(STMoney) kr"
        bottomLabelSecond.text = "\(STHours)"
        
        
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewControllerShareView.handleBottomLabel(_:)))
        let secondGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewControllerShareView.handleBottomLabelSecond(_:)))
        
        self.bottomLabel.addGestureRecognizer(gestureRecognizer)
        self.bottomLabelSecond.addGestureRecognizer(secondGestureRecognizer)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addphoto(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
       @IBAction func shareButton(sender: AnyObject) {
        //Hide elements
        closeButton.hidden = true
        shareButton.hidden = true
        addPhoto.hidden = true
        
        //First create snapshot of the view
        UIGraphicsBeginImageContextWithOptions(CGSize(width: self.view.frame.width, height: self.view.frame.height), view.opaque, 0.0)
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        closeButton.hidden = false
        shareButton.hidden = false
        addPhoto.hidden = false
        
        
        let firstActivityItem = "Penger vokser ikke på trær!"
        let imageValue: UIImage = image
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [firstActivityItem, imageValue], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [
            UIActivityTypePostToWeibo,
            UIActivityTypeAssignToContact,
            UIActivityTypeAddToReadingList,
            UIActivityTypePostToFlickr,
            UIActivityTypePostToVimeo,
            UIActivityTypePostToTencentWeibo
        ]
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
        
        
    }
    
    
    
    func handleBottomLabel(sender: UIPanGestureRecognizer)
    {
        if sender.state == UIGestureRecognizerState.Began || sender.state == UIGestureRecognizerState.Changed
        {
            let translation = sender.translationInView(self.view)
            
            sender.view!.center = CGPointMake(sender.view!.center.x + translation.x, sender.view!.center.y + translation.y)
            sender.setTranslation(CGPointMake(0,0), inView: self.view)
            
        }
    }

    func handleBottomLabelSecond(sender: UIPanGestureRecognizer)
    {
        if sender.state == UIGestureRecognizerState.Began || sender.state == UIGestureRecognizerState.Changed
        {
            let translation = sender.translationInView(self.view)
            
            sender.view!.center = CGPointMake(sender.view!.center.x + translation.x, sender.view!.center.y + translation.y)
            sender.setTranslation(CGPointMake(0,0), inView: self.view)
            
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

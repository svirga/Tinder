//
//  CardsViewController.swift
//  Tinder
//
//  Created by Simona Virga on 3/6/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController
{

    @IBOutlet weak var profileImageView: UIImageView!
    
    var cardInitialCenter: CGPoint!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        
        self.profileImageView.layer.cornerRadius = 10
        self.profileImageView.clipsToBounds = true
        
        
        self.profileImageView.layer.borderWidth = 5.0
        self.profileImageView.layer.borderColor = UIColor(red: 250, green: 110, blue: 130, alpha: 1.0).cgColor
        
        
        // Here we use the method didPan(sender:), which we defined in the previous step, as the action.
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(panGestureRecognizer)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func didPan(_ sender: UIPanGestureRecognizer)
    {
        let location = sender.location(in: view)
        //let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            cardInitialCenter = profileImageView.center
            print("Gesture began")
        } else if sender.state == .changed {
            if (location.y < profileImageView.frame.height/2)
            { profileImageView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
                profileImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double(translation.x) * M_PI / 560))
            }
            else {
                profileImageView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
                profileImageView.transform = CGAffineTransform(rotationAngle: CGFloat(-1.0 * Double(translation.x) * M_PI / 560))
            }
            
            if(translation.x > 175 || translation.x < -175) {
                UIView.animate(withDuration: 0.4, animations: {
                    self.profileImageView.alpha = 0
                })
            }
            print("Gesture is changing")
        } else if sender.state == .ended {
            profileImageView.center = CGPoint(x: cardInitialCenter.x, y: cardInitialCenter.y)
            profileImageView.transform = CGAffineTransform(rotationAngle: CGFloat(0.0))
            print("Gesture ended")
        }
    }

    
    @IBAction func didTap(_ sender: Any)
    {
        self.performSegue(withIdentifier: "profilePicture", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ProfilePictureViewController {
            if let image = profileImageView.image {
                destination.imagePicture = image
            }
        }
    }
    
    
}

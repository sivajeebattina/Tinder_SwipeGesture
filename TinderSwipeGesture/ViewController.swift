//
//  ViewController.swift
//  TinderSwipeGesture
//
//  Created by Uber - Sivajee Battina on 14/08/17.
//  Copyright © 2017 Uber. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var smileImageView: UIImageView!
    @IBOutlet weak var sadImageView: UIImageView!
    
    var divisionParam: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        divisionParam = (view.frame.size.width/2)/0.61
        sadImageView.alpha = 0
        smileImageView.alpha = 0
    }

    @IBAction func panGestureValueChanged(_ sender: UIPanGestureRecognizer) {
        let cardView = sender.view!
        let translationPoint = sender.translation(in: view)
        cardView.center = CGPoint(x: view.center.x+translationPoint.x, y: view.center.y+translationPoint.y)
        
        let distanceMoved = cardView.center.x - view.center.x
        if distanceMoved > 0 { // moved right side
            smileImageView.alpha = abs(distanceMoved)/view.center.x
            sadImageView.alpha = 0
        }
        else { // moved left side
            sadImageView.alpha = abs(distanceMoved)/view.center.x
            smileImageView.alpha = 0
        }
        
        //Tilt your card
        cardView.transform = CGAffineTransform(rotationAngle: distanceMoved/divisionParam)
        
        if sender.state == UIGestureRecognizerState.ended {
            if cardView.center.x < 20 { // Moved to left
                UIView.animate(withDuration: 0.3, animations: {
                    cardView.center = CGPoint(x: cardView.center.x-200, y: cardView.center.y)
                })
                return
            }
            else if (cardView.center.x > (view.frame.size.width-20)) { // Moved to right
                UIView.animate(withDuration: 0.3, animations: {
                    cardView.center = CGPoint(x: cardView.center.x+200, y: cardView.center.y)
                })
                return
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                self.resetCardViewToOriginalPosition()
            })
        }
    }
    
    func resetCardViewToOriginalPosition(){
        cardView.center = self.view.center
        self.sadImageView.alpha = 0
        self.smileImageView.alpha = 0
        cardView.transform = .identity
    }
    
    @IBAction func resetButtonClicked() {
        resetCardViewToOriginalPosition()
    }

}


//
//  ViewController.swift
//  PopoverView0605
//
//  Created by leslie on 6/5/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var swipeUpView: UIView!
    @IBOutlet weak var swipeUpLbl: UILabel!
    
    lazy var slideInTransitioningDelegate = SlideInPresentationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureRecognizers()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPopover" {
            let controller = segue.destination as! PopoverViewController
            
            //Adjusting popover view anchor point
            let presenttion = controller.presentationController as! UIPopoverPresentationController
            let frame = presenttion.sourceView?.bounds
            presenttion.sourceRect = frame!
            
            //Setting PopoverViewController as the delegate
            //So, PopoverViewController class has to conform UIAdaptivePresentationControllerDelegate protocol.
            controller.presentationController?.delegate = controller
        }
        else if let controller = segue.destination as? GamesTableViewController {
            if segue.identifier == "SummerSegue" {
                slideInTransitioningDelegate.direction = .left
                print(slideInTransitioningDelegate.direction)
            }
            else if segue.identifier == "WinterSegue" {
                slideInTransitioningDelegate.direction = .right
                print(slideInTransitioningDelegate.direction)
            }
            
            controller.transitioningDelegate = slideInTransitioningDelegate
            controller.modalPresentationStyle = .custom
            
            slideInTransitioningDelegate.disableCompactHeight = false
        }
        else if let controller = segue.destination as? MedalCountViewController {
            slideInTransitioningDelegate.direction = .bottom
            print(slideInTransitioningDelegate.direction)
            
            controller.transitioningDelegate = slideInTransitioningDelegate
            controller.modalPresentationStyle = .custom
            
            slideInTransitioningDelegate.disableCompactHeight = true
            
        }
    }
}

extension ViewController {
    
    func setupGestureRecognizers() {
        
        let leftPanRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handleLeftEdgePan(gestureRecognizer:)))
        leftPanRecognizer.edges = .left
        
        let rightPanRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handleRightEdgePan(gestureRecognizer:)))
        rightPanRecognizer.edges = .right
        
        let swipeUpRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handleSwipeUp(gestureRecognizer:)))
        
        view.addGestureRecognizer(leftPanRecognizer)
        view.addGestureRecognizer(rightPanRecognizer)
        swipeUpView.addGestureRecognizer(swipeUpRecognizer)
    }
    
    @objc func handleLeftEdgePan(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        
        /// If didn't have the .began state checking, there will be the warning below
        /// Warning: Attempt to present * on * which is already presenting
        if gestureRecognizer.state == .began {
            performSegue(withIdentifier: "SummerSegue", sender: nil)
        }
    }
    
    @objc func handleRightEdgePan(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        /// If didn't have the .began state checking, there will be the warning below
        /// Warning: Attempt to present * on * which is already presenting
        if gestureRecognizer.state == .began {
            performSegue(withIdentifier: "WinterSegue", sender: nil)
        }
    }
    
    @objc func handleSwipeUp(gestureRecognizer: UIPanGestureRecognizer) {
        
        let view = gestureRecognizer.view!
        let translation = gestureRecognizer.translation(in: view)
        
        //handling swiping directions
        switch gestureRecognizer.state {
        case .began, .changed:
            //swiping up
            if translation.y < 0 {
                print("swiping up")
            }
            //swiping down
            else if translation.y > 0 {
                print("swiping down")
            }
            //swiping right
            else if translation.x > 0 {
                print("swiping right")
            }
            //swiping left
            else if translation.x < 0 {
                print("swiping left")
            }
            
        case .ended:
            //swiping up
            if translation.y < 0 {
                print("swiping up")
                performSegue(withIdentifier: "MedalSegue", sender: nil)
            }
            //swiping down
            else if translation.y > 0 {
                print("swiping down")
            }
            //swiping right
            else if translation.x > 0 {
                print("swiping right")
            }
            //swiping left
            else if translation.x < 0 {
                print("swiping left")
            }

        default:
            break
        }
    }
}


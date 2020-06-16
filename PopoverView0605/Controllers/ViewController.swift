//
//  ViewController.swift
//  PopoverView0605
//
//  Created by leslie on 6/5/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
            
        }
    }
}

extension ViewController {
    
    func setupGestureRecognizers() {
        
        let leftPanRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handelLeftEdgePan(gestureRecognizer:)))
        leftPanRecognizer.edges = .left
        
        let rightPanRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handelRightEdgePan(gestuerRecognizer:)))
        rightPanRecognizer.edges = .right
        
        view.addGestureRecognizer(leftPanRecognizer)
        view.addGestureRecognizer(rightPanRecognizer)
    }
    
    @objc func handelLeftEdgePan(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        
        /// If didn't have the .began state checking, there will be the warning below
        /// Warning: Attempt to present * on * which is already presenting
        if gestureRecognizer.state == .began {
            performSegue(withIdentifier: "SummerSegue", sender: nil)
        }
    }
    
    @objc func handelRightEdgePan(gestuerRecognizer: UIScreenEdgePanGestureRecognizer) {
        /// If didn't have the .began state checking, there will be the warning below
        /// Warning: Attempt to present * on * which is already presenting
        if gestuerRecognizer.state == .began {
            performSegue(withIdentifier: "WinterSegue", sender: nil)
        }
    }
}

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
    var gamesTableVC: GamesTableViewController!

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
            }
            else if segue.identifier == "WinterSegue" {
                slideInTransitioningDelegate.direction = .right
            }
        }
    }
}

extension ViewController {
    
    func setupGestureRecognizers() {
        gamesTableVC = GamesTableViewController()
        
        let leftPanRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handelLeftEdgePan(gestureRecognizer:)))
        leftPanRecognizer.edges = .left
        
        let rightPanRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handelRightEdgePan(gestuerRecognizer:)))
        rightPanRecognizer.edges = .right
        
        view.addGestureRecognizer(leftPanRecognizer)
        view.addGestureRecognizer(rightPanRecognizer)
    }
    
    @objc func handelLeftEdgePan(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        performSegue(withIdentifier: "SummerSegue", sender: nil)
    }
    
    @objc func handelRightEdgePan(gestuerRecognizer: UIScreenEdgePanGestureRecognizer) {
        performSegue(withIdentifier: "WinterSegue", sender: nil)
    }
}

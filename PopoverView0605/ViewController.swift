//
//  ViewController.swift
//  PopoverView0605
//
//  Created by leslie on 6/5/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPopover" {
            let controller = segue.destination as! PopoverViewController
            let presenttion = controller.presentationController as! UIPopoverPresentationController
            
            //Adjusting popover view anchor point
            let frame = presenttion.sourceView?.bounds
            presenttion.sourceRect = frame!
            
            //Setting PopoverViewController as the delegate
            //So, PopoverViewController class has to conform UIAdaptivePresentationControllerDelegate protocol.
            controller.presentationController?.delegate = controller
        }
    }
}

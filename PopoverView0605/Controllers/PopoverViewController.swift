//
//  PopoverViewController.swift
//  PopoverView0605
//
//  Created by leslie on 6/5/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension PopoverViewController: UIAdaptivePresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        //This tells the UIPresentationController object that we want the view to be presented with its original presentation style (not its default fullScreen on small size iPhone),
        //so the view always looks like a popover, no matter the Size Class.
        return .none
    }
    
}

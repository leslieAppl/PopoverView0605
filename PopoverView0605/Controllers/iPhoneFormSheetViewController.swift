//
//  iPhoneFormSheetViewController.swift
//  PopoverView0605
//
//  Created by leslie on 6/6/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class iPhoneFormSheetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureRecognizers()
    }
    
    @IBAction func closeBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension iPhoneFormSheetViewController {
    func setupGestureRecognizers() {
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(gestureRecognizer:)))
        view.addGestureRecognizer(panRecognizer)
    }
    
    @objc func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}

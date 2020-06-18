//
//  iPhoneFormSheetViewController.swift
//  PopoverView0605
//
//  Created by leslie on 6/6/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class iPhoneFormSheetViewController: UIViewController {

    var viewCenterOrigin: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewCenterOrigin = view.center
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
        
        let view = gestureRecognizer.view!
        let translation = gestureRecognizer.translation(in: view)
        
        switch gestureRecognizer.state {
        case .began, .changed:
            ///Handling swiping direction to provent swiping upward animation
            if (view.center.y+translation.y) > viewCenterOrigin.y {
                moveViewWithPan(view: view, sender: gestureRecognizer)
            }
        case .ended:
            if (view.center.y+translation.y) > viewCenterOrigin.y {
                self.deleteView()
            }
        default:
            break
        }
        
    }
    
    func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        /// Tracking target view's routing corresponding to the pan gesture translation in the coordinate system of the specified view.
        view.center = CGPoint(x: view.center.x, y: view.center.y+translation.y)
        
        /// Resetting translation value to zero after pan gesture finished.
        sender.setTranslation(CGPoint.zero, in: view)
    }

    func deleteView() {
        UIView.animate(withDuration: 0.3) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

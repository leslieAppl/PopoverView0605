//
//  SlideInPresentationManager.swift
//  PopoverView0605
//
//  Created by leslie on 6/14/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

enum PresentationDirection {
  case left
  case top
  case right
  case bottom
}

class SlideInPresentationManager: NSObject {
    var direction: PresentationDirection = .left
    
    var disableCompactHeight = false
}

extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {
    
    /// Hooking up the presentation  controller
    /// When you present a view controller using the UIModalPresentationStyle.custom presentation style, the system calls this method and asks for the presentation controller that manages your custom style.
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentationController = SlideInPresentationController(presentedViewController: presented, presenting: presenting, direction: direction)
        
        return presentationController
    }
    
    /// Hooking up the animation controller
    /// Asks your delegate for the transition [animator object] to use when presenting a view controlle
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let presentationAnimator = SlideInPresentationAnimator(direction: direction, isPresentation: true)
        
        return presentationAnimator
    }
    
    /// Hooking up the animation controller
    /// Asks your delegate for the transition [animator object] to use when dismissing a view controller.
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let presentationAnimator = SlideInPresentationAnimator(direction: direction, isPresentation: false)
        
        return presentationAnimator
    }
}

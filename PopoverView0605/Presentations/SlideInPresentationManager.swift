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

//  MARK: - UIViewControllerTransitioningDelegate
/// 1.
/// When you want to present a view controller using a custom modal presentation type, set its modalPresentationStyle property to custom and assign an object that conforms to this protocol to its transitioningDelegate property. - Step 7, 8
/// 2.
/// When you present that view controller, UIKit queries your [transitioning delegate] for the objects to use when animating the view controller into position.
/// 3.
/// When implementing your [transitioning delegate object], you can return different [animator objects] depending on whether a view controller is being presented or dismissed. All transitions use a transition animator object—an object that conforms to the UIViewControllerAnimatedTransitioning protocol—to implement the basic animations. - Step 20
extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {
    
    /// Hooking up the presentation  controller
    /// When you present a view controller using the UIModalPresentationStyle.custom presentation style, the system calls this method and asks for the presentation controller that manages your custom style.
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentationController = SlideInPresentationController(presentedViewController: presented, presenting: presenting, direction: direction)
        
        ///Adaptive presentation controller delegate
        presentationController.delegate = self
        
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

extension SlideInPresentationManager: UIAdaptivePresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        
        if traitCollection.verticalSizeClass == .compact && disableCompactHeight {
            return .fullScreen
        }
        else {
            return .none
        }
    }
    
    ///Presenting adaptive view controller according to size traits
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        guard case(.fullScreen) = style else { return nil }
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "RotateViewController")
    }
}

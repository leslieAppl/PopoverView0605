//
//  SlideInPresentationAnimator.swift
//  PopoverView0605
//
//  Created by leslie on 6/16/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class SlideInPresentationAnimator: NSObject {
    let direction: PresentationDirection
    let isPresentation: Bool
    
    init(direction: PresentationDirection, isPresentation: Bool) {
        self.direction = direction
        self.isPresentation = isPresentation
        
        super.init()
    }
}

extension SlideInPresentationAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        /// 1
        /// If this is a presentation, the method asks the transitionContext for the view controller associated with .to. This is the view controller you’re moving to. If dismissal, it asks the transitionContext for the view controller associated with .from. This is the view controller you’re moving from.
        let key: UITransitionContextViewControllerKey = isPresentation ? .to : .from
        
        guard let controller = transitionContext.viewController(forKey: key) else { return }
        
        /// 2
        /// If the action is a presentation, your code adds the view controller’s view to the view hierarchy. This code uses the transitionContext to get the container view.
        if isPresentation {
            transitionContext.containerView.addSubview(controller.view)
        }
        
        ///3
        /// Calculate the frames you’re animating .from and .to.
        /// The first line asks the transitionContext for the view’s frame when it’s presented.
        ///The rest of the section tackles the trickier task of calculating the view’s frame when it’s dismissed. This section sets the frame’s origin so it’s just outside the visible area based on the presentation direction.
        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame
        switch direction {
        case .left:
            dismissedFrame.origin.x = -presentedFrame.width
        case .right:
            dismissedFrame.origin.x = transitionContext.containerView.frame.width
        case .top:
            dismissedFrame.origin.y = -presentedFrame.height
        case .bottom:
            dismissedFrame.origin.y = transitionContext.containerView.frame.height
        }
        
        /// 4
        /// Determine the transition’s initial and final frames. When presenting the view controller, it moves from the dismissed frame to the presented frame — vice versa when dismissing.
        let initialFrame = isPresentation ? dismissedFrame : presentedFrame
        let finalFrame = isPresentation ? presentedFrame : dismissedFrame
        
        /// 5
        /// Lastly, this method animates the view from initial to final frame. If this is a dismissal, you remove the view controller’s view from the view hierarchy.
        /// Note that you call completeTransition(_:) on transitionContext to inform the transition has finished.
        let animationDuration = transitionDuration(using: transitionContext)
        
        controller.view.frame = initialFrame    //Presentation Start Point
        UIView.animate(withDuration: animationDuration, animations: {
            controller.view.frame = finalFrame  //Presentation Ending Proint
        }) { (finished) in
            if !self.isPresentation {
                controller.view.removeFromSuperview()
            }
            
            transitionContext.completeTransition(finished)
        }
    }
}

//
//  SlideInPresentationController.swift
//  PopoverView0605
//
//  Created by leslie on 6/16/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

//  MARK: - UIPresentationController
/// An object that manages the transition animations and the presentation of view controllers onscreen.
/// From the time a view controller is presented until the time it is dismissed, UIKit uses a presentation controller to manage various aspects of the presentation process for that view controller.
/// The presentation controller can add its own animations on top of those provided by animator objects, it can respond to size changes, and it can manage other aspects of how the view controller is presented onscreen.
/// When you present a view controller using the present(_:animated:completion:) method, UIKit always manages the presentation process. Part of that process involves creating the presentation controller that is appropriate for the given presentation style.
/// You vend your custom presentation controller object through your view controller’s transitioning delegate. UIKit maintains a reference to your presentation controller object while the presented view controller is onscreen.
class SlideInPresentationController: UIPresentationController {
    
    private var dimmingView: UIView!
    private var direction: PresentationDirection

    ///5
    /// In addition to calculating the size of the presented view, you need to return its full frame.
    /// Position of the presented view in the container view by the end of the presentation transition.
    /// (Default: container view bounds)
    override var frameOfPresentedViewInContainerView: CGRect {
        print("5")
        var frame: CGRect = .zero
        
        frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView!.bounds.size)
        
        switch direction {
        case .right:
            frame.origin.x = containerView!.frame.width*(1.0/3.0)
        case .bottom:
            frame.origin.y = containerView!.frame.height*(1.0/3.0)
        default:
            frame.origin = .zero
        }
        
        return frame
    }
    
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, direction: PresentationDirection) {
        
        self.direction = direction
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        setupDimmingView()
    }
    
    ///1
    override func presentationTransitionWillBegin() {
        print("1")
        
        guard let dimmingView = self.dimmingView else {
            return
        }
        containerView?.insertSubview(dimmingView, at: 0)
        
        dimmingView.topAnchor.constraint(equalTo: containerView!.topAnchor).isActive = true
        dimmingView.bottomAnchor.constraint(equalTo: containerView!.bottomAnchor).isActive = true
        dimmingView.leadingAnchor.constraint(equalTo: containerView!.leadingAnchor).isActive = true
        dimmingView.trailingAnchor.constraint(equalTo: containerView!.trailingAnchor).isActive = true
        
        /// When a presentation or dismissal is in progress, this method returns the transition coordinator object associated with that transition. You can use this object to create additional animations and synchronize them with the transition animations.
        guard let coordinator = presentedViewController.transitionCoordinator else {
          dimmingView.alpha = 1.0
          return
        }
        
        /// Runs the specified animations at the same time as the view controller transition animations. Use this method to perform animations that are not handled by the animator objects themselves. All of the animations you specify must occur inside the animation context’s container view (or one of its descendants). Use the containerView property of the context object to get the container view.
        coordinator.animate(alongsideTransition: { _ in
          self.dimmingView.alpha = 1.0
        })

    }
    
    ///2
    override func dismissalTransitionWillBegin() {
        print("2")
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
          dimmingView.alpha = 0.0
          return
        }
        
        coordinator.animate(alongsideTransition: { (_) in
          //This gives the effect of fading the dimming view
          self.dimmingView.alpha = 0.0
        }, completion: nil)
    }
    
    ///3
    /// Here you reset the presented view’s frame to fit any changes to the containerView frame.
    override func containerViewWillLayoutSubviews() {
        print("3")
        ///Hooking up the overrided Frame Of  Presented View to reset coordinates position
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    ///4
    /// To give the size of the presented view controller's content to the presentation controller.
    /// If you are implementing a custom container view controller, you should override this method and use it to return the sizes of the contained children.
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        print("4")
        switch direction {
        case .left, .right:
            return CGSize(width: parentSize.width*(2.0/3.0), height: parentSize.height)
        case .bottom, .top:
            return CGSize(width: parentSize.width, height: parentSize.height*(2.0/3.0))
        }
    }
}

// MARK: - Private
private extension SlideInPresentationController {
    func setupDimmingView() {
        dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        dimmingView.alpha = 0.0 //invisible state
    }
}

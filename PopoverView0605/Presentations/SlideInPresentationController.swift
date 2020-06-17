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
    }
    
    ///1
    override func presentationTransitionWillBegin() {
        print("1")
    }
    
    ///2
    override func dismissalTransitionWillBegin() {
        print("2")
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

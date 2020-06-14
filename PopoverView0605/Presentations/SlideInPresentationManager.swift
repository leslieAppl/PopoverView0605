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

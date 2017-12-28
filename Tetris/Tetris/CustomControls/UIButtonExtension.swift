//
//  UIButtonExtension.swift
//  Tetris
//
//  Created by Matthias D'haeseleer on 28/12/2017.
//  Copyright © 2017 Matthias D'haeseleer. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    //Sean Allen - UIButton Animation - Swift [Youtube]
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = .greatestFiniteMagnitude
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
}

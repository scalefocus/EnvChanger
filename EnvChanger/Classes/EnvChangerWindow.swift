//
//  EnvironmentChangerWindow.swift
//  EnvSelectionDemo
//
//  Created by Gavril Tonev on 7.08.19.
//  Copyright © 2019 Gavril Tonev. All rights reserved.
//

import UIKit

class EnvChangerWindow: UIWindow {
    var button: UIButton?
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard let button = button else { return false }
        let buttonPoint = convert(point, to: button)
        return button.point(inside: buttonPoint, with: event)
    }
}

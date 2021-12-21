//
//  EnvButtonStartingPosition.swift
//  EnvChanger
//
//  Created by Nikola B Nikolov on 6.12.21.
//

import UIKit

/// Static values representing positions along an axis.
private extension CGFloat {
    static let start: CGFloat = 0.1
    static let middle: CGFloat = 0.5
    static let end: CGFloat = 0.9
}

/// Enum defining possible vertical positions.
public enum VerticalPosition {
    case top
    case center
    case bottom
    case custom(CGFloat)
    
    /// Position along the `y` axis of the view. If `custom` - `0` for the top, `1` for the bottom of the axis.
    var position: CGFloat {
        switch self {
        case .top:
            return .start
        case .center:
            return .middle
        case .bottom:
            return .end
        case .custom(let position):
            return position
        }
    }
}

/// Enum defining possible horizontal positions.
public enum HorizontalPosition {
    case left
    case center
    case right
    case custom(CGFloat)
    
    /// Position along the `x` axis of the view. If `custom` - `0` for the left, `1` for the right of the axis.
    var position: CGFloat {
        switch self {
        case .left:
            return .start
        case .center:
            return .middle
        case .right:
            return .end
        case .custom(let position):
            return position
        }
    }
}

/// Struct describing an `EnvButtonStartingPosition`.
public struct EnvButtonStartingPosition {
    
    // MARK: - Properties
    let y: VerticalPosition
    let x: HorizontalPosition
    
    // MARK: - Initializer
    /// Creates an `EnvButtonStartingPosition` instance.
    /// - Parameters:
    ///   - y: The vertical starting position of the button.
    ///   If `custom` - pass a value between `0` (for the top of the screen) and `1` (for the bottom of the screen).
    ///   - x: The horizontal starting position of the button.
    ///   If `custom` - pass a value between `0` (for the left of the screen) and `1` (for the right of the screen).
    public init(y: VerticalPosition, x: HorizontalPosition) {
        self.y = y
        self.x = x
    }
}

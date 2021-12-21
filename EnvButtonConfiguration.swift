//
//  EnvButtonConfiguration.swift
//  EnvChanger
//
//  Created by Nikola B Nikolov on 6.12.21.
//

import UIKit

/// Struct describing an `EnvButtonConfiguration` used to set up the Env button.
public struct EnvButtonConfiguration {
    
    /// Enum cases for style of the floating button.
    public enum EnvButtonStyle {
        
        /// Configure the button layout with title.
        case title(String)
        
        /// Configure the button layout with image.
        case image(UIImage)
    }
    
    // MARK: - Properties
    let style: EnvButtonStyle
    let startingPosition: EnvButtonStartingPosition
    
    // MARK: - Initializer
    /// Creates an `EnvButtonConfiguration` instance.
    /// - Parameters:
    ///   - style: Style of the button. Default is `.title("ENV")`
    ///   - startingPosition: Starting position of the button. Default is `y: .top, x: .left`.
    public init(style: EnvButtonStyle = .title("ENV"),
                startingPosition: EnvButtonStartingPosition = .init(y: .top, x: .left)) {
        self.style = style
        self.startingPosition = startingPosition
    }
}

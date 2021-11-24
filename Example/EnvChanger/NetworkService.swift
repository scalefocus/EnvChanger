//
//  NetworkService.swift
//  EnvChanger_Example
//
//  Created by Nikola B Nikolov on 17.11.21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import EnvChanger

/// NetworkService.
struct NetworkService {
    
    /// Enum holding environments.
    enum Environments: String, EnvironmentRepresentable {
        case production = "https://production.server.com/"
        case staging = "https://staging.server.com/"
        case development = "https://development.server.com"
        case testing = "https://10.0.1.1/"
        case edge = "edge.server.com"
        
        var environmentTitle: String {
            rawValue
        }
    }
    
    static var activeEnvironment = "https://production.server.com/"
}

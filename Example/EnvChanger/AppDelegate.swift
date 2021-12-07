//
//  AppDelegate.swift
//  EnvChanger
//
//  Created by Gavril Tonev on 08/15/2019.
//  Copyright (c) 2019 Gavril Tonev. All rights reserved.
//

import UIKit
import EnvChanger

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /// Instantiate to customise envButton `style` and `position` if needed.
        let envButtonConfig = EnvButtonConfiguration(style: .title("ENV"),
                                                     startingPosition: .init(y: .center, x: .center))
        
        /// Instantiate and pass handler for environment selection.
        let envChanger = EnvChangerController(envs: NetworkService.Environments.self,
                                              window: window,
                                              buttonConfiguration: envButtonConfig) { selectedEnvironment in
            NetworkService.activeEnvironment = selectedEnvironment.environmentTitle
        }
        
        /// If an environment has been saved, set is as the active environment.
        if !envChanger.savedEnvironment.isEmpty {
            NetworkService.activeEnvironment = envChanger.savedEnvironment
        }
        
        return true
    }
}

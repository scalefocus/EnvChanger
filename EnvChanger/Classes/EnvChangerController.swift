//
//  EnvChangerController
//  EnvChanger
//
//  Created by Gavril Tonev on 7.08.19.
//  Copyright © 2019 Gavril Tonev. All rights reserved.
//

import UIKit

/// Protocol defining the needed behaviour of the `Envs` enum.
/// Each enum case should provide `String` representing the environment title.
public protocol EnvironmentRepresentable: CaseIterable {
    
    /// This string is later on used for persisting the selected enviornment.
    /// `String` representing the environment title.
    var environmentTitle: String { get }
}

public class EnvChangerController<T>: UIViewController where T: EnvironmentRepresentable {
    class EnvAlertAction: UIAlertAction {
        var selectedEnv: T?
    }
    
    // MARK: - Properties
    public var savedEnvironment: String {
        userDefaults.string(forKey: activeEnvKey) ?? ""
    }
    
    private let activeEnvKey = "ENV_CHANGER_CURRENT_SAVED_ENVIRONMENT"
    private let window = EnvChangerWindow()
    private let appWindow: UIWindow?
    private let buttonConfiguration: EnvButtonConfiguration
    private var button: UIButton!
    private var userDefaults: UserDefaults { .standard }
    private var application: UIApplication { .shared }
    private var envs: T.Type
    private var environmentSelectedHandler: (T) -> Void
    private var envButtonHorizontalOffset: CGFloat {
        view.frame.width * buttonConfiguration.startingPosition.x.position
    }
    
    private var envButtonVerticalOffset: CGFloat {
        view.frame.height * buttonConfiguration.startingPosition.y.position
    }
    
    private var selectEnvironmentAlert: UIAlertController {
        let alert = UIAlertController(title: "Current env: \(savedEnvironment)",
                                      message: "Please select a backend environment",
                                      preferredStyle: .actionSheet)
        envs.allCases.forEach {
            let alertAction = EnvAlertAction(title: $0.environmentTitle,
                                             style: .default,
                                             handler: actionHandler(sender:))
            alertAction.selectedEnv = $0
            alert.addAction(alertAction)
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        return alert
    }
    
    private var environmentChangedAlert: UIAlertController {
        guard !savedEnvironment.isEmpty else { return UIAlertController() }
        
        let alert = UIAlertController(title: "Environment successfully changed.",
                                      message: "Your active environment is now: \n \(savedEnvironment)",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Great!", style: .default, handler: nil))
        return alert
    }
    
    // MARK: - Lifecycle methods
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Initializers
    /// Instantiate with the object of environments you would like to access.
    ///
    /// - Parameters:
    ///   - envs: 'T' of type String, CaseIterable object that should preferably have environments inside.
    ///   - buttonConfiguration: Sets the button title or image that will be displayed.
    ///   - environmentSelectedHandler: Add any logic you would want to execute after you selected your new environment in the environmentSelectedHandler.
    /// - Note:
    ///   - If no buttonConfiguration in the constructor by default it will set the title to 'EN'.
    ///   - Saves the first environment passed in to avoid getSavedEnvironment() to return an empty string.
    public init(envs: T.Type,
                window: UIWindow?,
                buttonConfiguration: EnvButtonConfiguration = .init(),
                environmentSelectedHandler: @escaping (T) -> Void) {
        self.appWindow = window
        self.buttonConfiguration = buttonConfiguration
        self.envs = envs
        self.environmentSelectedHandler = environmentSelectedHandler
        super.init(nibName: nil, bundle: nil)
        setupWindow()
        saveFirstEnvironment()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    @objc private func panDidFire(panner: UIPanGestureRecognizer) {
        let offset = panner.translation(in: view)
        panner.setTranslation(.zero, in: view)
        var center = button.center
        center.x += offset.x
        center.y += offset.y
        button.center = center
    }
    
    // MARK: - Actions
    @objc private func environmentButtonTapped() {
        /// Prevents from attempting to present the same alert when clicking on the ENV change button.
        if appWindow?.rootViewController?.presentedViewController is UIAlertController { return }
        
        /// Configured popover controller for iPad alerts.
        /// Note: Cancel buttons are removed from popovers automatically,
        /// because tapping outside the popover represents "cancel", in a popover context.
        if let popoverController = selectEnvironmentAlert.popoverPresentationController,
           let currentView = appWindow?.rootViewController?.view {
            popoverController.sourceView = currentView
            popoverController.sourceRect = CGRect(x: currentView.bounds.midX,
                                                  y: currentView.bounds.midY,
                                                  width: 0,
                                                  height: 0)
            /// To hide the arrow of any particular direction.
            popoverController.permittedArrowDirections = []
        }
        
        appWindow?.rootViewController?.present(selectEnvironmentAlert, animated: true)
    }
    
    // MARK: - Public methods
    /// Resizing the whole button.
    ///
    /// - Parameters:
    ///   - newWidth: Enter the new width you would like to set.
    ///   - newHeight: Enter the new height you would like to set.
    /// - Note:
    ///   - imageEdgeInsets are calculated and set as '(height + width) / 2',
    ///     to avoid having inaccurate button image and size.
    public func resizeFrame(newWidth: CGFloat, newHeight: CGFloat) {
        let imageEdgeInsets = (newWidth + newHeight) / 2
        
        button.frame.size.width = newWidth
        button.frame.size.height = newHeight
        button.imageEdgeInsets = UIEdgeInsets(top: imageEdgeInsets,
                                              left: imageEdgeInsets,
                                              bottom: imageEdgeInsets,
                                              right: imageEdgeInsets)
    }
    
    // MARK: - Private methods
    /// When initializing the controller with the given environments,
    /// saves the first found environment from the list to UserDefaults.
    private func saveFirstEnvironment() {
        guard let firstEnvironment = envs.allCases.first else { return }
        
        if savedEnvironment.isEmpty {
            userDefaults.set(firstEnvironment.environmentTitle, forKey: activeEnvKey)
        }
    }
    
    /// Sets the window level to the highest magnitude so that it will display always on top.
    private func setupWindow() {
        window.windowLevel = UIWindow.Level(.greatestFiniteMagnitude)
        window.isHidden = false
        window.rootViewController = self
        window.button?.addTarget(self, action: #selector(environmentButtonTapped), for: .touchUpInside)
    }
    
    /// Configuration of the button and view.
    private func setupUI() {
        let view = UIView()
        let button = UIButton(type: .custom)
        
        switch buttonConfiguration.style {
        case .title(let title):
            button.format(with: title)
        case .image(let image):
            button.format(with: image)
        }
        
        button.sizeToFit()
        button.frame = CGRect(origin: CGPoint(x: (view.frame.minX + envButtonHorizontalOffset) - button.frame.width / 2,
                                              y: (view.frame.minY + envButtonVerticalOffset) - button.frame.height / 2),
                              size: button.bounds.size)
        view.addSubview(button)
        self.view = view
        self.button = button
        window.button = button
        
        let panner = UIPanGestureRecognizer(target: self, action: #selector(panDidFire))
        button.addGestureRecognizer(panner)
    }
    
    /// Action handler for the pressed alert.
    ///
    /// - Parameter sender: Reads the sender as 'EnvAlertAction', so that you can pass the 'T' object in the completion handler.
    /// - Caches the rawValue of the object in UserDefaults if the user wants to use it.
    /// - Returns: Passes 'T' object to completionhandler.
    private func actionHandler(sender: UIAlertAction) {
        guard let envAlertAction = sender as? EnvAlertAction,
              let selectedEnv = envAlertAction.selectedEnv else { return }
        
        userDefaults.set(selectedEnv.environmentTitle, forKey: activeEnvKey)
        environmentSelectedHandler(selectedEnv)
        appWindow?.rootViewController?.present(environmentChangedAlert, animated: true)
    }
}

# EnvChanger

[![CI Status](https://img.shields.io/travis/Gavril Tonev/EnvChanger.svg?style=flat)](https://travis-ci.org/Gavril Tonev/EnvChanger)
[![Version](https://img.shields.io/cocoapods/v/EnvChanger.svg?style=flat)](https://cocoapods.org/pods/EnvChanger)
[![License](https://img.shields.io/cocoapods/l/EnvChanger.svg?style=flat)](https://cocoapods.org/pods/EnvChanger)
[![Platform](https://img.shields.io/cocoapods/p/EnvChanger.svg?style=flat)](https://cocoapods.org/pods/EnvChanger)

## About

EnvChanger is a simple tool that helps developers and testers to switch between backend environments really quickly without having to download a specific build.

Displays a button in the top right corner that when selected, presents an alert with the given possible environments
allowing users to easily swap them.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage 

1. We assume you hold the list of your backend environments in an enum:

```swift
enum Envs: String {
    case production = "https://production.server.com/"
    case staging = "https://staging.server.com/"
    case development = "https://development.server.com"
    case testing = "https://10.0.1.1/"
    case edge = "edge.server.com"
}
```

2. Your enum needs to conform to the `EnvironmentRepresentable` protocol, like so:

```swift
enum Envs: String, EnvironmentRepresentable {
    case production = "https://production.server.com/"
    case staging = "https://staging.server.com/"
    case development = "https://development.server.com"
    case testing = "https://10.0.1.1/"
    case edge = "edge.server.com"
    
    var environmentTitle: String {
        return rawValue
    }
}
```

3. Create an instance of `EnvChangerController` in your AppDelegate `didFinishLaunchingWithOptions`, passing your environemnt enum:

```swift
// The variable holding your environemnt. Your setup might be different
var ACTIVE_ENVIRONMENT = Envs.production.environmentTitle

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    // Passing a completion handler, for when the user selects an environment
    let envChanger = EnvChangerController(envs: Envs.self) { selectedEnvironment in
        
        // Updating your environment variable. You might need to update your networking service as well.
        ACTIVE_ENVIRONMENT = selectedEnvironment.environmentTitle
        print(ACTIVE_ENVIRONMENT)
    }
    
    // Optional, so that the choice of environment persists the next time you start your app
    ACTIVE_ENVIRONMENT = envChanger.getSavedEnvironment()

    return true
}
```

### More Usage

#### Access the saved environment:

```swift
getSavedEnvironment() -> String  
```
 *Note: It saves the chosen environment in UserDefaults.*

#### Resizes the button with the specified height/width.
```swift
resizeFrame(newWidth: CGFloat, newHeight: CGFloat)  
```  
*Note: If a image is set, the imageEdgeInsets are calculated and set as '(height + width) / 2'.*

#### Additional Notes
- If no button image/title is passed in the constructor, by default it will set the button title to 'EN'.  
- If a button title AND image is specified, the image is implemented and the title set will not be set. 

## Installation

EnvChanger is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'EnvChanger'
```

## Author

Gavril Tonev, gavril.tonev@upnetix.com

## License

EnvChanger is available under the [MIT license](LICENSE).

## TODO

• Implement configurable button style.  
• Implement configurable starting button position.
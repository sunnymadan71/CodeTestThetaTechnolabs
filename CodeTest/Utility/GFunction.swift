

import UIKit
import Foundation
enum ConvertType {
    case LOCAL,UTC,NOCONVERSION
}

class GFunction: UIViewController {
    static let shared   : GFunction = GFunction()

    private func getLastController() -> UIViewController? {
        if let tabBarVC = topMostWindowController() as? UITabBarController {
            if let NAV = tabBarVC.viewControllers?[tabBarVC.selectedIndex] as? UINavigationController {
                if let lastVC = NAV.topViewController {
                    return lastVC
                }
            }
        } else if let navVC = topMostWindowController() as? UINavigationController {
            if let lastVC = navVC.topViewController {
                return lastVC
            }
        } else {
            return topMostWindowController()
        }
        return nil
    }
    private func topMostWindowController() -> UIViewController? {
        var topController = AppDelegate.shared.window?.rootViewController
        while ((topController?.presentedViewController) != nil) {
            topController = topController?.presentedViewController
        }
        return topController
    }
    
    
   
   
    func getWindow() -> UIWindow? {
        return UIApplication.shared.windows.first
    }
    //kStartNav
    func manageLogin() {
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.kIsLoggedIn.key) {
            setHome()
        } else {
            setLogin()
        }
    }
    func setLogin(){
        let kLoginNav = "loginNav"
        let nav = UIStoryboard.kAuthStoryBoard.instantiateViewController(withIdentifier: kLoginNav)
        guard let window = GFunction.shared.getWindow() else { return }
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
    func setHome(){
        let VC = TabBarVC.instantiate(fromAppStoryboard: UIStoryboard.kHome)
        guard let window = GFunction.shared.getWindow() else { return }
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.kIsLoggedIn.key)
        window.rootViewController = VC
    }
    
}
extension UIStoryboard{
    static let kHome             = UIStoryboard(name: "Home", bundle: nil)
    static let kAuthStoryBoard   = UIStoryboard(name: "Authentication", bundle: nil)
  
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        
        guard let scene = self.instantiateViewController(withIdentifier: storyboardID) as? T else {
            
            fatalError("ViewController with identifier \(storyboardID), not found in \(self) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        
        return scene
    }
}

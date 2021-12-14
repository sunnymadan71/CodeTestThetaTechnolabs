

import UIKit
import Foundation
enum ConvertType {
    case LOCAL,UTC,NOCONVERSION
}

class GFunction: UIViewController {
    static let shared   : GFunction = GFunction()
    var mainEmail = ""
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
    func showAlert(_ title : String = "" ,
                   actionOkTitle : String = "Ok" ,
                   actionCancelTitle : String = "" ,
                   message : String,
                   completion: ((Bool) -> ())? )
    {
        let alert : UIAlertController = UIAlertController(title: title == "" ? nil : title, message: message.localized, preferredStyle: .alert)
        
        let actionOk : UIAlertAction = UIAlertAction(title: actionOkTitle.localized, style: .default) { (action) in
            if completion != nil {
                completion!(true)
            }
        }
        alert.addAction(actionOk)
        
        if actionCancelTitle != "" {
            
            let actionCancel : UIAlertAction = UIAlertAction(title: actionCancelTitle.localized, style: .cancel) { (action) in
                if completion != nil {
                    completion!(false)
                }
            }
            
            alert.addAction(actionCancel)
        }
        DispatchQueue.main.async {
            UIApplication.topViewController()?.present(alert, animated: true, completion: {
                
            })
        }
        
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
extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    class var safeArea : UIEdgeInsets {
        if UIApplication.shared.windows.count > 0{
            if #available(iOS 11.0, *) {
                return UIApplication.shared.windows[0].safeAreaInsets
            } else {
                return UIEdgeInsets.zero
                // Fallback on earlier versions
            }
        }
        return UIEdgeInsets.zero
    }
}
extension String {
    
    var localized: String {
        print("NSLocalizedString localized :::::::::::::::: \(self)")
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main.getBundleName(), value: "", comment: "")
    }
}
extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
   
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
            object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    
    //TODO: Use
    //    Bundle.main.releaseVersionNumber
    //    Bundle.main.buildVersionNumber
    
    //MARK:- Bundle Localization
    
    func getBundleName() -> Bundle{
        
        func returnBase() -> Bundle {
            let path = Bundle.main.path(forResource: "Base" , ofType: "lproj")
            let bundle = Bundle(path: path!)
            return bundle!
        }
        
        if let languageArray = UserDefaults.standard.value(forKey: "AppleLanguages") as? Array<String> {
            let kLanguage_en                                = "en"
            switch languageArray[0] {
                
            case kLanguage_en:
                if let path = Bundle.main.path(forResource: languageArray[0] , ofType: "lproj") {
                    let bundle = Bundle(path: path)
                    return bundle!
                } else {
                    return returnBase()
                }
                
                
            default:
                if let path = Bundle.main.path(forResource: languageArray[0] , ofType: "lproj") {
                    let bundle = Bundle(path: path)
                    return bundle!
                } else {
                    return returnBase()
                }
                
            }
            
        } else {
            return returnBase()
        }
        
    }
}

extension UIView {
    fileprivate typealias ReturnGestureAction = (() -> Void)?
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer1"
    }
    fileprivate var tapGestureRecognizerAction: ReturnGestureAction? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? ReturnGestureAction
            return tapGestureRecognizerActionInstance
        }
    }
    func handleTapToAction(action: (() -> Void)?)
     {
         let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHanldeAction))
         self.tapGestureRecognizerAction = action
         self.isUserInteractionEnabled = true
         self.addGestureRecognizer(gesture)
     }
    @objc func tapGestureHanldeAction()
    {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {
            GFunction.shared.showAlert(message: "No Children exists", completion: nil)
           
        }
    }
}

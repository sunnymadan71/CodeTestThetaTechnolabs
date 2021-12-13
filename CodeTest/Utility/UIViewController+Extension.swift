
import UIKit
extension UIViewController {
    
    open override func awakeFromNib()
    {
        self.modalPresentationStyle = .overFullScreen
    }
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: UIStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    @IBAction func popViewController(sender : AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnDismiss(sender : AnyObject) {
        _ = self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func popToRootViewController(sender : AnyObject) {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    func hideTabBarBG() {
        /*if let tabbarVC = self.tabBarController as? TabBarVC
        {
            tabbarVC.imgView.isHidden = true
        }*/
//        self.tabBarController?.tabBar.isHidden = true
//        self.view.layoutIfNeeded()
    }
    
    func showTabBarBG() {
       /* if let tabbarVC = self.tabBarController as? TabBarVC
        {
            tabbarVC.imgView.isHidden = false
        }*/
//        self.tabBarController?.tabBar.isHidden = false
//        self.view.layoutIfNeeded()
    }
    
    /**
            Custome ViewController Present Method
     */
    func presentVC(vc:UIViewController,animated:Bool = true, complation : ((Bool) -> Void)? = { _ in})
    {
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true) {
            if let handler = complation
            {
                handler(true)
            }
        }
    }
    
}

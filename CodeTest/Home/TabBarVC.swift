
import UIKit
class TabBarVC : UITabBarController  , UITabBarControllerDelegate{
    
 
     var currentVc = UIViewController()
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    deinit {
        
    }
    
    func setUpView()
    {
        self.delegate = self
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isToolbarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}


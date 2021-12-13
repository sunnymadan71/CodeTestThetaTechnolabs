//
//  ProfileVC.swift
//  CodeTest
//
//  Created by logicloops on 13/12/21.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnLogout: UIButton!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    deinit {
        
    }
    
    func setUpView(){
        self.lblEmail.text! = GFunction.shared.mainEmail
    }
 
    @IBAction func btnLogoutTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.kIsLoggedIn.key)
        GFunction.shared.manageLogin()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
}

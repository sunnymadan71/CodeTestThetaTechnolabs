//
//  ViewController.swift
//  CodeTest
//
//  Created by logicloops on 13/12/21.
//

import UIKit
import IQKeyboardManagerSwift
class LoginVC: UIViewController {

    @IBOutlet weak var lblValidationMessage: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    deinit {
        
    }
    
    func setUpView(){
        
    }
 
    @IBAction func btnLoginTapped(_ sender: UIButton) {
        if self.txtEmail.text!.trim().isEmpty{
            self.lblValidationMessage.text = "Please enter email"
            self.showAlert()
        }else if !Validation.isValidEmail(testStr: self.txtEmail.text!){
            self.lblValidationMessage.text = "Please enter valid email"
            self.showAlert()
        }else if self.txtPassword.text!.trim().isEmpty{
            self.lblValidationMessage.text = "Please enter password"
            self.showAlert()
        }else{
            GFunction.shared.setHome()
            GFunction.shared.mainEmail = self.txtEmail.text!
        }
    }
    func showAlert() {
        // set the timer
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector:#selector(self.dismissAlert), userInfo: nil, repeats: false)
    }
    @objc func dismissAlert(){
        self.lblValidationMessage.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
}


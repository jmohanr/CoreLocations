//
//  DBSignInVC.swift
//  CorrentLocation
//
//  Created by Admin on 08/10/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Firebase


class DBSignInVC: UIViewController {

    @IBOutlet weak var otpTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInAction(_ sender: Any) {
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID!,
            verificationCode: otpTxtField.text!)
        Auth.auth().signInAndRetrieveData(with: credential) { (user, error) in
            if let error = error {
              print(error)
                return
            } else{
                 UserDefaults.standard.set(true, forKey: "LoggedIn")
                let appDelegate = UIApplication.shared.delegate! as! AppDelegate
                let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "TabBarController")
                appDelegate.window?.rootViewController = initialViewController
                appDelegate.window?.makeKeyAndVisible()
            }

        }
        
    }
    }

extension DBSignInVC:UITextFieldDelegate {
    override func resignFirstResponder() -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        toolBar.items = [
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.sendCodeBtnAction))]
        
        textField.inputAccessoryView = toolBar
    }
    
    @objc func sendCodeBtnAction(){
        Auth.auth().languageCode = "En";
        PhoneAuthProvider.provider().verifyPhoneNumber(self.emailTxtField.text!, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                print("The final error is ==>\(error)")
                return
            }
            // Sign in using the verificationID and the code sent to the user
            // Here your can store your verificationID in user default and later used for sign in. Or pass this verification id to your next view controller for OTP verification.
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
        }
    }
}


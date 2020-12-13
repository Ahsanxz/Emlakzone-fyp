//
//  SigninVC.swift
//  Emlakzone1
//
//  Created by AL Rayyan Asif on 21/01/2020.
//  Copyright © 2020 AL Rayyan Asif. All rights reserved.
//

import UIKit
import FirebaseAuth
import SkyFloatingLabelTextField
import TTGSnackbar

class SigninVC: UIViewController {
    
    @IBOutlet weak var email_lbl: SkyFloatingLabelTextField!
    
    @IBOutlet weak var pass_lbl: SkyFloatingLabelTextField!
    
    let snackbar = TTGSnackbar(message: "Please Fill The Text Field!", duration: .short)
    let snackbar1 = TTGSnackbar(message: "Please check your Email or Password", duration: .short)
    let snackbar2 = TTGSnackbar(message: "Signin Successfully", duration: .short)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
               self.snackbar.backgroundColor = .white
               self.snackbar.messageTextColor = .red
               self.snackbar1.backgroundColor = .white
               self.snackbar1.messageTextColor = .red
               self.snackbar2.backgroundColor = .white
               self.snackbar2.messageTextColor = .red

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signinTapped(_ sender: Any) {
        let email = email_lbl.text!
       
        let password = pass_lbl.text!
        
        if email.isEmpty || password.isEmpty{
            
            self.snackbar.show()
            
        }else{
            
             // Signing in the user
                       Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                          
                        
                        
                        if error != nil {
                                     // Couldn't sign in
                                    
                            self.snackbar1.show()
                            
                            
                        }
                         else {
                             
                         self.snackbar2.show()
                            
                            
                         }

                
            }
            
        }
      
        
       
        
   
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}

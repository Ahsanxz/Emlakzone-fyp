//
//  SignupVC.swift
//  Emlakzone1
//
//  Created by AL Rayyan Asif on 21/01/2020.
//  Copyright © 2020 AL Rayyan Asif. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import FirebaseAuth
import Firebase
import TTGSnackbar

class SignupVC: UIViewController {
    
    @IBOutlet weak var email_lbl: SkyFloatingLabelTextField!
    
    @IBOutlet weak var name_lbl: SkyFloatingLabelTextField!
    @IBOutlet weak var pass_lbl: SkyFloatingLabelTextField!
    @IBOutlet weak var confirm_pass_lbl: SkyFloatingLabelTextField!
    // address is mobile number now
    @IBOutlet weak var address_lbl: SkyFloatingLabelTextField!
    
    
    
    let snackbar = TTGSnackbar(message: "Please Fill The Text Field!", duration: .short)
      let snackbar1 = TTGSnackbar(message: "Please check your Email or Password", duration: .short)
      let snackbar2 = TTGSnackbar(message: "Signup Successfully", duration: .short)
      

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.snackbar.backgroundColor = .red
              self.snackbar1.backgroundColor = .red
              self.snackbar2.backgroundColor = .red

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func create_Account(_ sender: Any) {
  
        let email = email_lbl.text!
        let pass = pass_lbl.text!
  
        if email.isEmpty || pass.isEmpty{
            
            self.snackbar.show()
            
        }else{
            
            // Create the user
                  
                  
                 Auth.auth().createUser(withEmail: email, password: pass) { (result, err) in
                     
                     // Check for errors
                     if err != nil {
                         
                         // There was an error creating the user
                         self.snackbar1.show()
                     }else{
                      self.snackbar2.show()
                      
                      }
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


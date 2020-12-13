//
//  AgenciesDetailsVC.swift
//  Emlakzone1
//
//  Created by AL Rayyan Asif on 29/01/2020.
//  Copyright © 2020 AL Rayyan Asif. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class AgenciesDetailsVC: UIViewController {
    
    @IBOutlet weak var agn_img: UIImageView!
    @IBOutlet weak var agn_title_lbl: UILabel!
    @IBOutlet weak var name_lbl: UILabel!
    @IBOutlet weak var email_lbl: UILabel!
    @IBOutlet weak var phn_lbl: UILabel!
    @IBOutlet weak var mobile_lbl: UILabel!
    
    
    
       var titleimg: String? = ""
       var titlename: String? = ""
       var personName: String? = ""
       var email: String? = ""
       var mob: String? = ""
       var phn: String? = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request(self.titleimg!, method: .get).responseImage { response in
                        guard let Image = response.result.value else {
                            // Handle error
                           
                            return
                        }
                        // Do stuff with your image
               //print(type(of: Image))
                  self.agn_img.image = Image
                    }
        
        
        self.agn_title_lbl.text = titlename
        self.name_lbl.text = personName
        self.email_lbl.text = email
        self.phn_lbl.text = phn
        self.mobile_lbl.text = mob
        
        

        // Do any additional setup after loading the view.
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

//
//  WorkerDetailsVC.swift
//  Emlakzone1
//
//  Created by AL Rayyan Asif on 26/01/2020.
//  Copyright © 2020 AL Rayyan Asif. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage



class WorkerDetailsVC: UIViewController {

    
    @IBOutlet weak var worker_img: UIImageView!
    
    @IBOutlet weak var worker_name_lbl: UILabel!
    
    @IBOutlet weak var worker_addr_lbl: UILabel!
    
    
    @IBOutlet weak var worker_id: UILabel!
    
    @IBOutlet weak var worker_city: UILabel!
    @IBOutlet weak var worker_phn: UILabel!
    @IBOutlet weak var worker_job: UILabel!
    @IBOutlet weak var worker_location: UILabel!
    
    
    var titleimg: String? = ""
    var titlename: String? = ""
    var address: String? = ""
    var id: String? = ""
    var city: String? = ""
    var phn: String? = ""
    var job: String? = ""
    var location: String? = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
          Alamofire.request(self.titleimg!, method: .get).responseImage { response in
                    guard let Image = response.result.value else {
                        // Handle error
                       
                        return
                    }
                    // Do stuff with your image
           //print(type(of: Image))
              self.worker_img.image = Image
                   
           

                }
        
        worker_name_lbl.text = titlename
        worker_addr_lbl.text = address
        worker_id.text = id
        worker_phn.text = phn
        worker_job.text = job
        worker_location.text = location
        worker_city.text = city
        

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

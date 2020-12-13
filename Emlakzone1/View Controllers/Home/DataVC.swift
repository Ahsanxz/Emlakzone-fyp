//
//  DataVC.swift
//  Emlakzone1
//
//  Created by AL Rayyan Asif on 15/01/2020.
//  Copyright © 2020 AL Rayyan Asif. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AACarousel

class DataVC: UIViewController,AACarouselDelegate {
    
    
    //@IBOutlet weak var property_img: UIImageView!
    
    @IBOutlet weak var carouselView: AACarousel!
    
    
    
    @IBOutlet weak var price_lbl: UILabel!
    @IBOutlet weak var Ptitle_lbl: UILabel!
    @IBOutlet weak var description_txt: UITextView!
    
    
    @IBOutlet weak var pId_lbl: UILabel!
    @IBOutlet weak var detail_price_lbl: UILabel!
    @IBOutlet weak var bed_lbl: UILabel!
    @IBOutlet weak var bath_lbl: UILabel!
    @IBOutlet weak var p_demand_lbl: UILabel!
    @IBOutlet weak var p_purpose_lbl: UILabel!
    @IBOutlet weak var agency_img: UIImageView!
    @IBOutlet weak var agency_titl: UILabel!
    
    
    @IBOutlet weak var agency_name_lbl: UILabel!
    @IBOutlet weak var agency_email_lbl: UILabel!
    @IBOutlet weak var agency_phn_lbl: UILabel!
    @IBOutlet weak var agency_mob_lbl: UILabel!
    
    
    
      var titleimg: String? = ""
    
    var pathArray = [String]()
    var titleArray = [String]()
    
      var titlename: String? = ""
      var price: String? = ""
      var property_description: String? = ""
      var bed: String? = ""
      var bath: String? = ""
      var pid: String? = ""
      var purpos: String? = ""
      var demand: String? = ""
    
      var agencyImg: String? = ""
      var agencyTitl: String? = ""
    
    var agencyName: String? = ""
    var agencyEmail: String? = ""
    var agencyPhn: String? = ""
    var agencyMob: String? = ""
    
 

    override func viewDidLoad() {
      
        super.viewDidLoad()
        
        ////
        titleArray = [""]
        
        carouselView.delegate = self
        carouselView.setCarouselData(paths: pathArray,  describedTitle: titleArray, isAutoScroll: true, timer: 5.0, defaultImage: "defaultImage")
        
        //optional methods
            carouselView.setCarouselOpaque(layer: false, describedTitle: false, pageIndicator: false)
            carouselView.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 5, pageIndicatorColor: nil, describedTitleColor: nil, layerColor: nil)
        
  
        
        
     
        
        /////
        //print(images.count)
        
   
        Alamofire.request(self.agencyImg!, method: .get).responseImage { response in
                         guard let Image = response.result.value else {
                             // Handle error
                            
                             return
                         }
                         // Do stuff with your image
               
                   self.agency_img.image = Image



                     }
        
        

        Ptitle_lbl.text = titlename
        price_lbl.text = ("TL \(price!)")
        detail_price_lbl.text = ("TL \(price!)")
        description_txt.text = property_description
        pId_lbl.text = pid
        bed_lbl.text = bed
        bath_lbl.text = bath
        p_purpose_lbl.text = purpos
        p_demand_lbl.text = demand
        
        
        agency_titl.text = agencyTitl
        
        
        agency_name_lbl.text = agencyName
        agency_email_lbl.text = agencyEmail
        agency_phn_lbl.text = agencyPhn
        agency_mob_lbl.text = agencyMob
        
            
        
        // Do any additional setup after loading the view.
    }
    
    
   //require method
    func downloadImages(_ url: String, _ index: Int) {
        
        //here is download images area
         let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: url)!, placeholder: UIImage.init(named: "defaultImage"), options: [.transition(.fade(0))], progressBlock: nil, completionHandler: { (downloadImage, error, cacheType, url) in
            self.carouselView.images[index] = downloadImage!
        })
    }
    
    //optional method (interaction for touch image)
       func didSelectCarouselView(_ view: AACarousel ,_ index: Int) {
           
           let alert = UIAlertView.init(title:"Alert" , message: titleArray[index], delegate: self, cancelButtonTitle: "OK")
          // alert.show()
           
           //startAutoScroll()
           //stopAutoScroll()
       }
       
       //optional method (show first image faster during downloading of all images)
       func callBackFirstDisplayView(_ imageView: UIImageView, _ url: [String], _ index: Int) {
           
           imageView.kf.setImage(with: URL(string: url[index]), placeholder: UIImage.init(named: "defaultImage"), options: [.transition(.fade(1))])
           
       }
       
       func startAutoScroll() {
          //optional method
          carouselView.startScrollImageView()
           
       }
       
       func stopAutoScroll() {
           //optional method
           carouselView.stopScrollImageView()
       }
    
    

 

}


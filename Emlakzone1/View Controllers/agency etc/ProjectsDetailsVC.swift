//
//  DataProjectsVC.swift
//  Emlakzone1
//
//  Created by AL Rayyan Asif on 22/01/2020.
//  Copyright © 2020 AL Rayyan Asif. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AACarousel

class ProjectsDetailsVC: UIViewController,AACarouselDelegate {
    
    
    @IBOutlet weak var project_img: UIImageView!
    
    
    @IBOutlet weak var carouselView: AACarousel!
    
    
    @IBOutlet weak var developer_imp: UIImageView!
    @IBOutlet weak var logoa_img: UIImageView!
    
    @IBOutlet weak var proj_Price_lbl: UILabel!
    
    
    @IBOutlet weak var title_lbl: UILabel!
    
    @IBOutlet weak var overview_txt: UITextView!
    @IBOutlet weak var proj_id: UILabel!
    @IBOutlet weak var min_price_lbl: UILabel!
    @IBOutlet weak var max_pric_lbl: UILabel!
    @IBOutlet weak var pupose_lbl: UILabel!
    @IBOutlet weak var demand_lbl: UILabel!
    
    @IBOutlet weak var developer_name_lbl: UILabel!
    @IBOutlet weak var dev_id_lbl: UILabel!
    @IBOutlet weak var dev_mail_lbl: UILabel!
    @IBOutlet weak var dev_phn_lbl: UILabel!
    @IBOutlet weak var dev_mob_lbl: UILabel!
    
    
    
    var pathArray = [String]()
    var titleArray = [String]()
    
    
    var titleimg: String? = ""
    var titlename: String? = ""
    var min_price: String? = ""
    var max_price: String? = ""
    var projId: String? = ""
    var overView: String? = ""
    var purpose: String? = ""
    var demand: String? = ""
    
    var devImg: String? = ""
    var devName: String? = ""
    var devId: String? = ""
    var dev_mail: String? = ""
    var dev_phn: String? = ""
    var dev_mob: String? = ""
    var dev_logo: String? = ""
    
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleArray = [""]
        
        carouselView.delegate = self
        carouselView.setCarouselData(paths: pathArray,  describedTitle: titleArray, isAutoScroll: true, timer: 5.0, defaultImage: "defaultImage")
        
        //optional methods
            carouselView.setCarouselOpaque(layer: false, describedTitle: false, pageIndicator: false)
            carouselView.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 5, pageIndicatorColor: nil, describedTitleColor: nil, layerColor: nil)
        
        
        
        
        
 
    
    
    Alamofire.request(self.devImg!, method: .get).responseImage { response in
                            guard let dImage = response.result.value else {
                                // Handle error
                               
                                return
                            }
             self.developer_imp.image = dImage
        
     }
    
    
    Alamofire.request(self.dev_logo!, method: .get).responseImage { response in
                            guard let lImage = response.result.value else {
                                // Handle error
                               
                                return
                            }
             self.logoa_img.image = lImage
      
     }
        
        
        self.title_lbl.text = titlename
        self.proj_id.text = projId
        self.min_price_lbl.text = min_price
        self.max_pric_lbl.text = max_price
        self.pupose_lbl.text = purpose
        self.demand_lbl.text = demand
        self.overview_txt.text = overView
        
        self.proj_Price_lbl.text = ("\(min_price!) - \(max_price!)")
        
        ////////////////
        
        self.developer_name_lbl.text = devName
        self.dev_id_lbl.text = devId
        self.dev_mail_lbl.text = dev_mail
        self.dev_mob_lbl.text = dev_mob
        self.dev_phn_lbl.text = dev_phn

        
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

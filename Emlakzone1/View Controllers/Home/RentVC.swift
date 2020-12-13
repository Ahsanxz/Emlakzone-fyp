//
//  HomeVC.swift
//  Emlakzone1
//
//  Created by AL Rayyan Asif on 10/01/2020.
//  Copyright © 2020 AL Rayyan Asif. All rights reserved.
//

import UIKit
import Networking
import SwiftyJSON
import Alamofire
import AlamofireImage

class RentVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

        @IBOutlet weak var collectionVC: UICollectionView!
    
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
      var property_pic = [String]()
      var title_lbl = [String]()
    
    var picturesArry1 = [String]()
       var picturesArry2 = [[String]]()
    
      var priceArr = [String]()
      var bedArr = [String]()
      var bathArr = [String]()
      var property_id = [String]()
      var purposeArr = [String]()
      var demandArr = [String]()
      var describeArr = [String]()
      
      var agencyImg_Arr = [String]()
      var agencyTitle_Arr = [String]()
    
    var agencyName_Arr = [String]()
    var agencyEmail_Arr = [String]()
    var agencyPhn_Arr = [String]()
    var agencyMob_Arr = [String]()
    
    var offsetSize = 0
    var maxOffsetSize = 0
    
    @IBAction func nextPage(_ sender: Any) {
        loading.startAnimating()
        if offsetSize >= maxOffsetSize{
                  offsetSize = 0
              }else{
                  offsetSize = offsetSize + 10
              }
              clearArr()
              DataLoader()
    }
    
    
    @IBAction func previousPage(_ sender: Any) {
        loading.startAnimating()
        if offsetSize<=0{
                   offsetSize=0
               }else{
                   offsetSize = offsetSize - 10
               }
               
               clearArr()
               DataLoader()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loading.startAnimating()
        clearArr()
        
        DataLoader()
        
        collectionVC.delegate = self
        collectionVC.dataSource = self
        
        
    }
    
    
       func clearArr(){
         property_pic.removeAll()
         title_lbl.removeAll()
         agencyImg_Arr.removeAll()
         agencyTitle_Arr.removeAll()
         describeArr.removeAll()
         demandArr.removeAll()
         purposeArr.removeAll()
         property_id.removeAll()
         bathArr.removeAll()
         bedArr.removeAll()
         priceArr.removeAll()
         agencyName_Arr.removeAll()
         agencyEmail_Arr.removeAll()
         agencyPhn_Arr.removeAll()
         agencyMob_Arr.removeAll()
        
         collectionVC.reloadData()
     }
    
    //////////////////////////////////
    
    func DataLoader()
        {

            let networking = Networking(baseURL: "http://server.emlakzone.com/public/api/v1/search")
                networking.get("/properties?purpose=rent&size=10&offset=" + "\(offsetSize)") { result in
                   switch result {
                   case .success(let response):
                    let json = JSON(response.dictionaryBody)
                   // print(json)
                    
                    let propeties = json["result"]["properties"].arrayValue
                    let propetiesCount = json["result"]["properties_count"].doubleValue
                                
                                    self.maxOffsetSize = Int(propetiesCount)
                    
//                    print(Int(propetiesCount))
                    
                   
                                for propeties in propeties{
                                   // print(propeties.count)
                                    let title = propeties["title"]["en"].stringValue
                                    self.title_lbl.append(title)
                                    
                                  
                                    let price = propeties["originalPrice"].stringValue
                                    self.priceArr.append(price)
                                    //print(price.count)
                                    
                                      let propertyId = propeties["propertyId"].stringValue
                                      self.property_id.append(propertyId)
                         
                                      let baths = propeties["baths"].stringValue
                                      self.bathArr.append(baths)

                                      let beds = propeties["beds"].stringValue
                                      self.bedArr.append(beds)

                                      let purpose = propeties["purpose"].stringValue
                                      self.purposeArr.append(purpose)
                                    
                                      let demand = propeties["demand"].stringValue
                                      self.demandArr.append(demand)
                                      
                                      let describe = propeties["description"]["en"].stringValue
                                      self.describeArr.append(describe)
                                    
                                    
                                    let agencyImg = propeties["agency"]["guid"].stringValue
                        if propeties["agency"]["guid"].stringValue == "https://server.emlakzone.com/public/img/default-thumb.png"{
                                                       //print("correct")
                                                       self.agencyImg_Arr.append("http://server.emlakzone.com/public/img/default-thumb.png")
                                                       
                                                   }else{
                                                       self.agencyImg_Arr.append("http:" + agencyImg)
                                                   }
                                    
                                    let agencyName = propeties["agency"]["title"]["en"].stringValue
                                    self.agencyTitle_Arr.append(agencyName)
                                    
                                    
                                    
                                    
                                    

                                    let propertContact = propeties["property_contacts"].arrayValue
                                    
                                    for propertContact in propertContact{
                                        
                                        let agencyName = propertContact["contactName"].stringValue
                                        self.agencyName_Arr.append(agencyName)
                                        
                                        let agencyEmail = propertContact["contactEmail"].stringValue
                                        self.agencyEmail_Arr.append(agencyEmail)
                                        
                                        let agencyPhn = propertContact["contactPhone"].stringValue
                                        self.agencyPhn_Arr.append(agencyPhn)
                                        
                                        let agencyMob = propertContact["contactMobile"].stringValue
                                        self.agencyMob_Arr.append(agencyMob)

                                        
                                    }
                                 
                                    
                                    
                      
                                    self.collectionVC.reloadData()
                                }
                                
                           
                                
                                
                                      for propeties in propeties{
                                                // print(propeties)
                                                let img = propeties["featured_image"].stringValue
                                                
                                                self.property_pic.append("http:" + img)
                                      
                                        
                                        
                                        let imagesSet = propeties["images"].arrayValue
                                                    
                                                    for imagesSet in imagesSet{
                                                       let imgx = imagesSet["guid"].stringValue
                                                        self.picturesArry1.append("http:" + imgx)
                                                        
                                                        
                                                    }
                                                    self.picturesArry2.append(self.picturesArry1)
                                                    
                                                    self.picturesArry1.removeAll()
                                                    
                                                    print(self.picturesArry2.count)
                                                    
                                                   
                                                    self.collectionVC.reloadData()
                                        
                                        
                                        
                                             }
                                
                               case .failure(let response):
                                   // Handle error
                                print (response)
                                print("internet issueee???")
                               }
                            
                            }
                        
                        
                    }
                         
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return title_lbl.count
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionVC.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
            // Do any custom modifications you your cell, referencing the outlets you defined in the Custom cell file.
  
            
            cell.title.text = (title_lbl[indexPath.row])
            
            
            Alamofire.request(self.property_pic[indexPath.row], method: .get).responseImage { response in
                         guard let Image = response.result.value else {
                             // Handle error
                             return
                         }
                         // Do stuff with your image
                         cell.image.image = Image
                
                DispatchQueue.main.async {
                                 
                                  self.loading.stopAnimating()
                              }

                     }
            

            return cell
        }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
          if (kind == UICollectionView.elementKindSectionFooter) {
              let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CartFooterCollectionReusableView", for: indexPath)
              
              

              
              // Customize footerView here
              return footerView
          } else if (kind == UICollectionView.elementKindSectionHeader) {
              let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CartHeaderCollectionReusableView", for: indexPath)
              
           
              // Customize headerView here
              return headerView
          }
          fatalError()
      }
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
              let vc = storyboard?.instantiateViewController(withIdentifier: "DataVC") as? DataVC
               
        vc?.pathArray = picturesArry2[indexPath.row]
        
                     vc?.titleimg =  property_pic[indexPath.row]
                     vc?.titlename = title_lbl[indexPath.row]
                     vc?.price = priceArr[indexPath.row]
                     vc?.bed = bedArr[indexPath.row]
                     vc?.bath = bathArr[indexPath.row]
                     vc?.pid = property_id[indexPath.row]
                     vc?.purpos = purposeArr[indexPath.row]
                     vc?.demand = demandArr[indexPath.row]
                     vc?.property_description = describeArr[indexPath.row]
                     
                     vc?.agencyImg = agencyImg_Arr[indexPath.row]
                     vc?.agencyTitl = agencyTitle_Arr[indexPath.row]
        
        vc?.agencyName = agencyName_Arr[indexPath.row]
                   vc?.agencyEmail = agencyEmail_Arr[indexPath.row]
                   vc?.agencyPhn = agencyPhn_Arr[indexPath.row]
                   vc?.agencyMob = agencyMob_Arr[indexPath.row]
              
             
             
              self.navigationController?.pushViewController(vc!, animated: true)
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



extension RentVC: UICollectionViewDelegateFlowLayout{
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
  }
  
  
  
  
          func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
             
              let bounds = collectionView.bounds
              
              return CGSize(width: bounds.width/2 - 10, height: bounds.height/4)
        
              
              
  //            let width  = (view.frame.width-20)/2
  //            return CGSize(width: width, height: width)
      
             // return CGSize(width: 200, height: 180)
          }
      
     
      
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          10
      }
    
}

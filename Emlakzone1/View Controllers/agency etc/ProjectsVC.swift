//
//  ProjectsVC.swift
//  Emlakzone1
//
//  Created by AL Rayyan Asif on 21/01/2020.
//  Copyright © 2020 AL Rayyan Asif. All rights reserved.
//

import UIKit
import Networking
import SwiftyJSON
import Alamofire
import AlamofireImage

class ProjectsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {

    @IBOutlet weak var collectionVC: UICollectionView!
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    
    
    var picturesArry1 = [String]()
    var picturesArry2 = [[String]]()
    
    var projImg_Arr = [String]()
    var devImg_Arr = [String]()
    var logo_Arr = [String]()
    
    var projName_Arr = [String]()
    
    var projId_Arr = [String]()
    var projOverview_Arr = [String]()
    var minPrice_Arr = [String]()
    var maxPrice_Arr = [String]()
    var projDemand_Arr = [String]()
    var projPurpose_Arr = [String]()
    
    var devName_Arr = [String]()
    var devId_Arr = [String]()
    var devMail_Arr = [String]()
    var devPhn_Arr = [String]()
    var devMob_Arr = [String]()
    
    
    
    
//    var property_pic = [String]()
//    var title_lbl = [String]()
//    var priceArr = [String]()
    
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
        
        loading.startAnimating()
        
        clearArr()
        
        DataLoader()
              
        collectionVC.delegate = self
        collectionVC.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    
    func clearArr(){
        
        projImg_Arr.removeAll()
        devImg_Arr.removeAll()
        logo_Arr.removeAll()
        projName_Arr.removeAll()
        projId_Arr.removeAll()
        projOverview_Arr.removeAll()
        minPrice_Arr.removeAll()
        maxPrice_Arr.removeAll()
        projDemand_Arr.removeAll()
        projPurpose_Arr.removeAll()
        devName_Arr.removeAll()
        devId_Arr.removeAll()
        devMail_Arr.removeAll()
        devPhn_Arr.removeAll()
        devMob_Arr.removeAll()
        picturesArry2.removeAll()
           
        collectionVC.reloadData()
       }
    
    
    
    
    func DataLoader(){

           let networking = Networking(baseURL: "http://server.emlakzone.com/public/api/v1/search")
               networking.get("/projects?cityName=&size=10&offset=" + "\(offsetSize)" + "&locationId=&minArea=&maxArea=&landAreaUnitId=&minPrice=&maxPrice=&purpose=&price=&area=&createDate=&hot=&videoCode=&photos=") { result in
                  switch result {
                  case .success(let response):
                   let json = JSON(response.dictionaryBody)
                  // print(json)
                   
                   let projects = json["result"]["projects"].arrayValue
                   
                   
                   let projectsCount = json["result"]["projects_count"].doubleValue
                   self.maxOffsetSize = Int(projectsCount)
                   
                  // print(propeties.count)
                   
                  // print("/projects?cityName=&size=10&offset=" + "\(self.offsetSize)")
                   
        
                     for projects in projects{
                        // print(propeties.count)
                         let projName = projects["title"]["en"].stringValue
                         self.projName_Arr.append(projName)
                        
                        let projId = projects["projectId"].stringValue
                        self.projId_Arr.append(projId)
                         
                        //print(title)
                       
                         let minPrice = projects["minPrice"].stringValue
                         self.minPrice_Arr.append(minPrice)
                         
                        let maxPrice = projects["maxPrice"].stringValue
                        self.maxPrice_Arr.append(maxPrice)
                        
                        let overview = projects["description"]["en"].stringValue
                        self.projOverview_Arr.append(overview)
                        
                        let demand = projects["demand"].stringValue
                        self.projDemand_Arr.append(demand)
                        
                        let purpose = projects["purpose"].stringValue
                        self.projPurpose_Arr.append(purpose)
                        
                        ///////////////////////////////////////////////////
                        
                        let devName = projects["developer"]["name"]["en"].stringValue
                        self.devName_Arr.append(devName)
                        
                        let email = projects["developer"]["email"].stringValue
                        self.devMail_Arr.append(email)
                        
                        let phn = projects["developer"]["phone"].stringValue
                        self.devPhn_Arr.append(phn)
                        
                        let mob = projects["developer"]["mobile"].stringValue
                        self.devMob_Arr.append(mob)
                        
                        let devId = projects["developer"]["developerId"].stringValue
                        self.devId_Arr.append(devId)
                        
                        let logo = projects["developer"]["logoObj"]["guid"].stringValue
                        self.logo_Arr.append(logo)
                     
                            if projects["developer"]["logoObj"]["guid"].stringValue == "https://server.emlakzone.com/public/img/default-thumb.png"{
                                self.logo_Arr.append("http://server.emlakzone.com/public/img/default-thumb.png")
                            }else{
                                self.logo_Arr.append("http:" + logo)
                            }
                        
                        
                        let devImg = projects["developer"]["guid"].stringValue
                        if projects["developer"]["guid"].stringValue == "https://server.emlakzone.com/public/img/default-thumb.png"{
                            self.devImg_Arr.append("http://server.emlakzone.com/public/img/default-thumb.png")
                        }else{
                            self.devImg_Arr.append("http:" + devImg)
                        }
                         
                         
                         
           
                         self.collectionVC.reloadData()
                     }
                   
                   
                         for projects in projects{
                                   // print(propeties)
                                   let img = projects["featured_image"].stringValue
                                   
                                   self.projImg_Arr.append("http:" + img)
                                   
                                   
                            
                            
                            
                            
                             let imagesSet = projects["images"].arrayValue
                                           
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
               return projName_Arr.count
           }
           
           func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
               let cell = collectionVC.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
               
               cell.title.text = (projName_Arr[indexPath.row])
               
               
               Alamofire.request(self.projImg_Arr[indexPath.row], method: .get).responseImage { response in
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
         
                 let vc = storyboard?.instantiateViewController(withIdentifier: "ProjectsDetailsVC") as? ProjectsDetailsVC
        
        
        vc?.pathArray = picturesArry2[indexPath.row]
        
        
        
        vc?.titleimg =  projImg_Arr[indexPath.row]
        vc?.titlename =  projName_Arr[indexPath.row]
        vc?.projId =  projId_Arr[indexPath.row]
        vc?.min_price =  minPrice_Arr[indexPath.row]
        vc?.max_price =  maxPrice_Arr[indexPath.row]
        vc?.overView =  projOverview_Arr[indexPath.row]
        vc?.demand =  projDemand_Arr[indexPath.row]
        vc?.purpose =  projPurpose_Arr[indexPath.row]
       
        ////////////////////////
        
        vc?.devId =  devId_Arr[indexPath.row]
        vc?.devName =  devName_Arr[indexPath.row]
        vc?.dev_mail =  devMail_Arr[indexPath.row]
        vc?.dev_phn =  devPhn_Arr[indexPath.row]
        vc?.dev_mob =  devMob_Arr[indexPath.row]
        
        vc?.devImg =  devImg_Arr[indexPath.row]
        vc?.dev_logo =  logo_Arr[indexPath.row]
        
        


        
        
        
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


extension ProjectsVC: UICollectionViewDelegateFlowLayout{
  
  
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

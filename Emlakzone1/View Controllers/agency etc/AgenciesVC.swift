//
//  AgenciesVC.swift
//  Emlakzone1
//
//  Created by AL Rayyan Asif on 22/01/2020.
//  Copyright © 2020 AL Rayyan Asif. All rights reserved.
//

import UIKit
import Networking
import SwiftyJSON
import Alamofire
import AlamofireImage

class AgenciesVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionVC: UICollectionView!
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    var property_pic = [String]()
    var titleArr = [String]()
    var nameArr = [String]()
    var mobArr = [String]()
    var phnArr = [String]()
    var emailArr = [String]()
    
    
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
        property_pic.removeAll()
        titleArr.removeAll()
        
        collectionVC.reloadData()
    }
    
    
        func DataLoader(){

               let networking = Networking(baseURL: "http://server.emlakzone.com/public/api/v1/search")
                   networking.get("/agencies?cityName=Istanbul&locationId=&size=10&offset=" + "\(offsetSize)" + "&demand=golden&orderBy=agencies.demand&order=desc") { result in
                      switch result {
                      case .success(let response):
                       let json = JSON(response.dictionaryBody)
                      // print(json)
                       
                       let agencies = json["result"]["agencies"].arrayValue
                       
                       let agenciesCount = json["result"]["agencies_count"].doubleValue
                       self.maxOffsetSize = Int(agenciesCount)
                       
                       //print(self.offsetSize)
                       
                      // print(propeties.count)
                       
            
                         for agencies in agencies{
                            // print(propeties.count)
                             let title = agencies["title"]["en"].stringValue
                             self.titleArr.append(title)
                            
                            let name = agencies["user"]["name"]["en"].stringValue
                            self.nameArr.append(name)
                            
                            let phn = agencies["user"]["phone"].stringValue
                            self.phnArr.append(phn)
                            
                            let mob = agencies["user"]["mobile"].stringValue
                            self.mobArr.append(mob)
                            
                            let email = agencies["user"]["email"].stringValue
                            self.emailArr.append(email)
                             
                            //print(self.titleArr.count)
                          
                             self.collectionVC.reloadData()
                         }
                       
                       
                             for agencies in agencies{
                                       // print(propeties)
                                       let img = agencies["guid"].stringValue
                                
                                if agencies["guid"].stringValue == "https://server.emlakzone.com/public/img/default-thumb.png"{
                                    //print("correct")
                                    self.property_pic.append("http://server.emlakzone.com/public/img/default-thumb.png")
                                    
                                }else{
                                    self.property_pic.append("http:" + img)
                                }
                                
                                       
                                       
                                       
                                        //print("http:" + img)
                     
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
                   return titleArr.count
               }
               
               func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                   let cell = collectionVC.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
                   
                   cell.title.text = (titleArr[indexPath.row])
                   
                   
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
             
                     let vc = storyboard?.instantiateViewController(withIdentifier: "AgenciesDetailsVC") as? AgenciesDetailsVC
                     vc?.titleimg =  property_pic[indexPath.row]
             vc?.titlename =  titleArr[indexPath.row]
             vc?.personName =  nameArr[indexPath.row]
            vc?.email =  emailArr[indexPath.row]
            vc?.phn =  phnArr[indexPath.row]
            vc?.mob =  mobArr[indexPath.row]
            
 
                    
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



extension AgenciesVC: UICollectionViewDelegateFlowLayout{
  
  
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

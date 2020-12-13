//
//  WorkersVc\C.swift
//  Emlakzone1
//
//  Created by AL Rayyan Asif on 26/01/2020.
//  Copyright © 2020 AL Rayyan Asif. All rights reserved.
//

import UIKit
import Networking
import SwiftyJSON
import Alamofire
import AlamofireImage

class WorkersVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionVC: UICollectionView!
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    
    var images_Arr = [String]()
    var titles_Arr = [String]()
    var id_Arr = [String]()
    var address_Arr = [String]()
    var city_Arr = [String]()
    var location_Arr = [String]()
    var job_Arr = [String]()
    var phone_Arr = [String]()
    
    
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
    
        images_Arr.removeAll()
        titles_Arr.removeAll()
        id_Arr.removeAll()
        address_Arr.removeAll()
        city_Arr.removeAll()
        location_Arr.removeAll()
        job_Arr.removeAll()
        phone_Arr.removeAll()
         
         collectionVC.reloadData()
     }
    
    
    
    
            func DataLoader(){

                   let networking = Networking(baseURL: "http://server.emlakzone.com/public/api/v1/search")
                       networking.get("/workers?cityName=Istanbul&size=10&locationId=&order=desc") { result in
                          switch result {
                          case .success(let response):
                           let json = JSON(response.dictionaryBody)
                          // print(json)
                           
                           let workers = json["result"]["workers"].arrayValue
                           
                           
                           let workersCount = json["result"]["workers_count"].doubleValue
                                         
                                             self.maxOffsetSize = Int(workersCount)
                           
                          // print(propeties.count)
                           
                
                             for workers in workers{
                                // print(propeties.count)
                                 let title = workers["name"]["en"].stringValue
                                 self.titles_Arr.append(title)
                                 
                                let address = workers["address"]["en"].stringValue
                                self.address_Arr.append(address)
                                
                                let profession = workers["profession"]["en"].stringValue
                                self.job_Arr.append(profession)
                                
                                let mobile = workers["mobile"].stringValue
                                self.phone_Arr.append(mobile)
                                
                                let workerId = workers["workerId"].stringValue
                                self.id_Arr.append(workerId)
                                
                                let city = workers["city"]["name"]["en"].stringValue
                                self.city_Arr.append(city)
                                
                            let location = workers["location"]["name"]["en"].stringValue
                                self.location_Arr.append(location)
                                
                                
                                
                                
                               
                             
                                 
                   
                                 self.collectionVC.reloadData()
                             }
                           
                           
                         for workers in workers{
                                   // print(propeties)
                                   let img = workers["featured_image"].stringValue
                                   
                                   self.images_Arr.append("http:" + img)
                                   
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
                       return titles_Arr.count
                   }
                   
                   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                       let cell = collectionVC.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
                       
                       cell.title.text = (titles_Arr[indexPath.row])
                       
                       
                       Alamofire.request(self.images_Arr[indexPath.row], method: .get).responseImage { response in
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
                 
                         let vc = storyboard?.instantiateViewController(withIdentifier: "WorkerDetailsVC") as? WorkerDetailsVC
                         vc?.titleimg =  images_Arr[indexPath.row]
                         vc?.titlename = titles_Arr[indexPath.row]
                         vc?.address =  address_Arr[indexPath.row]
                         vc?.id = id_Arr[indexPath.row]
                         vc?.phn =  phone_Arr[indexPath.row]
                         vc?.job =  job_Arr[indexPath.row]
                         vc?.location =  location_Arr[indexPath.row]
                         vc?.city =  city_Arr[indexPath.row]
                
                
                
                     
                        
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



extension WorkersVC: UICollectionViewDelegateFlowLayout{
  
  
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

//
//  agencyVC.swift
//  Emlakzone1
//
//  Created by AL Rayyan Asif on 21/01/2020.
//  Copyright © 2020 AL Rayyan Asif. All rights reserved.
//

import UIKit

class agencyVC: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
              setupSegmentedControl()
              updateView()

        // Do any additional setup after loading the view.
    }
    

    
       // Created Segment Controller with name and index
       
       private func setupSegmentedControl(){
           // Configure Segmented Control
             segmentedControl.removeAllSegments()
           segmentedControl.insertSegment(withTitle: "PROJECTS", at: 0, animated: false)
             segmentedControl.insertSegment(withTitle: "AGENCY", at: 1, animated: false)
             segmentedControl.insertSegment(withTitle: "WORKERS", at: 2, animated: false)
             segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)

             // Select First Segment
             segmentedControl.selectedSegmentIndex = 0
       }
       @objc func selectionDidChange(_ sender: UISegmentedControl) {
           updateView()
       }
       
       // Calling the ViewController from storyboard idntifiers
       
       private lazy var ProjectsVC: ProjectsVC = {
           // Load Storyboard
           let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

           // Instantiate View Controller
           var viewController = storyboard.instantiateViewController(withIdentifier: "ProjectsVC") as! ProjectsVC

           // Add View Controller as Child View Controller
           self.add(asChildViewController: viewController)

           return viewController
       }()
       private lazy var AgenciesVC: AgenciesVC = {
           // Load Storyboard
           let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

           // Instantiate View Controller
           var viewController = storyboard.instantiateViewController(withIdentifier: "AgenciesVC") as! AgenciesVC

           // Add View Controller as Child View Controller
           self.add(asChildViewController: viewController)

           return viewController
       }()
       private lazy var WorkersVC: WorkersVC = {
             // Load Storyboard
             let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

             // Instantiate View Controller
             var viewController = storyboard.instantiateViewController(withIdentifier: "WorkersVC") as! WorkersVC

             // Add View Controller as Child View Controller
             self.add(asChildViewController: viewController)

             return viewController
         }()
       
       
       
       // Add Subview Function
       
       
       private func add(asChildViewController viewController: UIViewController) {
           // Add Child View Controller
           addChild(viewController)

           // Add Child View as Subview
           view.addSubview(viewController.view)

           // Configure Child View
           viewController.view.frame = view.bounds
           viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

           // Notify Child View Controller
           viewController.didMove(toParent: self)
       }
       
       
       //Remove Subview Function
       
       private func remove(asChildViewController viewController: UIViewController) {
           // Notify Child View Controller
           viewController.willMove(toParent: nil)

           // Remove Child View From Superview
           viewController.view.removeFromSuperview()

           // Notify Child View Controller
           viewController.removeFromParent()
       }
       
       
       //Updating the view
       //Whenever SegmentControoler is clicked
       
       private func updateView() {
           if segmentedControl.selectedSegmentIndex == 0 {
               remove(asChildViewController: AgenciesVC)
               remove(asChildViewController: WorkersVC)
               add(asChildViewController: ProjectsVC)
           }
           else if segmentedControl.selectedSegmentIndex == 1 {
                     remove(asChildViewController: ProjectsVC)
                     remove(asChildViewController: WorkersVC)
                     add(asChildViewController: AgenciesVC)
                 }else {
               remove(asChildViewController: WorkersVC)
               remove(asChildViewController: ProjectsVC)
               add(asChildViewController: WorkersVC)
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

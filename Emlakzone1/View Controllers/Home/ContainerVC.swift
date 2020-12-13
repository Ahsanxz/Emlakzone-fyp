//
//  SecondViewController.swift
//  Emlakzone1
//
//  Created by AL Rayyan Asif on 30/12/2019.
//  Copyright © 2019 AL Rayyan Asif. All rights reserved.
//

import UIKit
class ContainerVC: UIViewController {
  
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

     let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
       let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
           
       leftSwipe.direction = .left
       rightSwipe.direction = .right

       view.addGestureRecognizer(leftSwipe)
       view.addGestureRecognizer(rightSwipe)
        
       setupSegmentedControl()
       updateView()
        
        
        

    }
    
     // // // // // // // // // /// // /// /// /// /// ///
    
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
            
        if (sender.direction == .left) {
                print("Swipe Left")
            updateView()
            
        }
            
        if (sender.direction == .right) {
            print("Swipe Right")
            updateView()
         
        }
    }
    

    
    // Created Segment Controller with name and index
    
    private func setupSegmentedControl(){
        // Configure Segmented Control
          segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "HOME", at: 0, animated: false)
          segmentedControl.insertSegment(withTitle: "PLOTS", at: 1, animated: false)
          segmentedControl.insertSegment(withTitle: "RENTS", at: 2, animated: false)
          segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)

          // Select First Segment
          segmentedControl.selectedSegmentIndex = 0
    }
    @objc func selectionDidChange(_ sender: UISegmentedControl) {
        updateView()
    }
    
    // Calling the ViewController from storyboard idntifiers
    
    private lazy var HomeVC: HomeVC = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)

        return viewController
    }()
    private lazy var PlotVC: PlotVC = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "PlotVC") as! PlotVC

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)

        return viewController
    }()
    private lazy var RentVC: RentVC = {
          // Load Storyboard
          let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

          // Instantiate View Controller
          var viewController = storyboard.instantiateViewController(withIdentifier: "RentVC") as! RentVC

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
            remove(asChildViewController: PlotVC)
            remove(asChildViewController: RentVC)
            add(asChildViewController: HomeVC)
        }
        else if segmentedControl.selectedSegmentIndex == 1 {
                  remove(asChildViewController: HomeVC)
                  remove(asChildViewController: RentVC)
                  add(asChildViewController: PlotVC)
              }else {
            remove(asChildViewController: RentVC)
            remove(asChildViewController: HomeVC)
            add(asChildViewController: RentVC)
        }
    }



}




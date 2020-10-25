//
//  CalendarViewController.swift
//  Plany
//
//  Created by Gianluca Dubioso on 22/10/2020.
//

import UIKit

class CalendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButtonEvent = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEvent))
       //let play = UIBarButtonItem(title: "Calendar", style: .plain, target: self, action: #selector(addTapped))

       
       navigationItem.backBarButtonItem?.title?.append("Calendar")
    
        
    
        navigationItem.title = String("Calendar")

       
       // navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: hello)]
        
        navigationItem.rightBarButtonItem =  addButtonEvent
       // navigationItem.leftBarButtonItem =
       
        
       // navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(addTapped))
        
        // Do any additional setup after loading the view.
        //setupNavigation(barTintColor: .white)
      //  setupRightButton(target: self, action: #selector(addTapped), imageName: "ProfileImage")
    }
    
    @objc func addTapped () {
        navigationController?.popViewController(animated: true)
        // dismiss(animated: true, completion: nil)
    }
    @objc func addEvent (){
        
    }
}

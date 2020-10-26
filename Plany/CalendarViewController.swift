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
        
        navigationItem.rightBarButtonItem =  addButtonEvent
    }
    
  @objc func addTapped () {
        navigationController?.popViewController(animated: true)
    }
  @objc func addEvent (){
        
    }
}

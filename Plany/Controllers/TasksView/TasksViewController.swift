//
//  TasksViewController.swift
//  Plany
//
//  Created by Gianluca Dubioso on 12/12/20.
//

import UIKit
import SkeletonView

class TasksViewController: UIViewController {
  
  @IBOutlet var inputTextField: UITextField!
  @IBOutlet var tableView: UITableView!
  
  var omniItem: [Section] = []
  
  var sharedArrayTask: [Task] = []
  
  var isDone: [Bool] = UserDefaults.standard.object(forKey: "isDone")
    as? [Bool] ?? [false]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.dataSource = self
    self.tableView.delegate = self
    load()
    mio()
      DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
          
      })
    //  self.tableView.stopSkeletonAnimation()
          //            self.tableView.hideSkeleton()
      //self.tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
      //disableSkeleton(view: self.tableView)
      tableView.reloadData()
  }
    
    override func viewDidAppear(_ animated: Bool) {
        load()
     //   tableView.isSkeletonable = true
       // enableSkeleton(view: tableView)
        
    }
//    func enableSkeleton(view: UIView? = nil) {
//   
//        view?.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .silver),
//                                           animation: nil,
//                                           transition: .crossDissolve(0.25))
//    }
//    
//    func disableSkeleton(view: UIView? = nil) {
//        if let view = view {
//    
//            view.stopSkeletonAnimation()
//            view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
//        }
//    }
  //MARK: ViewController Action
  
  @IBAction func addButton_clicked(_ sender: UIButton) {
    
    if inputTextField.text == "" {
      
      alertPresent(textTitle: "Hey Dude",
                   mexText: "Text Field can't be Empty",
                   actTitle: "Cancel")
    
    } else {
    
      guard let text = self.inputTextField.text else {
   
        return
  }
    if omniItem.isEmpty {
        omniItem.append(Section(name: "To Do", tasks: [
                            Task(taskName: text,
                                 shared: false, isDone: false)]))
      } else {
        
        omniItem[0].tasks.append(
              Task(taskName: text,
                shared: false, isDone: false))
        
      }
      save()
      self.tableView.reloadData()
    }
    inputTextField.text = ""
  }
  
  // Edit Button
  @objc func editButton_clicked() {
    
    self.tableView.setEditing(
      !self.tableView.isEditing,
      animated: true)
  }
  
  @objc func mio(){
    let editButton = UIButton(
      frame: CGRect(x: 0, y: 0,
                    width: 50, height: 32))
    
    editButton.setTitle(
      "Edit", for: .normal)
   
    editButton.setTitleColor(
      .white, for: .normal)
    
    editButton.addTarget(
      self, action: #selector(
        editButton_clicked),
          for: .touchUpInside)
    
    inputTextField.layer.cornerRadius = inputTextField.frame.height/2
    inputTextField.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
    inputTextField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(
                                   customView: editButton)
  }
  
  func load() {
    if let loadData = UserDefaults.standard.value(
                      forKey: "abitudine") as? Data {
      
      let decoder = JSONDecoder()
      let myArray = try? decoder.decode(
          [Section].self, from: loadData)
      
      omniItem = myArray!
     
    }
  }
  
  func save() {
    let encoder = JSONEncoder()
   
    let myArray = try? encoder.encode(omniItem)
   
    UserDefaults.standard.set(
      myArray, forKey: "abitudine")
  }
  
  func save2() {
   
    let encoder = JSONEncoder()
    let myArray = try? encoder.encode(sharedArrayTask)
   
    UserDefaults.standard.set(
      myArray, forKey: "shared")
      
      NotificationCenter.default.post(
              name: NSNotification.Name(
                rawValue: "updateArrayShared"),
                 object: nil)
  }
}
//MARK: TableView DataSource
extension TasksViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                 heightForHeaderInSection section: Int) -> CGFloat {
    
    if omniItem[section].tasks.isEmpty {
      return 0
    } else {
      return 36
    }
  }
  
  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath)
  {
    tableView.deselectRow(at: indexPath,
                          animated: true)
    
    var text = omniItem[indexPath.section].tasks[indexPath.row]
   
    if omniItem.count == 1  {
      text.isDone = true
      omniItem.append(Section(name: "Done", tasks: [text]))
      omniItem[0].tasks.remove(at: indexPath.row)
      save()
      self.tableView.reloadData()
      
    } else if omniItem[indexPath.section].name != "Done"{
      text.isDone = true
      omniItem[1].tasks.append(text)
      omniItem[0].tasks.remove(at: indexPath.row)
      save()
      
      self.tableView.reloadData()
    }
   
    if omniItem.count == 1  {
      text.isDone = false
      omniItem.append(Section(name: "To Do", tasks: [text]))
      omniItem[1].tasks.remove(at: indexPath.row)
      save()
      self.tableView.reloadData()
    
    } else if omniItem[indexPath.section].name != "To Do"{
      text.isDone = false
      omniItem[0].tasks.append(text)
      omniItem[1].tasks.remove(at: indexPath.row)
      save()
      
      self.tableView.reloadData()
    }
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let label = UILabel()
    label.text = omniItem[section].name
    label.textColor = .white
    label.textAlignment = .center
    label.backgroundColor = #colorLiteral(red: 0.173355639, green: 0.1415168047, blue: 0.1407646239, alpha: 1)
    label.isHidden = omniItem[section].tasks.isEmpty
    
    return label
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
      return omniItem.count
  }
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    
    return omniItem[section].tasks.count
    
  }
  //MARK: Reusable Cell
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(
        withIdentifier: "taskCell", for: indexPath)
    
    cell.tintColor = UIColor.black
    cell.textLabel?.text = omniItem[indexPath.section].tasks[indexPath.row].taskName
    
         if omniItem[indexPath.section].name != "To Do" {
          cell.accessoryType = .checkmark
        } else {
          cell.accessoryType = .none
        }
      
      tableView.isSkeletonable = true
    return cell
  }
}
//MARK: TableView Delegate
extension TasksViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView,
                 editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .none
    
  }
  
  func tableView(_ tableView: UITableView,
                 shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
  
    return false
    
  }
  
  func tableView(_ tableView: UITableView,
                 moveRowAt sourceIndexPath: IndexPath,
                 to destinationIndexPath: IndexPath) {
    
    self.omniItem.swapAt(
      sourceIndexPath.row,
      destinationIndexPath.row)
    
  }
  
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    //MARK: DELETE ACTION
  
    let action = UITableViewRowAction.init(
      style: .normal,
      title: "Delete")
    { (action, index) in
      print("🤖 Delete", index.row)
      self.omniItem[indexPath.section].tasks.remove(at: index.row)
      
      tableView.deleteRows(at: [index], with: .right)
      
      self.save()
      self.tableView.reloadData()
    }
    action.backgroundColor = #colorLiteral(red: 0.9267585874, green: 0.367726624, blue: 0.3804723024, alpha: 1)
    
    //MARK: SHARE ACTION
    
    let actionShare = UITableViewRowAction.init(
      style: .normal,
      title: "Share")
    { (action, index) in
      
      // Leggi array esistente da UserDefaults
      var stored: [Task] = []
      if let data = UserDefaults.standard.data(forKey: "shared"),
         let decoded = try? JSONDecoder().decode([Task].self, from: data) {
        stored = decoded
      }
      
      // Aggiungi Task completo con isDone impostato
      var task = self.omniItem[indexPath.section].tasks[index.row]
      task.shared = true
      stored.append(task)
      
      // Salva array completo
      if let encoded = try? JSONEncoder().encode(stored) {
        UserDefaults.standard.set(encoded, forKey: "shared")
      }
      
      // Notifica la Home del nuovo Task condiviso
      NotificationCenter.default.post(
        name: NSNotification.Name("sharedUpdated"),
        object: task)
      
      self.omniItem[indexPath.section].tasks.remove(
        at: index.row)
      tableView.deleteRows(
        at: [index], with: .right)
      
      self.save()
      self.tableView.reloadData()
    
      print("🤖 Share", index.row)
    }
    actionShare.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
    
    return [action, actionShare]
  }
}

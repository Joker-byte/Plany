//
//  TasksViewController.swift
//  Plany
//
//  Created by Gianluca Dubioso on 12/12/20.
//

import UIKit

class TasksViewController: UIViewController {
  
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var tableView: UITableView!

  var omniItem: [Section] = []
  
  var sharedArrayTask: [Section] = []
  
//  var newSharedArrey: [String] = UserDefaults.standard.object(forKey: "SharedName")as? [String] ?? [""]
    
  var isDone: [Bool] = UserDefaults.standard.object(forKey: "isDone")
    as? [Bool] ?? [false, false, false, false, false,false,
                   false, false, false, false,false, false,
                   false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.tableView.dataSource = self
            self.tableView.delegate = self
      load()
      mio()
    }
//MARK: ViewController Action

  @IBAction func addButton_clicked(_ sender: UIButton) {
   
  if inputTextField.text == "" {
       alertPresent(textTitle: "Hey Dude", mexText: "Text Field can't be Empty", actTitle: "Cancel")
       } else {
        guard let text = self.inputTextField.text else {
          return
        }
        if omniItem.isEmpty {
           omniItem.append(Section(name: "To Do", tasks: [
                                    Task(taskName: text, shared: false, isDone: false)]))
            save()
        } else {
          omniItem[0].tasks.append(Task(taskName: text, shared: false, isDone: false))
              save()
        }
          self.tableView.reloadData()
        }
   inputTextField.text = ""
  }
// Edit Button
  @objc func editButton_clicked() {
      self.tableView.setEditing(!self.tableView.isEditing, animated: true)
    }
  
  @objc func mio(){
   let editButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 32))
    
    editButton.setTitle("Edit", for: .normal)
    editButton.setTitleColor(.white, for: .normal)
    editButton.addTarget(self, action: #selector(editButton_clicked), for: .touchUpInside)
  
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editButton)
    
    inputTextField.layer.cornerRadius = inputTextField.frame.height/2
    inputTextField.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
    inputTextField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
  }
  
  func load() {
          if let loadData = UserDefaults.standard.value(forKey: "abitudine") as? Data {
          let decoder = JSONDecoder()
          let myArray = try? decoder.decode([Section].self, from: loadData)
              omniItem = myArray!
             tableView.reloadData()
          }
      }
  
  func save() {
          let encoder = JSONEncoder()
          let myArray = try? encoder.encode(omniItem)
          UserDefaults.standard.set(myArray, forKey: "abitudine")
      }
  
  func save2() {
          let encoder = JSONEncoder()
    let myArray = try? encoder.encode(sharedArrayTask)
          UserDefaults.standard.set(myArray, forKey: "shared")
      }
}
//MARK: TableView DataSource
extension TasksViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      return 36
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      let label = UILabel()
    label.text = omniItem[section].name
      label.textColor = .white
      label.textAlignment = .center
      label.backgroundColor = #colorLiteral(red: 0.173355639, green: 0.1415168047, blue: 0.1407646239, alpha: 1)
      return label
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    
    
    if isDone[indexPath.row]{
      
      isDone[indexPath.row] = false
      tableView.cellForRow(at: indexPath)?.accessoryType = .none
          }else{
      isDone[indexPath.row] = true
      tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
  }

func numberOfSections(in tableView: UITableView) -> Int {
  return omniItem.count
  }

 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  //  omniItem[section].collapsed ? 0 : omniItem[section].tasks.count
  return  omniItem[section].tasks.count
  }
//MARK: Reusable Cell
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

 let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
     cell.tintColor = UIColor.black
     cell.textLabel?.text = omniItem[indexPath.section].tasks[indexPath.row].taskName
    
    
    if isDone[indexPath.row]{
      cell.accessoryType = .checkmark
//      omniItem[indexPath.section].tasks[indexPath.row].shared = true
    } else {
      cell.accessoryType = .none
//      omniItem[indexPath.section].tasks[indexPath.row].shared = false
    }
    return cell
  }
}
//MARK: TableView Delegate
extension TasksViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
      return .none
  }

  func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
      return false
  }

  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//      print("🤖", sourceIndexPath.row, destinationIndexPath.row)
//      print(array)
//      self.array.swapAt(sourceIndexPath.row, destinationIndexPath.row)
//      print(array)
//      UserDefaults.standard.set(array, forKey: "myKey")

  }
  
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//MARK: DELETE ACTION
      let action = UITableViewRowAction.init(
          style: .normal,
          title: "Delete")
      { (action, index) in
          print("🤖 Delete", index.row)
        self.omniItem[0].tasks.remove(at: index.row)
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
      
      self.sharedArrayTask.append(self.omniItem[indexPath.section])
      
      self.sharedArrayTask.append(self.omniItem[indexPath.section])
      
      self.omniItem[0].tasks.remove(at: index.row)
            tableView.deleteRows(at: [index], with: .right)
      
      self.save()
      self.save2()
//      UserDefaults.standard.set(self.newSharedArrey, forKey: "SharedName")
//      NotificationCenter.default.post(
//        name: NSNotification.Name(
//          rawValue: "updateArrayShared"),
//            object: nil)
      print("🤖 Share", index.row)
      }
   actionShare.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)

      return [action, actionShare]
  }
}

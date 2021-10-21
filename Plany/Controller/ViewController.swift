//  ViewController.swift
//  Plany
//  Created by Gianluca Dubioso on 22/10/2020.

import UIKit
<<<<<<< HEAD
import AudioToolbox
=======

>>>>>>> try
class ViewController: UIViewController {
 
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var addHomeworkButton: UIButton!
  @IBOutlet weak var homeworkLabel: UILabel!
  @IBOutlet weak var tasksLabel: UILabel!
  @IBOutlet weak var calendar: UIImageView!
  @IBOutlet weak var homeworkCollection: UICollectionView!
  @IBOutlet var sharedTable: UITableView!
<<<<<<< HEAD
<<<<<<< HEAD
  var longPressedEnabled: Bool!
  var datePicker: UIDatePicker! 
 
  var arrayDate: [String]  = UserDefaults.standard.object(
                                forKey: "DateText") as? [String] ?? []
  
  var arrayTime: [String] = UserDefaults.standard.object(
                              forKey: "DateTime") as? [String] ?? []
  
  var arrayTitle: [String] = UserDefaults.standard.object(
                                forKey: "TitleText") as? [String] ?? []
  
  var arrayText: [String] = UserDefaults.standard.object(
                              forKey: "TagText") as? [String] ?? []
  
  var sharedArray: [String] = UserDefaults.standard.object(
                                forKey: "shared") as? [String] ?? []
  
  var isDone: [Bool] = UserDefaults.standard.object(forKey: "isDone") as? [Bool] ?? [false, false, false, false, false,false, false, false, false, false,false, false, false, false, false]
  
  //MARK: ViewDidLoad
=======
=======

  var arrayDate: [String] = []
  var arrayTime: [String] = []
  var arrayTitle: [String] = []
  var arrayText: [String] = []
  var sharedArray: [String] = []
>>>>>>> feature/refactor
  
  var isDone: [Bool] = UserDefaults.standard.object(forKey: "isDone") as? [Bool] ?? [false, false, false, false, false,false, false, false, false, false,false, false, false, false, false]
  
<<<<<<< HEAD
  var sharedArray: [Section] = []
//  var newSharedArrayView: [String] = UserDefaults.standard.object(forKey: "SharedName") as? [String] ?? ["Default"]
>>>>>>> try
=======
  //MARK: ViewDidLoad
>>>>>>> feature/refactor
  override func viewDidLoad() {
    super.viewDidLoad()
   
    self.homeworkCollection.delegate = self
    self.homeworkCollection.dataSource = self
    
    self.sharedTable.delegate = self
    self.sharedTable.dataSource = self
    
    setlayout()
    observerItems()
    userDefaultSet()
<<<<<<< HEAD
    recognizer()
//  recognizer2()
=======
>>>>>>> try
  }
  
    override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
<<<<<<< HEAD
    load()
  }
  
  func showTextEntryAlert(index: Int) {
      let title = NSLocalizedString("A Short Title is Best", comment: "")
      
      let message = NSLocalizedString("A message should be a short, complete sentence.", comment: "")
  
      let cancelButtonTitle = NSLocalizedString("Cancel", comment: "")
      let otherButtonTitle = NSLocalizedString("OK", comment: "")
      
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    alertController.addAction(UIAlertAction(title: "Change Date", style: .default, handler:{ _ in
      self.addTapped3()
    }))
      // Add the text field for text entry.
    alertController.addTextField { titlePlace in
      titlePlace.placeholder = "Insert New Title"

    }

    alertController.addTextField { textPlace in
     
      textPlace.placeholder = "Insert New Text"

//UserDefaults.standard.set(tagText, forKey: "TagText")
//MARK: DA LAVORARCI SUBITO
    
    }
      // Create the actions.
      let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { _ in
          print("The \"Text Entry\" alert's cancel action occurred.")
      }
      
    let otherAction = UIAlertAction(title: otherButtonTitle, style: .default) { _ in
   
      }
      // Add the actions.
      alertController.addAction(cancelAction)
      alertController.addAction(otherAction)
      
      present(alertController, animated: true, completion: nil)
  }
  
  //MARK: GESTURE
  func recognizer() {
  let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longTap(_:)))
    
    homeworkCollection.addGestureRecognizer(longPressGesture)
  }
  
  @objc func longTap(_ gesture: UIGestureRecognizer){

          switch(gesture.state) {
          case .began:
              guard let selectedIndexPath = homeworkCollection.indexPathForItem(at: gesture.location(in: homeworkCollection)) else {
                  return
              }
              homeworkCollection.beginInteractiveMovementForItem(at: selectedIndexPath)
              AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
          case .changed:
              homeworkCollection.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
          case .ended:
              homeworkCollection.endInteractiveMovement()
            //  doneBtn.isHidden = false
              longPressedEnabled = true
              self.homeworkCollection.reloadData()
          default:
              homeworkCollection.cancelInteractiveMovement()
          }
      }

 // MARK: Rewrite Array Retrived
  @objc func rewritingArrays(notification: NSNotification){

  guard let retrievedDate = UserDefaults.standard.string(
                  forKey: "DateText"),

        let  retrievedTime = UserDefaults.standard.string(
                  forKey: "DateTime"),

        let retrievedTitle = UserDefaults.standard.string(
                  forKey: "TitleText"),
        
        let retrievedText = UserDefaults.standard.string(
                  forKey: "TagText")  else {
      return
    }

    arrayDate.append(retrievedDate)
    arrayTime.append(retrievedTime)
    arrayTitle.append(retrievedTitle)
    arrayText.append(retrievedText)
=======
      load()
      
    //  observerForTable()
  }

 // MARK: Rewrite Array Retrived
  @objc func rewritingArrays(notification: NSNotification){

  guard let retrievedDate = UserDefaults.standard.string(
                  forKey: "DateText"),

        let  retrievedTime = UserDefaults.standard.string(
                  forKey: "DateTime"),

        let retrievedTitle = UserDefaults.standard.string(
                  forKey: "TitleText"),

        let retrievedText = UserDefaults.standard.string(
                  forKey: "TagText")  else {
      return
    }

    self.arrayDate.append(retrievedDate)
    self.arrayTime.append(retrievedTime)
    self.arrayTitle.append(retrievedTitle)
    self.arrayText.append(retrievedText)
>>>>>>> try

let index = IndexPath.init(
      item: self.arrayTitle.count-1,
                               section: 0)

self.homeworkCollection.insertItems(at: [index])

<<<<<<< HEAD
<<<<<<< HEAD
    UserDefaults.standard.set(arrayDate, forKey: "DateText")
    UserDefaults.standard.set(arrayTime, forKey: "DateTime")
    UserDefaults.standard.set(arrayTitle, forKey: "TitleText")
    UserDefaults.standard.set(arrayText, forKey: "TagText")
    }
  
  func removeCollection(index: Int){
    
    arrayDate.remove(at: index)
    arrayTime.remove(at: index)
    arrayTitle.remove(at: index)
    arrayText.remove(at: index)
    
    homeworkCollection.reloadData()

    UserDefaults.standard.set(arrayDate, forKey: "DateText")
    UserDefaults.standard.set(arrayTime, forKey: "DateTime")
    UserDefaults.standard.set(arrayTitle, forKey: "TitleText")
    UserDefaults.standard.set(arrayText, forKey: "TagText")
    
  }
=======
      UserDefaults.standard.set(self.arrayDate, forKey: "DateText")
      UserDefaults.standard.set(self.arrayTime, forKey: "DateTime")
=======
    UserDefaults.standard.set(self.arrayDate, forKey: "DateText")
    UserDefaults.standard.set(self.arrayTime, forKey: "DateTime")
>>>>>>> feature/refactor

    UserDefaults.standard.set(self.arrayTitle, forKey: "TitleText")
    UserDefaults.standard.set(self.arrayText, forKey: "TagText")
    }
>>>>>>> try
}
//MARK: COLLECTIONVIEW

extension ViewController : UICollectionViewDelegate {
<<<<<<< HEAD
<<<<<<< HEAD

  func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
          return true
  }
 
//MARK: Swap Collection
  func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    self.arrayDate.swapAt(sourceIndexPath.item, destinationIndexPath.item)
     self.arrayTime.swapAt(sourceIndexPath.item, destinationIndexPath.item)
     self.arrayTitle.swapAt(sourceIndexPath.item, destinationIndexPath.item)
     self.arrayText.swapAt(sourceIndexPath.item, destinationIndexPath.item)
    

    UserDefaults.standard.set(arrayDate, forKey: "DateText")
    UserDefaults.standard.set(arrayTime, forKey: "DateTime")
    UserDefaults.standard.set(arrayTitle, forKey: "TitleText")
    UserDefaults.standard.set(arrayText, forKey: "TagText")

    print("Start index :- \(sourceIndexPath.item)")
    print("End index :- \(destinationIndexPath.item)")
    
  }
  
func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 
  //MARK: Alert
  let alertCell = UIAlertController(
                   title: arrayDate[indexPath.item] + "\n" ,
                   message: arrayText[indexPath.item] ,
                   preferredStyle: .alert)
  
  alertCell.title?.append(arrayTitle[indexPath.item])
  
  alertCell.addAction(UIAlertAction(
                        title: "Edit",
                        style: .destructive,
                        handler: { _ in self.showTextEntryAlert(index: indexPath.item)}))
  
  alertCell.addAction(UIAlertAction(
                        title: "Remove",
                        style: .destructive,
                        handler:  { _ in
                          self.removeCollection(index: indexPath.item)
                        }))
  
=======
  
=======

>>>>>>> feature/refactor
func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 
  //MARK: Alert
  let alertCell = UIAlertController(
                   title: arrayDate[indexPath.row] + "\n" ,
                   message: arrayText[indexPath.row] ,
                   preferredStyle: .alert)
  
  alertCell.title?.append(arrayTitle[indexPath.row])
  alertCell.addAction(UIAlertAction(
                        title: "Edit",
                        style: .default,
                        handler:  nil))
>>>>>>> try
  alertCell.addAction(UIAlertAction(title: "Dismiss",
                                    style: .cancel,
                                    handler: nil))
 
  present(alertCell, animated: true, completion: nil)
  
<<<<<<< HEAD
<<<<<<< HEAD
  }
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   return self.arrayText.count
  }
}
//MARK: Cell DataSource
=======
  
=======
>>>>>>> feature/refactor
  }
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   return self.arrayText.count
  }
}
<<<<<<< HEAD
  
}
>>>>>>> try
=======
//MARK: Cell DataSource
>>>>>>> feature/refactor
extension ViewController :  UICollectionViewDataSource{

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell : CollectionViewCell = homeworkCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell

<<<<<<< HEAD
<<<<<<< HEAD
    cell.postTitleLabel.text = self.arrayTitle[indexPath.item]
    cell.postTime.text = self.arrayDate[indexPath.item]
    cell.postTimeHours.text = self.arrayTime[indexPath.item]
    cell.postText.text = self.arrayText[indexPath.item]

//MARK: GradientLayer
=======
     cell.postTitleLabel.text = self.arrayTitle[indexPath.row]
     cell.postTime.text = self.arrayDate[indexPath.row]
     cell.postTimeHours.text = self.arrayTime[indexPath.row]
     cell.postText.text = self.arrayText[indexPath.row]


>>>>>>> try
=======
    cell.postTitleLabel.text = self.arrayTitle[indexPath.row]
    cell.postTime.text = self.arrayDate[indexPath.row]
    cell.postTimeHours.text = self.arrayTime[indexPath.row]
    cell.postText.text = self.arrayText[indexPath.row]

//MARK: GradientLayer
>>>>>>> feature/refactor
   let gradientLayer = CAGradientLayer()
       gradientLayer.colors = [UIColor.init(cgColor: #colorLiteral(red: 0.173355639, green: 0.1415168047, blue: 0.1407646239, alpha: 1)).cgColor,
                               UIColor.init(cgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).cgColor]
       gradientLayer.locations = [0.0,1.0]
       gradientLayer.frame = cell.bounds
    
<<<<<<< HEAD
<<<<<<< HEAD
    //MARK: Cell Layer
=======
>>>>>>> try
=======
    //MARK: Cell Layer
>>>>>>> feature/refactor
    cell.clipsToBounds = true
    cell.layer.addSublayer(gradientLayer)
    cell.layer.insertSublayer(gradientLayer, at: 0)

    cell.layer.cornerRadius = 8
    cell.layer.borderWidth = 2
    cell.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
<<<<<<< HEAD
    return cell
=======

<<<<<<< HEAD
 return cell
>>>>>>> try
=======
    return cell
>>>>>>> feature/refactor
  }
}

extension ViewController{
<<<<<<< HEAD
  
<<<<<<< HEAD
  @objc func load() {
    
   if let loadData = UserDefaults.standard.value(forKey: "shared") as? Data {
      let decoder = JSONDecoder()
      let myArray = try? decoder.decode([String].self, from: loadData)
      // sharedArray = myArray!
      sharedArray.append(contentsOf: myArray!)
   
      UserDefaults.standard.set(sharedArray, forKey: "shared")
      sharedTable.reloadData()
        }
  }
  func save() {
          UserDefaults.standard.set(sharedArray, forKey: "shared")
      }
//MARK: Searchbar
=======
  func load() {
         
=======

  @objc func load() {

>>>>>>> feature/refactor
    if let loadData = UserDefaults.standard.value(forKey: "shared") as? Data {
       let decoder = JSONDecoder()
      let myArray = try? decoder.decode([String].self, from: loadData)
            sharedArray = myArray!
   
            sharedTable.reloadData()
        }
  }
  
<<<<<<< HEAD
//  func save() {
//          let encoder = JSONEncoder()
//    let myArray = try? encoder.encode(sharedArray)
//          UserDefaults.standard.set(myArray, forKey: "shared")
//      }

>>>>>>> try
=======
  func save() {
          let encoder = JSONEncoder()
    let myArray = try? encoder.encode(sharedArray)
          UserDefaults.standard.set(myArray, forKey: "shared")
      }
//MARK: Searchbar
>>>>>>> feature/refactor
  func updateSearchResults(for searchController: UISearchController) {
       guard let text = searchController.searchBar.text else { return }
       print(text)
   }
<<<<<<< HEAD
<<<<<<< HEAD
  //MARK: Layout
   func setlayout(){
    
=======
  
=======
  //MARK: Layout
>>>>>>> feature/refactor
   func setlayout(){
>>>>>>> try
      searchBar.layer.cornerRadius = 8
       UITextField.appearance(
         whenContainedInInstancesOf: [
           UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
 
     homeworkCollection.layer.cornerRadius = 5

     navigationItem.backButtonTitle = "Calendar"
     calendar.image = UIImage(named: "CalendarIcon")
  
     addHomeworkButton.frame = CGRect(x: 0, y: 0, width: 12, height: 12)
     addHomeworkButton.setImage(UIImage(named: "Add"), for: .normal)
     addHomeworkButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
  
   }
<<<<<<< HEAD
<<<<<<< HEAD
   //MARK: Observer
   func observerItems(){

  NotificationCenter.default.addObserver(self, selector: #selector(rewritingArrays),
                                           name: NSNotification.Name(rawValue: "updateArray"),
                                           object: nil)
=======
   
=======
   //MARK: Observer
>>>>>>> feature/refactor
   func observerItems(){

    NotificationCenter.default.addObserver(self, selector: #selector(rewritingArrays),
                                           name: NSNotification.Name(rawValue: "updateArray"),
                                           object: nil)
<<<<<<< HEAD
    
>>>>>>> try
=======
>>>>>>> feature/refactor
  
    NotificationCenter.default.addObserver(forName: NSNotification.Name("updateName"),
                                            object: nil, queue: .main) { (notification) in
       
       guard let nameNotification = notification.object as? String else {
         return
       }
       self.labelNavigation(textColor: .white, text: "Hello \n" + nameNotification)
       self.customNavigationButton(selector: #selector(self.addTapped2), dataButton: UserDefaults.standard.object(forKey: "ProfileImage") as? Data)
     }
   }
<<<<<<< HEAD
<<<<<<< HEAD
  //MARK: UserDefault
=======
  
>>>>>>> try
=======
  //MARK: UserDefault
>>>>>>> feature/refactor
   func userDefaultSet(){
     customNavigationButton(selector: #selector(addTapped2), named: "PersonIcon",
                            tintColor: .red,
                            dataButton: UserDefaults.standard.object(
                              forKey: "ProfileImage") as? Data)
     
        labelNavigation(textColor: .white,
                        text: UserDefaults.standard.string(
                          forKey: "User") ?? "Hello \nName Surname")
   }
}
//MARK: TABLE VIEW

extension ViewController : UITableViewDelegate{
  
<<<<<<< HEAD
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .none
  }
  
  func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
    return false
  }
  
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    
    self.sharedArray.swapAt(sourceIndexPath.row, destinationIndexPath.row)
  }
  
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    //MARK: DELETE ACTION
    let action = UITableViewRowAction.init(
      style: .normal,
      title: "Delete")
    { (action, index) in
      print("🤖 Delete", index.row)
      self.sharedArray.remove(at: index.row)
      self.save()
   
      self.sharedTable.deleteRows(at: [index], with: .right)
      
      self.save()
      self.sharedTable.reloadData()
      
    }
    action.backgroundColor =  #colorLiteral(red: 0.173355639, green: 0.1415168047, blue: 0.1407646239, alpha: 1)
    
    return [action]
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
=======
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
<<<<<<< HEAD
    
>>>>>>> try
=======
>>>>>>> feature/refactor
    return 60
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
<<<<<<< HEAD
<<<<<<< HEAD
   return sharedArray.count
=======
    return sharedArray.count
    
>>>>>>> try
=======
    if section == 0{
      
      return sharedArray.count
    }else{
      
      return sharedArray.count + 50
    }
>>>>>>> feature/refactor
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    sharedTable.deselectRow(at: indexPath, animated: true)
    
    if isDone[indexPath.row]{
<<<<<<< HEAD

=======
      
>>>>>>> try
      isDone[indexPath.row] = false
      sharedTable.cellForRow(at: indexPath)?.accessoryType = .none
          }else{
      isDone[indexPath.row] = true
      sharedTable.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
  }
  //MARK: VIEW CONTROLLER EXTENSION
}
extension ViewController : UITableViewDataSource{

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = sharedTable.dequeueReusableCell(withIdentifier: "tasksSharedCell", for: indexPath)
        cell.tintColor = UIColor.white
<<<<<<< HEAD
<<<<<<< HEAD
    
//MARK: Gradient Layer
    let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.init(cgColor: #colorLiteral(red: 0.173355639, green: 0.1415168047, blue: 0.1407646239, alpha: 1)).cgColor,
                            UIColor.init(cgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).cgColor]
        gradientLayer.locations = [0.0,1.0]
        gradientLayer.frame = cell.frame(
                      forAlignmentRect: CGRect(
                        x: 0, y: 5,
                         width: cell.bounds.width, height: 50))
=======

=======
    
//MARK: Gradient Layer
>>>>>>> feature/refactor
    let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.init(cgColor: #colorLiteral(red: 0.173355639, green: 0.1415168047, blue: 0.1407646239, alpha: 1)).cgColor,
                            UIColor.init(cgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).cgColor]
<<<<<<< HEAD
    gradientLayer.locations = [0.0,1.0]
    gradientLayer.frame = cell.frame(forAlignmentRect: CGRect(x: 0, y: 5, width: cell.bounds.width, height: 50))
>>>>>>> try
=======
        gradientLayer.locations = [0.0,1.0]
        gradientLayer.frame = cell.frame(
                      forAlignmentRect: CGRect(
                        x: 0, y: 5,
                         width: cell.bounds.width, height: 50))
>>>>>>> feature/refactor

    gradientLayer.cornerRadius = 8
    gradientLayer.borderWidth = 2
    gradientLayer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
     
<<<<<<< HEAD
<<<<<<< HEAD
    //MARK: Cell DataSource
    
=======
>>>>>>> try
=======
    //MARK: Cell DataSource
    
>>>>>>> feature/refactor
    cell.textLabel?.textColor = .white
    cell.layer.addSublayer(gradientLayer)
    cell.layer.insertSublayer(gradientLayer, at: 0)
    
<<<<<<< HEAD
<<<<<<< HEAD
    cell.textLabel?.text = self.sharedArray[indexPath.row]
  
=======
    cell.textLabel?.text = sharedArray[indexPath.section].tasks[indexPath.row].taskName
//    cell.textLabel?.text = self.newSharedArrayView[indexPath.row]
    
    print("sharedArray[indexPath.row]")
>>>>>>> try
=======
    cell.textLabel?.text = sharedArray[indexPath.row]
  
>>>>>>> feature/refactor
    if isDone[indexPath.row]{
      cell.accessoryType = .checkmark
         } else {
      cell.accessoryType = .none
    }
    return cell
  }
}

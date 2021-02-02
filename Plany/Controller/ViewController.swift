//  ViewController.swift
//  Plany
//  Created by Gianluca Dubioso on 22/10/2020.

import UIKit

class ViewController: UIViewController {
 
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var addHomeworkButton: UIButton!
  @IBOutlet weak var homeworkLabel: UILabel!
  @IBOutlet weak var tasksLabel: UILabel!
  @IBOutlet weak var calendar: UIImageView!
  @IBOutlet weak var homeworkCollection: UICollectionView!
  @IBOutlet var sharedTable: UITableView!
  
  var arrayDate: [String] = UserDefaults.standard.object(forKey: "DateText") as? [String] ?? ["Date"]
  var arrayTime: [String] = UserDefaults.standard.object(forKey: "DateTime") as? [String] ?? ["Time"]
  var arrayTitle: [String] = UserDefaults.standard.object(forKey: "TitleText") as? [String] ?? ["Title"]
  var arrayText: [String] = UserDefaults.standard.object(forKey: "TagText") as? [String] ?? ["Text"]
 
  var isDone: [Bool] = UserDefaults.standard.object(forKey: "isDone") as? [Bool] ?? [false, false, false, false, false,false, false, false, false, false,false, false, false, false, false]
  
  var sharedArray: [Section] = []
//  var newSharedArrayView: [String] = UserDefaults.standard.object(forKey: "SharedName") as? [String] ?? ["Default"]
  override func viewDidLoad() {
    super.viewDidLoad()
   
    self.homeworkCollection.delegate = self
    self.homeworkCollection.dataSource = self
    
    self.sharedTable.delegate = self
    self.sharedTable.dataSource = self
    
    setlayout()
    observerItems()
    userDefaultSet()
  }
  
    override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
      load()
      
//
//      NotificationCenter.default.addObserver(forName: NSNotification.Name("updateArrayShared"),
//                                              object: nil, queue: .main) { (notification) in
//
//
//        UserDefaults.standard.object(forKey: "SharedName")
//      }
      
  }
  
//  @objc func rewriteShareArray(notification: NSNotification){
//
//    guard let retrivedSharedData = UserDefaults.standard.string(forKey: "SharedName") else {
//      return
//    }
//
//    self.newSharedArrayView.append(retrivedSharedData)
//
//    let index = IndexPath.init(
//          item: self.newSharedArrayView.count-1,
//                                   section: 0)
//
//    self.sharedTable.insertRows(at: [index], with: .fade)
//
//    UserDefaults.standard.set(self.newSharedArrayView, forKey: "SharedName")
//  }
  
  @objc func rewritingArrays(notification: NSNotification){
   
  guard let retrievedDate = UserDefaults.standard.string(
            forKey: "DateText"),

        let  retrievedTime = UserDefaults.standard.string(
                  forKey: "DateTime"),
            
        let retrievedTitle = UserDefaults.standard.string(
            forKey: "TitleText"),
          
        let retrievedText = UserDefaults.standard.string(
            forKey: "TagText") else {
      return
    }
    self.arrayDate.append(retrievedDate)
    self.arrayTime.append(retrievedTime)
    self.arrayTitle.append(retrievedTitle)
    self.arrayText.append(retrievedText)

let index = IndexPath.init(
      item: self.arrayTitle.count-1,
                               section: 0)

self.homeworkCollection.insertItems(at: [index])

      UserDefaults.standard.set(self.arrayDate, forKey: "DateText")
      UserDefaults.standard.set(self.arrayTime, forKey: "DateTime")

      UserDefaults.standard.set(self.arrayTitle, forKey: "TitleText")
      UserDefaults.standard.set(self.arrayText, forKey: "TagText")
  
    }
}
//MARK: COLLECTIONVIEW

extension ViewController : UICollectionViewDelegate {
  
func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 
  
  let alertCell = UIAlertController(
                   title: arrayDate[indexPath.row] + "\n" ,
                   message: arrayText[indexPath.row] ,
                   preferredStyle: .alert)
  
  alertCell.title?.append(arrayTitle[indexPath.row])
  alertCell.addAction(UIAlertAction(
                        title: "Edit",
                        style: .default,
                        handler:  nil))
  alertCell.addAction(UIAlertAction(title: "Dismiss",
                                    style: .cancel,
                                    handler: nil))
 
  present(alertCell, animated: true, completion: nil)
  
  
  }
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   return self.arrayText.count
}
  
}
extension ViewController :  UICollectionViewDataSource{

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell : CollectionViewCell = homeworkCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell

     cell.postTitleLabel.text = self.arrayTitle[indexPath.row]
     cell.postTime.text = self.arrayDate[indexPath.row]
     cell.postTimeHours.text = self.arrayTime[indexPath.row]
     cell.postText.text = self.arrayText[indexPath.row]


   let gradientLayer = CAGradientLayer()
       gradientLayer.colors = [UIColor.init(cgColor: #colorLiteral(red: 0.173355639, green: 0.1415168047, blue: 0.1407646239, alpha: 1)).cgColor,
                               UIColor.init(cgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).cgColor]
       gradientLayer.locations = [0.0,1.0]
       gradientLayer.frame = cell.bounds
    
    cell.clipsToBounds = true
    cell.layer.addSublayer(gradientLayer)
    cell.layer.insertSublayer(gradientLayer, at: 0)

    cell.layer.cornerRadius = 8
    cell.layer.borderWidth = 2
    cell.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)

 return cell
  }
}

extension ViewController{
  
  func load() {
         
    if let loadData = UserDefaults.standard.value(forKey: "shared") as? Data {
       let decoder = JSONDecoder()
      let myArray = try? decoder.decode([Section].self, from: loadData)
            sharedArray = myArray!
            sharedTable.reloadData()
          }
  }
  
//  func save() {
//          let encoder = JSONEncoder()
//    let myArray = try? encoder.encode(sharedArray)
//          UserDefaults.standard.set(myArray, forKey: "shared")
//      }

  func updateSearchResults(for searchController: UISearchController) {
       guard let text = searchController.searchBar.text else { return }
       print(text)
   }
  
   func setlayout(){
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
   
   func observerItems(){

    NotificationCenter.default.addObserver(self, selector: #selector(rewritingArrays),
                                           name: NSNotification.Name(rawValue: "updateSharedArray"),
                                           object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(rewritingArrays),
                                           name: NSNotification.Name(rawValue: "updateArray"),
                                           object: nil)
    
  
    NotificationCenter.default.addObserver(forName: NSNotification.Name("updateName"),
                                            object: nil, queue: .main) { (notification) in
       
       guard let nameNotification = notification.object as? String else {
         return
       }
       self.labelNavigation(textColor: .white, text: "Hello \n" + nameNotification)
       self.customNavigationButton(selector: #selector(self.addTapped2), dataButton: UserDefaults.standard.object(forKey: "ProfileImage") as? Data)
     }
   }
  
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
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return 60
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sharedArray.count
    
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    sharedTable.deselectRow(at: indexPath, animated: true)
    
    if isDone[indexPath.row]{
      
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

    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [UIColor.init(cgColor: #colorLiteral(red: 0.173355639, green: 0.1415168047, blue: 0.1407646239, alpha: 1)).cgColor,
                            UIColor.init(cgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).cgColor]
    gradientLayer.locations = [0.0,1.0]
    gradientLayer.frame = cell.frame(forAlignmentRect: CGRect(x: 0, y: 5, width: cell.bounds.width, height: 50))

    gradientLayer.cornerRadius = 8
    gradientLayer.borderWidth = 2
    gradientLayer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
     
    cell.textLabel?.textColor = .white
    cell.layer.addSublayer(gradientLayer)
    cell.layer.insertSublayer(gradientLayer, at: 0)
    
    cell.textLabel?.text = sharedArray[indexPath.section].tasks[indexPath.row].taskName
//    cell.textLabel?.text = self.newSharedArrayView[indexPath.row]
    
    print("sharedArray[indexPath.row]")
    if isDone[indexPath.row]{
      cell.accessoryType = .checkmark
         } else {
      cell.accessoryType = .none
    }
    return cell
  }
}

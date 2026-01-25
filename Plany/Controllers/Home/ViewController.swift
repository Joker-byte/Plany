//  ViewController.swift
//  Plany
//  Created by Gianluca Dubioso on 22/10/2020.

import UIKit
import AudioToolbox
import SkeletonView

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var addHomeworkButton: UIButton!
    @IBOutlet weak var homeworkLabel: UILabel!
    @IBOutlet weak var tasksLabel: UILabel!
    @IBOutlet weak var calendar: UIImageView!
    @IBOutlet weak var homeworkCollection: UICollectionView!
    @IBOutlet weak var sharedTable: UITableView!
    @IBOutlet weak var addTasksButton: UIButton!
    
    var longPressedEnabled: Bool!
    var datePicker: UIDatePicker!
    var isSearching: Bool = false
    
    // original Array originali
    var arrayDate =  [String]()
    var arrayTime =  [String]()
    var arrayText =  [String] ()
    var arrayTitle = [String] ()
    var sharedArray = [Task] ()
    var reminder = [Reminder]()
    
    // filtered
    var filteredArrayDate = [String]()
    var filteredArrayTime = [String]()
    var filteredArrayText = [String]()
    var filteredArrayTitle = [String]()
    var filteredSharedArray = [Task]()
    
    
    var isDone: [Bool] = UserDefaults.standard.object(
        forKey: "isDone") as? [Bool] ?? [false]
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        arrayDate = getArray(StringKey: "DateText")
        arrayTime = getArray(StringKey: "DateTime")
        arrayText = getArray(StringKey: "TagText")
        arrayTitle = getArray(StringKey: "TitleText")

        validateArrays()
        
        if let data = UserDefaults.standard.data(forKey: "shared"),
           let decoded = try? JSONDecoder().decode([Task].self, from: data) {
            sharedArray = decoded
        }
        
        self.homeworkCollection.delegate = self
        self.homeworkCollection.dataSource = self
        
        self.sharedTable.delegate = self
        self.sharedTable.dataSource = self
        
        self.searchBar.delegate = self
        
        
        load()
        headersAndSections()
        
        recognizer()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadAllData),
            name: NSNotification.Name("sharedUpdated"),
            object: nil
        )
        
    }
    
    @objc func reloadAllData() {
        arrayDate = getArray(StringKey: "DateText")
        arrayTime = getArray(StringKey: "DateTime")
        arrayText = getArray(StringKey: "TagText")
        arrayTitle = getArray(StringKey: "TitleText")
        
        if let data = UserDefaults.standard.data(forKey: "shared"),
           let decoded = try? JSONDecoder().decode([Task].self, from: data) {
            sharedArray = decoded
        } else {
            sharedArray = []
        }
        
        homeworkCollection.reloadData()
        sharedTable.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.homeworkCollection.isSkeletonable = true
        self.sharedTable.isSkeletonable = true
        //FAKE LOADING DATA
        enableSkeleton(view: homeworkCollection)
        enableSkeleton(view: sharedTable)
        
        
        //FAKE TRIGGER Of DATA RETRIVED
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.disableSkeleton(view: self?.homeworkCollection)
            self?.disableSkeleton(view: self?.sharedTable)
            
            
            self?.sharedTable.reloadData()
        }
    }

    func headersAndSections() {
        setlayout()
        observerItems()
        userDefaultSet()
        
        
    }
}

extension ViewController : UINavigationControllerDelegate{
    
    //MARK: Searchbar
    func updateSearchResults(
        
        for searchController: UISearchController) {
            guard let text = searchController.searchBar.text else { return }
            
            text.isEmpty ? sharedTable.reloadData() : sharedTable.reloadData()
            print(String(describing:   " [RICERCA]: \(text)"))
        }
    
    //MARK: Layout
    func setlayout(){
        
        searchBar.layer.cornerRadius = 8
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = .clear
        
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            searchBar.searchTextField.leftView?.tintColor = .white
            
        } else {
            
        }
        UITextField.appearance(
            whenContainedInInstancesOf: [
                UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
        //        homeworkCollection.layer.cornerRadius = 5
        
        navigationItem.backButtonTitle = "Calendar"
        calendar.image = UIImage(named: "CalendarIcon")
        calendar.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openCalendar))
        calendar.addGestureRecognizer(tapGesture)
        
        addHomeworkButton.frame = CGRect(
            x: 0, y: 0,
            width: 12, height: 12
        )
        addHomeworkButton.setImage(UIImage(named: "Add"),
                                   for: .normal)
        addHomeworkButton.addTarget(
            self,
            action: #selector(pushHomework),
            for: .touchUpInside)
        
        addTasksButton.addTarget(
            self,
            action: #selector(pushTask),
            for: .touchUpInside)
        
    }
    
    @objc func openCalendar(){
        
        guard let url = URL(string: "calshow://") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
    }
    //MARK: Observer
    func observerItems(){
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(rewritingArrays),
            name: NSNotification.Name(
                rawValue: "updateArray"),
            object: nil)
        
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name("updateName"),
            object: nil,
            queue: .main) { (notification) in
                
                if let nameNotification = notification.object as? String {
                    self.labelNavigation(
                        textColor: .white,
                        text: "Hello \n" + nameNotification)
                    
                    self.customNavigationButton(
                        selector: #selector(
                            self.pushProfile),
                        
                        dataButton: UserDefaults.standard.object(
                            forKey: "ProfileImage") as? Data)
                }
            }
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name("sharedUpdated"),
            object: nil,
            queue: .main) { [weak self] notification in
                guard let self = self else { return }
                if let data = UserDefaults.standard.data(forKey: "shared"),
                   let decoded = try? JSONDecoder().decode([Task].self, from: data) {
                    self.sharedArray = decoded
                }
                self.sharedTable.reloadData()
                if let task = notification.object as? Task {
                    print("Shared updated:", task.taskName, "isDone:", task.isDone)
                }
        }
    }
    
    
    
    
    //MARK: UserDefault
    func userDefaultSet(){
        customNavigationButton(selector: #selector(pushProfile),
                               named: "PersonIcon",
                               tintColor: .red,
                               dataButton: UserDefaults.standard.object(
                                forKey: "ProfileImage") as? Data)
        
        labelNavigation(textColor: .white,
                        text: UserDefaults.standard.string(
                            forKey: "User") ?? "Hello \nName Surname")
    }
    
    
    //MARK: GESTURE
    func recognizer() {
        
        let longPressGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(
                self.longTap(_:)))
        
        homeworkCollection.addGestureRecognizer(
            longPressGesture)
    }
    
    @objc func longTap(_ gesture: UIGestureRecognizer){
        
        switch(gesture.state) {
        case .began:
            guard let selectedIndexPath = homeworkCollection.indexPathForItem(at: gesture.location(in: homeworkCollection)) else {
                return
            }
            homeworkCollection.beginInteractiveMovementForItem(
                at: selectedIndexPath)
            
            AudioServicesPlayAlertSound(
                kSystemSoundID_Vibrate)
            
        case .changed:
            homeworkCollection.updateInteractiveMovementTargetPosition(
                gesture.location(in: gesture.view!))
            
        case .ended:
            homeworkCollection.endInteractiveMovement()
            //  doneBtn.isHidden = false
            longPressedEnabled = true
            self.homeworkCollection.reloadData()
            
        default:
            homeworkCollection.cancelInteractiveMovement()
        }
    }
    
    
    
    
}
// MARK: Handle Arrays
extension ViewController {
    
    @objc func load() {
        enableSkeleton(view: homeworkCollection)
        enableSkeleton(view: sharedTable)
        if let data = UserDefaults.standard.data(forKey: "shared"),
           let decoded = try? JSONDecoder().decode([Task].self, from: data) {
            sharedArray = decoded
        } else {
            sharedArray = []
        }
        sharedTable.reloadData()
    }
    func save() {
        if let encoded = try? JSONEncoder().encode(sharedArray) {
            UserDefaults.standard.set(encoded, forKey: "shared")
        }
    }
    
    func getTasksForSection(_ section: Int) -> [Task] {
        if section == 0 {
            return sharedArray.filter { !$0.isDone }
        } else {
            return sharedArray.filter { $0.isDone }
        }
    }
    
    func updateSharedArray(with tasks: [Task], for section: Int) {
        if section == 0 {
            sharedArray = tasks + sharedArray.filter { $0.isDone }
        } else {
            sharedArray = sharedArray.filter { !$0.isDone } + tasks
        }
    }
    //  Rewrite Array Retrived
    @objc func rewritingArrays(
        notification: NSNotification){
            
            guard let retrievedDate = retrieveData(stringKey: "DateText"),
                  let  retrievedTime = retrieveData(stringKey: "DateTime"),
                  let retrievedTitle = retrieveData(stringKey: "TitleText"),
                  let retrievedText = retrieveData(stringKey: "TagText")
                    
            else {return}
            
            arrayDate.append(retrievedDate)
            arrayTime.append(retrievedTime)
            arrayTitle.append(retrievedTitle)
            arrayText.append(retrievedText)
            
            if arrayTitle.count == 1 {
                self.homeworkCollection.reloadData()
            } else {
                let index = IndexPath.init(
                    item: self.arrayTitle.count-1,
                    section: 0)
                self.homeworkCollection.insertItems(at: [index])
            }
            saveAllData()
            //saveAllData(sourceIndexPath: index, destinationIndexPath: index)
        }
    
    
    func removeCollection(index: Int){
        //TAKE CARE OF THIS BEHAVIOR
        guard index >= 0,
              index < arrayDate.count,
              index < arrayTime.count,
              index < arrayTitle.count,
              index < arrayText.count else {
            print("Index out of range in removeCollection: \(index)")
            return
        }
        
        arrayDate.remove(at: index)
        arrayTime.remove(at: index)
        arrayTitle.remove(at: index)
        arrayText.remove(at: index)
        
        homeworkCollection.reloadData()
        
        saveAllData()
        
    }
    
    @objc func removeDate(index: Int){
        //TAKE CARE OF THIS BEHAVIOR
        guard index >= 0,
              index < arrayDate.count,
              index < arrayTime.count else {
            print("Index out of range in removeDate: \(index)")
            return
        }
        
        arrayDate.remove(at: index)
        arrayTime.remove(at: index)
        
        homeworkCollection.reloadData()
        setArray(array: arrayDate, StringKey: "DateText")
        setArray(array: arrayTime, StringKey: "DateTime")
        
    }
    func saveAllData(){
        
        
        setArray(array: arrayDate, StringKey: "DateText")
        setArray(array: arrayTime, StringKey: "DateTime")
        setArray(array: arrayTitle, StringKey: "TitleText")
        setArray(array: arrayText, StringKey: "TagText")
        
    }

    func validateArrays() {
        let minCount = min(arrayDate.count, arrayTime.count, arrayTitle.count, arrayText.count)
        
        if arrayDate.count != minCount || 
           arrayTime.count != minCount || 
           arrayTitle.count != minCount || 
           arrayText.count != minCount {
            
            print("Array inconsistency detected. Syncing to \(minCount) items")
            
            arrayDate = Array(arrayDate.prefix(minCount))
            arrayTime = Array(arrayTime.prefix(minCount))
            arrayTitle = Array(arrayTitle.prefix(minCount))
            arrayText = Array(arrayText.prefix(minCount))
            
            saveAllData()
        }
    }
    
    func setArray(array: Array<Any> , StringKey: String ) {
        return  UserDefaults.standard.set(
            array, forKey: StringKey)
    }
    
    func getArray(StringKey: String) -> [String] {
        return  UserDefaults.standard.object(
            forKey: StringKey) as? [String] ?? []
    }
    func retrieveData(stringKey: String) -> String? {
        
        return UserDefaults.standard.string(
            forKey: stringKey)
        
    }
}


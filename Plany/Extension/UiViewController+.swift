//  UiViewController+.swift
//  Plany
//  Created by Gianluca Dubioso on 26/10/2020.
//  Extension UIView Controller

import UIKit

extension UIViewController {
                //MARK: Custom Nav Button
  func customNavigationButton(selector: Selector? = nil, named: String? = nil, tintColor: UIColor? = nil, dataButton: Data? = nil){
    let mioButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
    
    if let namedExist = named {
      mioButton.setImage(UIImage(named: namedExist), for: .normal)
    }
   if let dataExist = dataButton {
    mioButton.setImage(UIImage(data: dataExist, scale: CGFloat(20)), for: .normal)
    mioButton.layer.cornerRadius = mioButton.frame.width*0.6
   }
    if let ciSta = selector {
      mioButton.addTarget(self, action: ciSta, for: .touchUpInside)
    }
    if let cistaColor = tintColor {
      mioButton.imageView?.image = mioButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
      mioButton.imageView?.tintColor = cistaColor
    }
    mioButton.clipsToBounds = true
    mioButton.imageView?.contentMode = .scaleAspectFit
    navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: mioButton)]
  }
<<<<<<< HEAD
  
  //MARK: Label Navigation
=======
>>>>>>> try
  func labelNavigation(textColor: UIColor, text: String){
    let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 32))
    label.numberOfLines = 2
    label.text = text
    label.textColor = textColor
    
    navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: label)]
  }
<<<<<<< HEAD
  //MARK: Function 
=======
<<<<<<< HEAD
  
=======
>>>>>>> parent of d331b50... Aggiornamento
>>>>>>> try
  @objc func addTapped () {
    guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "peppe2") as? CalendarViewController  else {
      return
    }
    vc.modalPresentationStyle = .overFullScreen
    navigationController?.pushViewController(vc, animated: true)
  }

  @objc func addTapped2 () {
    guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Profile") as? ProfileViewController  else {
      return
    }
    vc.modalPresentationStyle = .overFullScreen
    navigationController?.pushViewController(vc, animated: true)
  }
<<<<<<< HEAD
  
  
  @objc func addTapped3 () {
    guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Picker") as? PickerViewController  else {
      return
    }
    //vc.modalPresentationStyle = .
//vc.modalPresentationStyle = .overFullScreen
    vc.modalTransitionStyle = .crossDissolve
   // navigationController?.pushViewController(vc, animated: true)
    navigationController?.present(vc, animated: true)
  }
  
  // MARK: Alert
  func alertPresent(textTitle: String, mexText : String, actTitle: String) {
  
=======
  func alertPresent(textTitle: String, mexText : String, actTitle: String) {
  
<<<<<<< HEAD
    let alert = UIAlertController(title: textTitle , message: mexText, preferredStyle: .alert)
  
    alert.addAction(UIAlertAction(title: actTitle, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
  }
}
//
//var array: [String] = UserDefaults.standard.object(forKey: "myKey") as? [String] ?? ["Stringa1","Stringa2","Stringa3","Stringa4","Stringa5"]
//
//  override func viewDidLoad() {
//      super.viewDidLoad()
//// UITableViewDataSource Protocol
//      self.tableView.dataSource = self
//// UITableViewDelegate Protocol
//      self.tableView.delegate = self
//  }
//  // Bottone Aggiungi
//
//  @IBAction func addButton_clicked(_ sender: UIButton) {
//    // aggiunta di un nuovo testo con controllo guard let "necessita di return"
//
//if inputTextField.text == "" {
//     alertPresent(textTitle: "Hey Dude", mexText: "Text Field can't be Empty", actTitle: "Cancel")
//     } else {
//      guard let text = self.inputTextField.text else {
//        return
//      }
//        self.array.append(text) // insertAt
//      UserDefaults.standard.set(array, forKey: "myKey")
//      //definizione di comportamento apparizione nuovo item
//        let index = IndexPath.init(
//          row: self.array.count - 1,
//          section: 0)
//
//       self.tableView.insertRows(
//          at: [index],
//          with: .fade)
//    }
// inputTextField.text = ""
//    // Metodo Reload data serve a ricaricare l' intera tabella
//    // a noi serve solo per un elemento quindi commentato
//    //self.tableView.reloadData()
//    }
//
//// bottone edit che permette di spostare l'ordine delle celle cambiandone la posizione
//  @IBAction func editButton_clicked(_ sender: UIBarButtonItem) {
//      self.tableView.setEditing(!self.tableView.isEditing, animated: true)
//  }
//}
////        DATA SOURCE
//extension ViewController: UITableViewDataSource {
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    // ritorno di tanti elementi quanti sono quelli richiamati nell array(dataSource definito)
//    return self.array.count
//  }
//
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    // definizione dell identifier della prototype cell
//      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//    // creazione della row e della cella
//     cell.textLabel?.text = self.array[indexPath.row]
//    return cell
//  }
//}
////      TABLE VIEW DELEGATE
//// Custom action bisogna aggiungere table view delegate
//extension ViewController: UITableViewDelegate {
//
//  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//      return .none
//  }
//
//  func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
//      return false
//  }
////  metodo per azione allo swipe , se restituiamo nil "return nil " le row non restituiranno nessuna azione allo swipe
//
//  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//      print("🤖", sourceIndexPath.row, destinationIndexPath.row)
//      print(array)
//      self.array.swapAt(sourceIndexPath.row, destinationIndexPath.row)
//      print(array)
//      UserDefaults.standard.set(array, forKey: "myKey")
//  }
//
//  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//// azione di cancellazione
//      let action = UITableViewRowAction.init(
//          style: .normal,
//          title: "Delete")
//      { (action, index) in
////print di comportamento in cui index.row definisce quale row e' stata eliminata es: Delete "2"
//          print("🤖 Delete", index.row)
//// ORDINE DI ELIMINAZIONE
//// prima si rimuove dal datasource  (var array di Tipo String definita)
//          self.array.remove(at: index.row)// rimozione dalla sua posizione
//// e poi si puo eseguire l' operazione di delete
//        UserDefaults.standard.set(self.array, forKey: "myKey")
//        tableView.deleteRows(at: [index], with: .right)//.right Cancello una determinata Row swipando da destra
//        UserDefaults.standard.set(self.array, forKey: "myKey")
//      }
//
//      action.backgroundColor = #colorLiteral(red: 0.9267585874, green: 0.367726624, blue: 0.3804723024, alpha: 1) // colore di background del button Delete
//// azione di condivisione
//      let actionShare = UITableViewRowAction.init(
//          style: .normal,// Style default piu' usato
//          title: "Share")//Testo
//      { (action, index) in
//        // qui va l' azione che compie l' Action Share
//          print("🤖 Share", index.row)// inserimento temporaneo di un print
//      }
//      actionShare.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1) // colore di background del button Share
// // ora le due action devono essere restituite
//      return [action, actionShare]// return delle action definite in precedenza
//  }
//}
=======
>>>>>>> try
    let alert = UIAlertController(title: textTitle ,
                                  message: mexText,
                                  preferredStyle: .alert)
    
         alert.addAction(UIAlertAction(
                          title: actTitle,
                          style: .cancel,
                          handler: nil))
        present(alert,
                animated: true,
                completion: nil)
  }
<<<<<<< HEAD
  
  
  //MARK: finire change datepicker
//
//  @objc func showDatePicker(){
//     //Formate Date
//      datePicker.datePickerMode = .date
//
//      //ToolBar
//     let toolbar = UIToolbar();
//     toolbar.sizeToFit()

  
  
  
  //MARK: UserDefaults handler
  
  @objc func Defaultset(data: String? = nil, key: String) {
    UserDefaults.standard.set(data, forKey: key)
  }
  @objc func DefaultObj(key: String){
    UserDefaults.standard.object(forKey: key)
  }
  @objc func DefaultString(key: String){
    UserDefaults.standard.string(forKey: key)
  }
}

=======
}
>>>>>>> parent of d331b50... Aggiornamento
>>>>>>> try

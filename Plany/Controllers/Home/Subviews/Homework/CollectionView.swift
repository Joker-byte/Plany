    //
    //  ProfVCCollectDataSource.swift
    //  Plany
    //
    //  Created by Gianluca Dubioso on 25/02/25.
    //

import UIKit
import SkeletonView


extension ViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return !arrayTitle.isEmpty
    }
    
        //MARK: Swap Collection
    func collectionView(_ collectionView: UICollectionView,
                        moveItemAt sourceIndexPath: IndexPath,
                        to destinationIndexPath: IndexPath) {
        
        self.arrayDate.swapAt(
            sourceIndexPath.item,
            destinationIndexPath.item)
        
        self.arrayTime.swapAt(
            sourceIndexPath.item,
            destinationIndexPath.item)
        
        self.arrayTitle.swapAt(
            sourceIndexPath.item,
            destinationIndexPath.item)
        
        self.arrayText.swapAt(
            sourceIndexPath.item,
            destinationIndexPath.item)
        
        saveAllData()
        
        
        print("Start index :- \(String(describing: sourceIndexPath.item))")
        print("End index :- \(String(describing: destinationIndexPath.item))")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Ignora tap su celle placeholder
        if arrayTitle.isEmpty {
            return
        }
        
        let alertCell = UIAlertController(
            title: arrayDate[indexPath.item] + "\n",
            message: arrayText[indexPath.item],
            preferredStyle: .alert)
        
        alertCell.title?.append(arrayTitle[indexPath.item])
        
        alertCell.addAction(UIAlertAction(
            title: "Edit",
            style: .default,
            handler: { _ in
                TextEntryAlert.show(
                    in: self,
                    index: indexPath.item,
                    currentTitle: self.arrayTitle[indexPath.item],
                    currentText: self.arrayText[indexPath.item],
                    currentDate: self.arrayDate[indexPath.item],
                    currentTime: self.arrayTime[indexPath.item]
                ) { title, text, date, time in

                    if let newTitle = title, !newTitle.isEmpty {
                        self.arrayTitle[indexPath.item] = newTitle
                        self.setArray(array: self.arrayTitle, StringKey: "TitleText")
                    
                    }
                    if let newText = text, !newText.isEmpty {
                        self.arrayText[indexPath.item] = newText
                        self.setArray(array: self.arrayText, StringKey: "TagText")
                    }
                    if let newDate = date, !newDate.isEmpty {
                        self.arrayDate[indexPath.item] = newDate
                        self.setArray(array: self.arrayDate, StringKey: "DateText")
                    }
                    if let newTime = time, !newTime.isEmpty {
                        self.arrayTime[indexPath.item] = newTime
                        self.setArray(array: self.arrayTime, StringKey: "DateTime")
                    }
                   self.homeworkCollection.reloadData()
                    NotificationCenter.default.post(
                        name: NSNotification.Name(
                            rawValue: "updateArray"),
                        object: nil)
                
                  
                }

            }
        ))
        
        alertCell.addAction(UIAlertAction(
            title: "Duplicate",
            style: .default,
            handler: { _ in          
                self.arrayTitle.append(self.arrayTitle[indexPath.item])
                self.arrayText.append(self.arrayText[indexPath.item])
                self.arrayDate.append(self.arrayDate[indexPath.item])
                self.arrayTime.append(self.arrayTime[indexPath.item])
                self.saveAllData()
                
                self.homeworkCollection.reloadData()
                NotificationCenter.default.post(
                    name: NSNotification.Name(rawValue: "updateArray"),
                    object: nil)
            }
        ))
        
        alertCell.addAction(UIAlertAction(
            title: "Remove",
            style: .destructive,
            handler: { _ in
                self.removeCollection(index: indexPath.item)
            }
        ))
        
        alertCell.addAction(UIAlertAction(
            title: "Dismiss",
            style: .cancel,
            handler: nil
        ))
        
        present(alertCell, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            return min(filteredArrayText.count, filteredArrayTitle.count, filteredArrayDate.count, filteredArrayTime.count)
        } else {
            let itemCount = min(arrayText.count,
                       arrayTitle.count,
                       arrayDate.count,
                       arrayTime.count
            )
            // Mostra 3 placeholder se non ci sono elementi
            return itemCount > 0 ? itemCount : 3
        }
    }
    
    
    
}

extension ViewController :  UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : CollectionViewCell = homeworkCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        homeworkCollection.layer.cornerRadius = 5
        
        let titleArray = isSearching ? filteredArrayTitle : arrayTitle
        let dateArray = isSearching ? filteredArrayDate : arrayDate
        let timeArray = isSearching ? filteredArrayTime : arrayTime
        let textArray = isSearching ? filteredArrayText : arrayText
        
        cell.isSkeletonable = true
        
        if titleArray.isEmpty {
            cell.postTitleLabel.text = "Homework \(indexPath.item + 1)"
            cell.postTime.text = "yyyy/MM/DD"
            cell.postTimeHours.text = "hh:mm"
            cell.postText.text = "Tap +"
            cell.alpha = 0.5
        } else {
            cell.postTitleLabel.text = indexPath.item < titleArray.count ? titleArray[indexPath.item] : ""
            cell.postTime.text = indexPath.item < dateArray.count ? dateArray[indexPath.item] : ""
            cell.postTimeHours.text = indexPath.item < timeArray.count ? timeArray[indexPath.item] : ""
            cell.postText.text = indexPath.item < textArray.count ? textArray[indexPath.item] : ""
            cell.alpha = 1.0
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.init(cgColor: #colorLiteral(red: 0.173355639, green: 0.1415168047, blue: 0.1407646239, alpha: 1)).cgColor,
                                UIColor.init(cgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).cgColor]
        gradientLayer.locations = [0.0,1.0]
        gradientLayer.frame = cell.bounds
        
        cell.clipsToBounds = true
        cell.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        cell.layer.insertSublayer(gradientLayer, at: 0)
        
        cell.layer.cornerRadius = 8
        cell.layer.borderWidth = 2
        cell.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        return cell
    }
}





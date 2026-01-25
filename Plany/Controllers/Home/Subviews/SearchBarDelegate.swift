//
//  SearchBarDelegate.swift
//  Plany
//
//  Created by Gianluca Dubioso on 06/03/25.
//

import UIKit


extension ViewController:  UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String){
        print("SEARCHED TEXT:\(searchText)")
        filterContentForSearchText(searchText: searchText)
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        let search = searchText.lowercased()
        
        if searchText.isEmpty {
            isSearching = false
            filteredArrayDate = []
            filteredArrayTime = []
            filteredArrayText = []
            filteredArrayTitle = []
            filteredSharedArray = []
        } else {
            isSearching = true
            filteredArrayDate = []
            filteredArrayTime = []
            filteredArrayText = []
            filteredArrayTitle = []
            //Homework 
            for i in 0..<arrayTitle.count {
                let title = i < arrayTitle.count ? arrayTitle[i].lowercased() : ""
                let text = i < arrayText.count ? arrayText[i].lowercased() : ""
                let date = i < arrayDate.count ? arrayDate[i].lowercased() : ""
                let time = i < arrayTime.count ? arrayTime[i].lowercased() : ""
                
                // tutti i campi
                if title.contains(search) || 
                   text.contains(search) || 
                   date.contains(search) || 
                   time.contains(search) {
                    filteredArrayTitle.append(i < arrayTitle.count ? arrayTitle[i] : "")
                    filteredArrayText.append(i < arrayText.count ? arrayText[i] : "")
                    filteredArrayDate.append(i < arrayDate.count ? arrayDate[i] : "")
                    filteredArrayTime.append(i < arrayTime.count ? arrayTime[i] : "")
                }
            }
            
            // task
            filteredSharedArray = sharedArray.filter { task in
                task.taskName.lowercased().contains(search)
            }
        }

        homeworkCollection.reloadData()
        sharedTable.reloadData()
    }
}
/*
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        if searchText.isEmpty {
         //   reminder = arrayTitle
        } else {
            arrayTitle = zip(arrayTitle, arrayText).compactMap { title, text in
                if title.lowercased().contains(searchText.lowercased()) ||
                    text.lowercased().contains(searchText.lowercased()) {
                    return searchText
                }
                
                return nil
            }
                //            sharedArray = arrayTitle.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased() })
                //            homeworkCollection.reloadData()
                //            sharedArray = zip(arrayDate, arrayTime).compactMap { date, time in
                //                if date.lowercased().contains(searchText.lowercased()) ||
                //                    time.lowercased().contains(searchText.lowercased()) {
                //                    return date // O puoi decidere di mostrare anche text
                //                }
                //
                //                return nil
                //            }
       }
        sharedTable.reloadData()
    }
}

*/

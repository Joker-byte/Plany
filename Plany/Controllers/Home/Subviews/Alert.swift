//
//  Alert.swift
//  Plany
//
//  Created by Gianluca Dubioso on 09/03/25.
//

import UIKit

class TextEntryAlert {
    static func show(
        in viewController: UIViewController,
        index: Int,
        currentTitle: String = "",
        currentText: String = "",
        currentDate: String = "",
        currentTime: String = "",
        completion: @escaping (_ title: String?, _ text: String?, _ date: String?, _ time: String?) -> Void
    ) {
        let title = NSLocalizedString("Edit Task", comment: "")
        let message = NSLocalizedString("Modify the task details", comment: "")
        let cancelButtonTitle = NSLocalizedString("Cancel", comment: "")
        let otherButtonTitle = NSLocalizedString("OK", comment: "")
        let changeDateButtonTitle = NSLocalizedString("Change Date", comment: "")
        
        var selectedDate = currentDate
        var selectedTime = currentTime
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField { titlePlace in
            titlePlace.placeholder = "Insert New Title"
            titlePlace.text = currentTitle
        }
        
        alertController.addTextField { textPlace in
            textPlace.placeholder = "Insert New Text"
            textPlace.text = currentText
        }
        
        alertController.addTextField { datePlace in
            datePlace.placeholder = "Date"
            datePlace.text = "\(currentDate) \(currentTime)"
            datePlace.isEnabled = false
        }
        
        let changeDateAction = UIAlertAction(title: changeDateButtonTitle, style: .default) { _ in
            alertController.dismiss(animated: true) {
                let titleText = alertController.textFields?[0].text ?? currentTitle
                let text = alertController.textFields?[1].text ?? currentText
                
                viewController.presentPickerWithCallback { date, time in
                    selectedDate = date
                    selectedTime = time
                    
                    show(
                        in: viewController,
                        index: index,
                        currentTitle: titleText,
                        currentText: text,
                        currentDate: selectedDate,
                        currentTime: selectedTime,
                        completion: completion
                    )
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil)
        
        let otherAction = UIAlertAction(title: otherButtonTitle, style: .default) { _ in
            let titleText = alertController.textFields?[0].text
            let text = alertController.textFields?[1].text
            completion(titleText, text, selectedDate, selectedTime)
        }
        
        alertController.addAction(changeDateAction)
        alertController.addAction(cancelAction)
        alertController.addAction(otherAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}

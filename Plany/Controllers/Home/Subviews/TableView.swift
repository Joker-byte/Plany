//
//  ProfileTableView.swift
//  Plany
//
//  Created by Gianluca Dubioso on 25/02/25.
//
//MARK: TABLE VIEW

import UIKit
import SkeletonView

extension ViewController : UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearching {
            return 1
        }
        if sharedArray.isEmpty {
            return 1
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearching || sharedArray.isEmpty {
            return nil
        }
        return section == 0 ? "To Do" : "Done"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isSearching || sharedArray.isEmpty {
            return 0
        }
        let tasksInSection = getTasksForSection(section)
        return tasksInSection.isEmpty ? 0 : 36
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = .white
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            header.contentView.backgroundColor = .clear
        }
    }
    
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
        
        if isSearching {
            filteredSharedArray.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        } else if sharedArray.isEmpty {
            return
        } else {
            var sourceTasks = getTasksForSection(sourceIndexPath.section)
            var destTasks = getTasksForSection(destinationIndexPath.section)
            
            if sourceIndexPath.section == destinationIndexPath.section {
                sourceTasks.swapAt(sourceIndexPath.row, destinationIndexPath.row)
                updateSharedArray(with: sourceTasks, for: sourceIndexPath.section)
            }
        }
        save()
    }
    
    func tableView(_ tableView: UITableView,
                   editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if sharedArray.isEmpty {
            return []
        }
        
            //MARK: DELETE ACTION
        let action = UITableViewRowAction.init(
            style: .normal,
            title: "Delete")
        { (action, index) in
            print("🤖 Delete", index.row)
            
            if self.isSearching {
                let taskToRemove = self.filteredSharedArray[index.row]
                if let originalIndex = self.sharedArray.firstIndex(where: { $0.taskName == taskToRemove.taskName }) {
                    self.sharedArray.remove(at: originalIndex)
                }
            } else {
                var tasks = self.getTasksForSection(index.section)
                tasks.remove(at: index.row)
                self.updateSharedArray(with: tasks, for: index.section)
            }
            
            self.save()
            self.sharedTable.reloadData()
        }
        action.backgroundColor =  #colorLiteral(red: 0.173355639, green: 0.1415168047, blue: 0.1407646239, alpha: 1)
        
        let pushBackAction = UITableViewRowAction.init(
            style: .normal,
            title: "Push Back")
        { (action, index) in
            print("🤖 Push Back", index.row)
            
            var taskToReturn: Task
            
            if self.isSearching {
                taskToReturn = self.filteredSharedArray[index.row]
                if let originalIndex = self.sharedArray.firstIndex(where: { $0.taskName == taskToReturn.taskName }) {
                    self.sharedArray.remove(at: originalIndex)
                }
            } else {
                var tasks = self.getTasksForSection(index.section)
                taskToReturn = tasks[index.row]
                tasks.remove(at: index.row)
                self.updateSharedArray(with: tasks, for: index.section)
            }
            
            taskToReturn.shared = false
            
            if let data = UserDefaults.standard.data(forKey: "abitudine"),
               var omniItem = try? JSONDecoder().decode([Section].self, from: data) {
                
                if taskToReturn.isDone {
                    if omniItem.count == 1 {
                        omniItem.append(Section(name: "Done", tasks: [taskToReturn]))
                    } else {
                        let doneIndex = omniItem.firstIndex(where: { $0.name == "Done" }) ?? 1
                        omniItem[doneIndex].tasks.append(taskToReturn)
                    }
                } else {
                    if omniItem.isEmpty {
                        omniItem.append(Section(name: "To Do", tasks: [taskToReturn]))
                    } else {
                        let todoIndex = omniItem.firstIndex(where: { $0.name == "To Do" }) ?? 0
                        omniItem[todoIndex].tasks.append(taskToReturn)
                    }
                }
                
                if let encoded = try? JSONEncoder().encode(omniItem) {
                    UserDefaults.standard.set(encoded, forKey: "abitudine")
                }
            }
            
            self.save()
            self.sharedTable.reloadData()
            
            print("🤖 Task isDone:", taskToReturn.isDone)
        }
        pushBackAction.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        
        return [action, pushBackAction]
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredSharedArray.count
        }
        
        if sharedArray.isEmpty {
            return 4
        }
        
        return getTasksForSection(section).count
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        if sharedArray.isEmpty {
            return
        }
        
        sharedTable.deselectRow(
            at: indexPath, animated: true)
        
        if isSearching {
            var task = filteredSharedArray[indexPath.row]
            task.isDone.toggle()
            filteredSharedArray[indexPath.row] = task
            
            if let originalIndex = sharedArray.firstIndex(where: { $0.taskName == task.taskName }) {
                sharedArray[originalIndex].isDone = task.isDone
            }
        } else {
            var tasks = getTasksForSection(indexPath.section)
            tasks[indexPath.row].isDone.toggle()
            
            updateSharedArray(with: tasks, for: indexPath.section)
        }
        
        save()
        
        sharedTable.reloadData()
    }
        //MARK: VIEW CONTROLLER EXTENSION
}
extension ViewController : UITableViewDataSource{
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "tasksSharedCell"
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sharedTable.dequeueReusableCell(
            withIdentifier: "tasksSharedCell", for: indexPath)
        
        let spacing: CGFloat = 10
        let containerTag = 100
      
        cell.selectionStyle = .none
        cell.tintColor = UIColor.white
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        
        var containerView: UIView!
        
        if let existingContainer = cell.contentView.viewWithTag(containerTag) {
            containerView = existingContainer
        } else {
            containerView = UIView()
            containerView.tag = containerTag
            containerView.layer.cornerRadius = 10
            containerView.layer.masksToBounds = true
            containerView.isSkeletonable = true
            cell.contentView.insertSubview(containerView, at: 0)
        }
        
        containerView.frame = CGRect(
            x: spacing / 2,
            y: spacing / 2,
            width: cell.bounds.width - spacing,
            height: 60 - spacing
        )
        
        if containerView.layer.sublayers?.first as? CAGradientLayer == nil {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor.init(cgColor: #colorLiteral(red: 0.173355639, green: 0.1415168047, blue: 0.1407646239, alpha: 1)).cgColor,
                                    UIColor.init(cgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).cgColor]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.cornerRadius = 10
            gradientLayer.frame = containerView.bounds
            containerView.layer.insertSublayer(gradientLayer, at: 0)
        } else {
            if let gradientLayer = containerView.layer.sublayers?.first as? CAGradientLayer {
                gradientLayer.frame = containerView.bounds
            }
        }
        
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        
        let checkmarkTag = 200
        containerView.viewWithTag(checkmarkTag)?.removeFromSuperview()
        
        if let textLabel = cell.textLabel {
            textLabel.textColor = .white
            textLabel.backgroundColor = .clear
            textLabel.isSkeletonable = true

            if sharedArray.isEmpty {
                textLabel.text = "Task \(indexPath.row + 1) - Tap + to add your first task"
                textLabel.alpha = 0.5
            } else {
                let taskArray = self.isSearching ? self.filteredSharedArray : self.getTasksForSection(indexPath.section)
                
                if let task = taskArray[safe: indexPath.row] {
                    textLabel.text = task.taskName
                    textLabel.alpha = 1.0
                    
                    if task.isDone {
                        let checkmark = UILabel()
                        checkmark.tag = checkmarkTag
                        checkmark.text = "✓"
                        checkmark.textColor = .white
                        checkmark.textAlignment = .center
                        checkmark.font = UIFont.boldSystemFont(ofSize: 20)
                        checkmark.backgroundColor = .clear
                        checkmark.frame = CGRect(
                            x: containerView.bounds.width - 35,
                            y: 0,
                            width: 30,
                            height: containerView.bounds.height
                        )
                        containerView.addSubview(checkmark)
                    }
                }
            }
        }

        return cell
    }
    
}
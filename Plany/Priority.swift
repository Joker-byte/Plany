//
//  Priority.swift
//  Plany
//
//  Created by Gianluca Dubioso on 02/11/2020.
//
import UIKit

enum Priority: Int {
    case low = 0
    case medium = 1
    case high = 2
    
    func color() -> UIColor {
        switch self {
        case .low: return #colorLiteral(red: 0.403436912, green: 0.8980392157, blue: 0.5160145532, alpha: 1)
        case .medium: return #colorLiteral(red: 0.965166176, green: 0.8705441644, blue: 0.2390042265, alpha: 1)
        case .high: return #colorLiteral(red: 1, green: 0.4182482217, blue: 0.5368555983, alpha: 1)
        }
    }
    
}


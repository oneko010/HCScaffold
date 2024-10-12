//
//  UIApplication+FilePath.swift
//  HCScaffold
//
//  Created by oneko on 10/12/24.
//

import Foundation

extension UIApplication {
    public static var documentPath: String {
        get {
            return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        }
    }
}

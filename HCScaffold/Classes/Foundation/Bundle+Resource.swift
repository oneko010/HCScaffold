//
//  Bundle+Resource.swift
//  HCScaffold
//
//  Created by oneko on 10/15/24.
//

import Foundation

extension Bundle {
    public static func resourceBoundle(aClass: AnyClass, assetBundleName: String) -> Bundle? {
        let bundle = Bundle(for: aClass)
        let url = bundle.url(forResource: assetBundleName, withExtension: "bundle")!
        return Bundle(url: url)
    }
}

//
//  String+Path.swift
//  HCScaffold
//
//  Created by oneko on 10/12/24.
//

import Foundation

enum FilePathError: Error {
    case invalidOperate(msg: String)
}

extension String {
    func fileNameNoExtension() throws -> String {
        let url = URL(string: self)
        if url == nil {
            throw FilePathError.invalidOperate(msg: "\(self) can't build url")
        }
        return "/".appending(url!.deletingPathExtension().lastPathComponent)
    }
}

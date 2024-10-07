//
//  ViewController.swift
//  HCScaffold
//
//  Created by 崔海成 on 10/08/2024.
//  Copyright (c) 2024 崔海成. All rights reserved.
//

import UIKit
import HCScaffold

class ViewController: UIViewController {
    let logger = HCLogger(logToFile: false)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        logger.logLevel = .info
        logger.info("hello"); logger.info("test")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


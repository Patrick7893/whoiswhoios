//
//  CustomContactViewController.swift
//  whoiswho
//
//  Created by Stasenko Pavel on 9/19/16.
//  Copyright © 2016 Stasenko Pavel. All rights reserved.
//

import UIKit
import ContactsUI

class CustomContactViewController: CNContactViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.rightBarButtonItem?.action
    }

}

//
//  iosWindowDriverVC.swift
//  apptest
//
//  Created by Michael Ong on 8/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import UIKit

class iosWindowDriverV: UIView {

    override class var layerClass: AnyClass {

        return CAMetalLayer.self
    }
}


class iosWindowDriverVC: UIViewController {

    override func loadView                  () {

        view = iosWindowDriverV()
    }

    override func viewDidLoad               () {

        view.backgroundColor = .gray
    }

    override func didReceiveMemoryWarning   () {

    }
}

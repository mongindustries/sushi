//
//  iosWindowDriverVC.swift
//  apptest
//
//  Created by Michael Ong on 8/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import UIKit

class       iosWindowDriverV: UIView {

    override class var      layerClass                  : AnyClass { return CAMetalLayer.self }
}


protocol    iosWindowDriverVCDelegate: class {

    func                    informResize                (to newSize: CGSize)
}

class       iosWindowDriverVC: UIViewController {

    weak var                delegate                    : iosWindowDriverVCDelegate?


    override var            prefersStatusBarHidden      : Bool { return true }


    override func           loadView                    () {

        view = iosWindowDriverV()
    }

    override func           viewDidLoad                 () {

        view.backgroundColor = .gray
    }

    override func           viewWillTransition          (to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

        delegate?.informResize(to: size)
    }
}

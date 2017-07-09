//
//  iosWindowDriver.swift
//  apptest
//
//  Created by Michael Ong on 8/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

import sushicore

import sushiwindow
import sushiapplication

class iosWindowDriver: WindowDriver, iosWindowDriverVCDelegate {

    weak var    delegate:       (Window & WindowDriverDelegate)?


    func        initialise      () -> Any {

        let     vc                              = iosWindowDriverVC(nibName: nil, bundle: nil)
                vc.delegate                     = self

        let     theWindow                       = UIWindow(frame: UIScreen.main.bounds)
                theWindow.rootViewController    = vc

        theWindow.makeKeyAndVisible()

        return  theWindow
    }

    func        destory         () {


    }

    func        process         (message: WindowDriverMessage, data: Any) {

        
    }

    func        undefinedRect   () -> Rectangle {

        guard let window = delegate?.backingWindow as? UIWindow else { FastFail.instance.crash(with: .unexpectedPayload) }

        let bounds = window.rootViewController!.view.bounds

        return Rectangle(x:         Double(bounds.origin.x  ),
                         y:         Double(bounds.origin.y  ),
                         width:     Double(bounds.width     ),
                         height:    Double(bounds.height    ))
    }

    func        informResize    (to newSize: CGSize) {

        try? delegate?.graphicsSurface.resize(to: .init(Double(newSize.width), Double(newSize.height)), 0)
    }
}

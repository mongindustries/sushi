//
//  AppDelegate.swift
//  apptest
//
//  Created by Michael Ong on 8/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

import sushiapplication
import sushiwindow

Application.initialise  (with: iosApplicationDriver()) {

    _ = Application.instance.spawnWindow(logic: windowLogic(), title: "Hello", at: .undefinedWindowLocation)
}

Application.destroy     ()

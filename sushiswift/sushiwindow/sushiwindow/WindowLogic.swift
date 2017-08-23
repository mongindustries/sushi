//
//  WindowLogic.swift
//  sushiwindow
//
//  Created by Michael Ong on 8/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

public protocol WindowLogic {

    weak var    window          : Window! { get set }


    func        initialise      ()

    func        finalise        ()


    func        run             ()


    func        stateChanged    (to state: Set<WindowState>)
}

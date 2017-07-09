//
//  WindowEnum.swift
//  sushiwindow
//
//  Created by Michael Ong on 22/6/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation
import sushicore

public enum         WindowDriverMessage {   case sizeChanged
                                            case titleChanged
                                            case stateChanged
}

public enum         WindowState         {   case shown
                                            case maximised
}

public typealias    WindowLocationDpi   = (location: Rectangle, dpi: Double)

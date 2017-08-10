//
//  macosWindowDriver.swift
//  apptestmac
//
//  Created by Michael Ong on 10/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation
import AppKit

import sushicore

import sushiwindow
import sushiapplication

class macosWindowDriver: NSObject, WindowDriver, NSWindowDelegate {

    weak var    delegate:           (Window & WindowDriverDelegate)?


    func        initialise          () -> Any {

        let     windowRect                      : NSRect = .init(x:         CGFloat(delegate!.location.origin.x ),
                                                                 y:         CGFloat(delegate!.location.origin.y ),
                                                                 width:     CGFloat(delegate!.location.size.x   ),
                                                                 height:    CGFloat(delegate!.location.size.y   ))

        let     vc                              = macosWindowDriverVC()

                vc.view.frame                   = windowRect

        let     theWindow                       = NSWindow(contentRect: windowRect,
                                                           styleMask: [ .closable, .resizable, .miniaturizable,
                                                                        .titled ],
                                                           backing: .buffered,
                                                           defer: false)

                theWindow.delegate              = self

                theWindow.title                 = self.delegate?.title ?? ""
                theWindow.contentViewController = vc

        theWindow.center                ()
        theWindow.makeKeyAndOrderFront  (NSApp)

        return  theWindow
    }

    func        destory             () {


    }

    func        process             (message: WindowDriverMessage, data: Any) {

        guard let window = delegate?.backingWindow as? NSWindow else { return }

        switch message {

        case .sizeChanged:

            guard let rect  = data as? WindowLocationDpi else { return }

            let windowRect  : NSRect = .init(x:         CGFloat(rect.location.origin.x ),
                                             y:         CGFloat(rect.location.origin.y ),
                                             width:     CGFloat(rect.location.size.x   ),
                                             height:    CGFloat(rect.location.size.y))

            window.setFrame(windowRect, display: true)

        case .titleChanged:

            guard let title = data as? String else { return }

            window.title = title

        case .stateChanged:

            break
        }
    }

    func        undefinedRect       () -> Rectangle {

        let bounds = NSRect(x: 100, y: 100, width: 800, height: 480)

        return Rectangle(x:         Float32(bounds.origin.x  ),
                         y:         Float32(bounds.origin.y  ),
                         width:     Float32(bounds.width     ),
                         height:    Float32(bounds.height    ))
    }

    func        windowWillResize    (_ sender: NSWindow, to frameSize: NSSize) -> NSSize {

        try? delegate?.graphicsSurface.resize(to: .init(Float32(frameSize.width), Float32(frameSize.height)), 0)

        return frameSize
    }
}

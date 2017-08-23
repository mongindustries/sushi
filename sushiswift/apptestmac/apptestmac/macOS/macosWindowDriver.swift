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
                vc.view.layer?.zPosition        = -1

        let     theWindow                       = NSWindow(contentRect: windowRect,
                                                           styleMask: [ .closable, .resizable, .miniaturizable,
                                                                        .titled, .fullSizeContentView ],
                                                           backing: .buffered,
                                                           defer: false)

        theWindow.acceptsMouseMovedEvents       = true

        theWindow.delegate                      = self

        theWindow.titleVisibility               = .hidden
        theWindow.titlebarAppearsTransparent    = true

        theWindow.title                         = self.delegate?.title ?? ""
        theWindow.contentViewController         = vc

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

        let window = self.delegate?.backingWindow as! NSWindow
        let screen = (window.screen ?? NSScreen.main)!

        return Rectangle(x:         Float32((screen.frame.width  - 800) * 0.5),
                         y:         Float32((screen.frame.height - 480) * 0.5),
                         width:     Float32(800),
                         height:    Float32(480))
    }

    func        windowWillResize    (_ sender: NSWindow, to frameSize: NSSize) -> NSSize {

        try? delegate?.graphicsSurface.resize(to: .init(Float32(frameSize.width), Float32(frameSize.height)), 0)

        return frameSize
    }
}

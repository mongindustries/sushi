//
//  Window.swift
//  sushiwindow
//
//  Created by Michael Ong on 22/6/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

import sushicore
import sushigraphics

public class Window: WindowDriverDelegate {

    private var     _location           : Rectangle     = .zero

    public var      location            : Rectangle     {

        get     { return _location }
        set(d)  {

            if d == Rectangle.undefined { _location = driver.undefinedRect() }
            else                        { _location = d }

            driver.process(message: .sizeChanged,    data: WindowLocationDpi(location: location, dpi: dpi))

            resizeSurface()
        }
    }


    private var     _dpi                : Double        = 0

    public var      dpi                 : Double        {

        get     { return _dpi }
        set(d)  {

            _dpi = d

            driver.process(message: .sizeChanged,    data: WindowLocationDpi(location: location, dpi: dpi))

            resizeSurface()
        }
    }


    private var     _title              : String        = ""

    public var      title               : String        {

        get     { return _title }
        set(d)  {

            _title = d

            driver.process(message: .titleChanged,   data: title)
        }
    }


    private var     _state              : Set<WindowState> = [ ]

    public var      state               : Set<WindowState> {

        get { return _state }
        set(d) {

            _state = d

            driver.process(message: .stateChanged,  data: _state)

            logic.stateChanged(to: _state)
        }
    }


    public var      driver              : WindowDriver

    public private(set)
    var             graphicsSurface     : GraphicsSurface!


    public internal(set)
    var             logic               : WindowLogic


    public var      backingWindow       : Any!


    public init                         (with driver: WindowDriver, logic: WindowLogic, _ graphics: GraphicsDevice) {

        assert(driver.delegate == nil)

        self.logic              = logic
        self.driver             = driver

        self.logic.window       = self
        self.driver.delegate    = self

        self.backingWindow      = driver.initialise()
        self.graphicsSurface    = try? graphics.createSurface(with: _location.size, _dpi, to: backingWindow)
    }

    public func     send                (message: WindowDriverMessage, data: Any) {

        switch message {

        case .sizeChanged:

            guard let theData = data as? WindowLocationDpi  else { FastFail.instance.crash(with: .unexpectedPayload) }

            _location   = theData.location
            _dpi        = theData.dpi

        case .stateChanged:

            guard let theData = data as? Set<WindowState>   else { FastFail.instance.crash(with: .unexpectedPayload) }

            _state      = theData

        case .titleChanged:

            guard let theData = data as? String             else { FastFail.instance.crash(with: .unexpectedPayload) }

            _title      = theData
        }
    }


    private func    resizeSurface       () {

        try? self.graphicsSurface.resize(to: _location.size, _dpi)
    }
}

extension Rectangle {

    public static var undefined: Rectangle { return .init(x: 0, y: 0, width: -1, height: -1) }
}


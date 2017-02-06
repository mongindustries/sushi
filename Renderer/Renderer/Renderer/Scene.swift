//
//  Scene.swift
//  Renderer
//
//  Created by Michael Ong on 17/12/16.
//  Copyright © 2016 Michael Ong. All rights reserved.
//

import Foundation

public protocol Scene: class {

    associatedtype  GraphicsDevice

    associatedtype  ContainingView


    var     graphicsDevice  : GraphicsDevice! { get set }


    func    setLayer        (root layer: Layer)


    func    spawn           (from view: ContainingView)

    func    die             ()


    func    step            (with timeInterval: Double)
}

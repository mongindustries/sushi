//
//  ViewController.swift
//  RendererApp
//
//  Created by Michael Ong on 17/12/16.
//  Copyright © 2016 Michael Ong. All rights reserved.
//

import UIKit
import QuartzCore

import Renderer
import RendererMetal

class ViewController: UIViewController {

    let                 scene       = SceneMetal.instance

    weak var            modifier    : BlockModifier!

    private var         rotation    = Float(0)


    override func       viewDidLoad () {

        scene.spawn(from: self.view)

        do {

            let layer       = LayerMetal    ()

            var theBlock    = Block         (vertices: [ ], indices: [ ])

            try layer.register(filter: FilterDiffuse    .self)
            try layer.register(filter: FilterTransform  .self)

            try theBlock.complyTransform    (matrix: .identity)
            try theBlock.complyDiffuse      (texture: ResourceHandle(where: "here"), coordinates: [ ])

            let modifier    = BlockModifier (modifies: [ layer.add(block: theBlock) ])
            self.modifier   = modifier

            scene.setLayer(root: layer)
        }
        catch {

        }

        CADisplayLink(target: self, selector: #selector(doStep)).add(to: .main, forMode: .defaultRunLoopMode)
    }

    @objc private func  doStep      () {

        modifier.setTransform(matrix: .init(rotation: Vector4(0, 0, rotation, 1)))

        rotation += 0.01

        scene.step(with: 0)
    }
}

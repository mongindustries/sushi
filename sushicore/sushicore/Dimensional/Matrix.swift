//
//  Matrix.swift
//  sushicore
//
//  Created by Michael Ong on 16/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

public struct Matrix33 {

    var row1: Dimensional3<Double>

    var row2: Dimensional3<Double>

    var row3: Dimensional3<Double>
}

public struct Matrix44 {

    var row1: Dimensional4<Double>

    var row2: Dimensional4<Double>

    var row3: Dimensional4<Double>

    var row4: Dimensional4<Double>
}

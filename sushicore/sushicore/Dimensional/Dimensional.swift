//
//  Dimensional.swift
//  sushicore
//
//  Created by Michael Ong on 22/6/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

/** A generic structure representing a 2 dimension numerical value.
 */
public struct Dimensional2<Size: Numeric> {

    /** The first dimension.
     */
    public var  x   : Size

    /** The second dimension.
     */
    public var  y   : Size
}

/** A generic structure representing a 3 dimension numerical value.
 */
public struct Dimensional3<Size: Numeric> {

    /** The first dimension.
     */
    public var  x   : Size

    /** The second dimension.
     */
    public var  y   : Size

    /** The third dimension.
     */
    public var  z   : Size
}

/** A generic structure representing a 4 dimension numerical value.
 */
public struct Dimensional4<Size: Numeric> {

    /** The first dimension.
     */
    public var  x   : Size

    /** The second dimension.
     */
    public var  y   : Size

    /** The third dimension.
     */
    public var  z   : Size

    /** The fourth dimension.
     */
    public var  w   : Size
}

//
//  FastFail.swift
//  sushicore
//
//  Created by Michael Ong on 28/6/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

public struct   FastFailType: Error { public var code, message: String }

extension       FastFailType: Equatable {

    public static func  ==              (lhs: FastFailType, rhs: FastFailType) -> Bool { return lhs.code == rhs.code }
}


public protocol FastFailDelegate: class {

    func                programCrashed  (with failureType: FastFailType)
}


public class    FastFail {

    public private(set)
    static var          instance        : FastFail = FastFail()


    public weak var     delegate        : FastFailDelegate?

    public func         crash           (with failureType: FastFailType) -> Never {

        delegate?.programCrashed(with: failureType)

        fatalError("PROGRAM FAILURE: \(failureType.code) - \(failureType.message)")
    }

    public func         nonFatal        (with failureType: FastFailType) -> Void {

        print("NON-FATAL: \(failureType.code) - \(failureType.message)")
    }
}


extension       FastFailType {

    public static var unimplemented         = FastFailType(code: "xx_00", message: "Unimplemented method, please implement me!")

    public static var unexpectedPayload     = FastFailType(code: "po_01", message: "Invalid payload specified.")

    public static var driverNotInstalled    = FastFailType(code: "du_00", message: "Driver not installed!")
}

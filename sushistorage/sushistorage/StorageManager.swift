//
//  StorageManager.swift
//  sushistorage
//
//  Created by Michael Ong on 9/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

public enum StorageManagerLocation {

    case local
    case staging
    case cloud
}

public class StorageManager {

    public init             (from location: StorageManagerLocation) {


    }

    public func enumerate   () -> [ StorageEntry ] {

        return [ ]
    }

    public func contains    (_ relativeURL: URL) -> Bool {

        return false
    }


    public func open        (_ relativeURL: URL) -> Data {

        return Data()
    }

    public func create() -> Data {

        return Data()
    }
}

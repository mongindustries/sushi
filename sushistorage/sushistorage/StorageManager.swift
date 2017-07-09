//
//  StorageManager.swift
//  sushistorage
//
//  Created by Michael Ong on 9/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

public enum StorageManagerLocation {

    case local // application installation directory
    case staging // place application would stage persistable non-volatile state data
    case temporary // place application would stage persistable volatile state data
    case cloud // place application can issue cloud backups with OS
}

public class StorageManager {

    public private(set)
    var             driver  : StorageManagerDriver


    public init             (driving driver: StorageManagerDriver) {

        self.driver = driver
    }


    public func     open    (from location: StorageManagerLocation) -> StorageEntryDirectory? {

        return driver.open(from: location)
    }
}

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

    public private(set)
    var             driver  : StorageManagerDriver


    public init             (driving driver: StorageManagerDriver) {

        self.driver = driver
    }


    public func     open    (from location: StorageManagerLocation) -> StorageEntryDirectory? {

        return driver.open(from: location)
    }
}

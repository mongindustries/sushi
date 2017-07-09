//
//  iosStorageManagerDriver.swift
//  apptest
//
//  Created by Michael Ong on 10/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

import sushicore
import sushistorage

class iosStorageEntryDirectory: StorageEntryDirectory {

    var         url         : URL = URL(fileURLWithPath: "")

    var         children    : [StorageEntry]? = nil


    func        contains    (_ relativeURL: URL) -> Bool {

        return false
    }

    func        open        (_ relativeURL: URL) -> StorageEntry? {

        return nil
    }

    func        create      (_ relativeURL: URL) -> StorageEntry? {

        return nil
    }
}

class iosStorageEntryFile: StorageEntryFile {

    var         isReadOnly  : Bool  = true

    var         url         : URL   = URL(fileURLWithPath: "")


    func        readStream  () -> Data? {

        return nil
    }

    func        writeStream () -> Data? {

        return nil
    }
}



class iosStorageManagerDriver: StorageManagerDriver {

    func        open        (from storageLocation: StorageManagerLocation) -> StorageEntryDirectory? {

        switch storageLocation {
        case .cloud:
            break

        case .local:
            break

        case .staging:
            break
        }

        return nil
    }
}

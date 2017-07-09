//
//  StorageEntry.swift
//  sushistorage
//
//  Created by Michael Ong on 9/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

public protocol StorageEntry {

    var     url         : URL { get set }
}

public protocol StorageEntryDirectory: StorageEntry {

    var     children    : [ StorageEntry ]? { get }


    func    contains    (_ relativeURL: URL) -> Bool


    func    open        (_ relativeURL: URL) -> StorageEntry?

    func    create      (_ relativeURL: URL) -> StorageEntry?
}

public protocol StorageEntryFile: StorageEntry {

    var     isReadOnly  : Bool { get set }


    func    readStream  () -> Data?

    func    writeStream () -> Data?
}

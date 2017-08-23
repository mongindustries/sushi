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


    func    contains    (_ relativeURL: String) -> Bool


    func    open        (_ relativeURL: String) -> StorageEntry?

    func    create      (_ relativeURL: String) -> StorageEntry?
}

public protocol StorageEntryFile: StorageEntry {

    var     isReadOnly  : Bool { get set }


    func    dataStream  ()-> Data?
}

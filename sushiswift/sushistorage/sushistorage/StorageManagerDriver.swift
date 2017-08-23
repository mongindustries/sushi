//
//  StorageManagerDriver.swift
//  sushistorage
//
//  Created by Michael Ong on 9/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

public protocol StorageManagerDriver: class {

    func open(from storageLocation: StorageManagerLocation) -> StorageEntryDirectory?
}


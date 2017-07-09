//
//  StorageEntry.swift
//  sushistorage
//
//  Created by Michael Ong on 9/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

public enum StorageEntryType {

    case directory
    case shortcut
    case link
    case file
}

public protocol StorageEntry {

}

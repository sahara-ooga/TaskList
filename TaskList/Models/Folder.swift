//
//  Folder.swift
//  TaskList
//
//  Created by yuu ogasawara on 2017/06/28.
//  Copyright © 2017年 stv. All rights reserved.
//

import UIKit
import RealmSwift

class Folder: Object {
    dynamic var folderID = 0
    dynamic var name = ""
    dynamic var lastModify = Date()
    let tasks = List<Task>()
    
    override static func primaryKey() -> String? {
        return "folderID"
    }
    
}

//
//  Task.swift
//  TaskManager
//
//  Created by yuu ogasawara on 2017/06/22.
//  Copyright © 2017年 stv. All rights reserved.
//

import Foundation
import RealmSwift

final class Task: Object {
    
    dynamic var taskID = 0
    dynamic var name = ""
    dynamic var lastModify = Date()
    
    override static func primaryKey() -> String? {
        return "taskID"
    }
}

//
//  TaskDaoTests.swift
//  TaskList
//
//  Created by yuu ogasawara on 2017/06/30.
//  Copyright © 2017年 stv. All rights reserved.
//

import XCTest
@testable import TaskList

class TaskDaoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TaskDao.deleteAll()
    }
    
    override func tearDown() {
        TaskDao.deleteAll()
        super.tearDown()
    }
    
    func testDeleteTask() {
        TaskDao.add("タスク名")
        TaskDao.delete(taskID: 1)
        verifyCount(count: 0)
    }
    
}

private extension TaskDaoTests{
    func verifyCount(count:Int) {
        let result = TaskDao.findAll()
        XCTAssertEqual(result.count, count)
    }
}

//
//  TaskTests.swift
//  TaskManagerTests
//
//  Created by yuu ogasawara on 2017/06/22.
//  Copyright © 2017年 stv. All rights reserved.
//

import XCTest
@testable import TaskList

class TaskTests: XCTestCase {
    
    let task = Task()
    
    //MARK:Life Cycle
    override func setUp() {
        super.setUp()
        TaskDao.deleteAll()
    }
    
    override func tearDown() {
        TaskDao.deleteAll()
        super.tearDown()
    }
    
    //MARK:Test
    func testTaskDefault() {
        XCTAssertEqual(task.taskID, 0)
        XCTAssertEqual(task.name, "")
        XCTAssertNotNil(task.lastModify)
    }
    
    /// タスクが設定できるか？
    func testSetMemo() {
        
        task.taskID = 1
        task.name = "タスク名"
        task.lastModify = string2Date("2017/01/01")
        
        verifyTask(taskID: 1,
                   name: "タスク名",
                   lastModify: "2017/01/01")
    }
    
    /// タスクが設定できるか？(名前なし）
    func testSetTask_NoName() {
        
        task.taskID = 1
        //task.name = ""
        task.lastModify = string2Date("2017/12/12")
        
        verifyTask(taskID: 1,
                   name: "",
                   lastModify: "2017/12/12")
    }
}

// MARK: - Helper
private extension TaskTests{
    func verifyTask(taskID: Int,
                    name: String,
                    lastModify: String) {
        
        XCTAssertEqual(task.taskID, taskID)
        XCTAssertEqual(task.name, name)
        XCTAssertEqual(task.lastModify, string2Date(lastModify))
    }
    
    /// タスククラスは、更新日をDate型で持っている一方、テストではstringが扱いやすいので橋渡しをする
    ///
    /// - Parameter dateString: テストで比較対象にする日時の文字列
    /// - Returns: Date型 yyyy/MM/dd
    func string2Date(_ dateString: String) -> Date{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.date(from: dateString)!
    }
}

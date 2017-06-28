//
//  FolderTest.swift
//  TaskList
//
//  Created by yuu ogasawara on 2017/06/28.
//  Copyright © 2017年 stv. All rights reserved.
//

import XCTest
@testable import TaskList
import RealmSwift

class FolderTests: XCTestCase {
    let folder = Folder()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK: Test Case
    func testFolderDefault() {
        XCTAssertEqual(folder.folderID, 0)
        XCTAssertEqual(folder.name, "")
        XCTAssertNotNil(folder.lastModify)
        XCTAssertTrue(folder.tasks.isEmpty)
    }
   
    /// フォルダが設定できるか？
    func testSetFolder() {
        
        let folderID = 0
        let name = "フォルダ名"
        let lastModify = "2017/01/01"
        
        let task = Task()
        task.taskID = 0
        task.name = "タスク"
        task.lastModify = string2Date("2017/01/01")
        
        let taskList = List<Task>()
        taskList.append(task)
        
        folder.folderID = folderID
        folder.name = name
        folder.lastModify = string2Date(lastModify)
        folder.tasks.append(task)

        verifyFolder(folderID: folderID,
                   name: name,
                   lastModify: lastModify,
                   tasks: taskList)
    }
    
    /// フォルダが設定できるか？(名前なし）
    func testSetFolder_NoName() {
        let folderID = 0
        let lastModify = "2017/05/01"
        
        let task = Task()
        task.taskID = 0
        task.name = "タスク"
        task.lastModify = string2Date("2017/12/01")
        
        let taskList = List<Task>()
        taskList.append(task)
        
        folder.folderID = folderID
        //folder.name = ""
        folder.lastModify = string2Date(lastModify)
        
        folder.tasks.append(task)
        
        verifyFolder(folderID: folderID,
                   name: "",
                   lastModify: lastModify,
                   tasks: taskList)
    }
}

// MARK: - Helper
private extension FolderTests{
    func verifyFolder(folderID: Int,
                    name: String,
                    lastModify: String,
                    tasks:List<Task>) {
        
        XCTAssertEqual(folder.folderID, folderID)
        XCTAssertEqual(folder.name, name)
        XCTAssertEqual(folder.lastModify, string2Date(lastModify))
        
        for (index,task) in folder.tasks.enumerated() {
            XCTAssertEqual(task, tasks[index])
        }
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

/*
extension Task:Equatable{
    func ==(lhs: Task, rhs: Task) -> Bool {
        return lhs.taskID == rhs.taskID && lhs.name == rhs.name && lhs.lastModify == rhs.lastModify
    }
}*/

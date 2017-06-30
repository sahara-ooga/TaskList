//
//  FolderDaoTests.swift
//  TaskList
//
//  Created by yuu ogasawara on 2017/06/29.
//  Copyright © 2017年 stv. All rights reserved.
//

import XCTest
@testable import TaskList
import RealmSwift

class FolderDaoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        FolderDao.deleteAll()
    }
    
    override func tearDown() {
        FolderDao.deleteAll()
        super.tearDown()
    }
    
    //MARK:Test Case
    /// 登録できるか確認する
    func testAddFolder() {
        FolderDao.add("新しいフォルダー")
        
        guard let folder = FolderDao.findAll().first else {
            return XCTFail("フォルダが生成されていない")
        }
        
        XCTAssertNotNil(folder.folderID)
        XCTAssertEqual(folder.name, "新しいフォルダー")
        XCTAssertNotNil(folder.lastModify)
    }
}

private extension FolderDaoTests{
        
    func verifyFolder(folderID: Int,
                      name: String,
                      lastModify: String,
                      tasks:List<Task>) {
        
        let result = FolderDao.findAll()
        
        guard let folder = result.first else {
            XCTFail("フォルダが生成されていない")
            return
        }
        
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
    
    func date2String(_ date:Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: date)
    }
}

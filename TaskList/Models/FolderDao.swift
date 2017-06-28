//
//  FolderDao.swift
//  TaskList
//
//  Created by yuu ogasawara on 2017/06/28.
//  Copyright © 2017年 stv. All rights reserved.
//

import Foundation
import RealmSwift

final class FolderDao{
    static let realmDaoHelper = RealmDaoHelper<Folder>()

    /// フォルダを登録する
    ///
    /// - Parameter folderName: ユーザーが指定したタスクの名称.
    static func add(_ folderName: String) {
        
        let object = Folder()
        object.memoID = MemoDao.realmDaoHelper.newId()!
        object.memo = memo
        object.lastModify = Date().now()
        
        MemoDao.realmDaoHelper.add(d: object)
    }

}

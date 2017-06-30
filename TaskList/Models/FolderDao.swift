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
    static let realmFolderDaoHelper = RealmDaoHelper<Folder>()
    
    /// 引数を名前に持つフォルダをDBに登録する
    ///
    /// - Parameter folderName: ユーザーが指定したフォルダの名称.
    static func add(_ folderName: String) {
        
        let object = Folder()
        object.folderID = FolderDao.realmFolderDaoHelper.newId()!
        object.name = folderName
        object.lastModify = Date()
        
        FolderDao.realmFolderDaoHelper.add(d: object)
    }

    
    /// フォルダ情報を更新する
    ///
    /// - Parameter model: フォルダのモデルクラス
    static func update(model:Folder){
        guard let target = realmFolderDaoHelper.findFirst(key: model.folderID as AnyObject) else {
            return
        }
        
        let object = Folder()
        object.folderID = target.folderID
        object.name = model.name
        object.lastModify = Date()
        _ = realmFolderDaoHelper.update(d: object)

    }
    
    /// 単一のフォルダを削除する
    ///
    /// - Parameter folderID: フォルダID
    static func delete(folderID: Int) {
        guard let object = realmFolderDaoHelper.findFirst(key: folderID as AnyObject) else { return }
        
        //関連したタスクを先に削除する（連動して削除されないので）
        for task in object.tasks{
            RealmDaoHelper<Task>().delete(d: task)
        }
        
        realmFolderDaoHelper.delete(d: object)
    }
    
    /// フォルダ(とタスク)を全て削除する
    static func deleteAll() {
        RealmDaoHelper<Task>().deleteAll()
        realmFolderDaoHelper.deleteAll()
    }
    
    /// 該当のフォルダを取得する
    ///
    /// - Parameter folderID: フォルダID
    /// - Returns: フォルダ
    static func findByID(folderID: Int) -> Folder? {
        return realmFolderDaoHelper.findFirst(key: folderID as AnyObject)
    }
    
    /// 全てのフォルダを取得する
    ///
    /// - Returns: フォルダモデルの配列.更新日時の降順でソート済み
    /// - precondition: フォルダが存在すること。存在しない場合実行時エラーになる
    static func findAll() -> [Folder] {
        let objects = FolderDao.realmFolderDaoHelper
            .findAll()
            .sorted(byKeyPath: "lastModify", ascending: false)
        return objects.map { Folder(value: $0) }
    }
}

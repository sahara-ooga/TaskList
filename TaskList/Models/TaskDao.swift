//
//  TaskDao.swift
//  TaskList
//
//  Created by yuu ogasawara on 2017/06/30.
//  Copyright © 2017年 stv. All rights reserved.
//

import Foundation
import RealmSwift

final class TaskDao{
    
    static let realmTaskDaoHelper = RealmDaoHelper<Task>()
    
    /// 引数を名前に持つタスクをDBに登録する
    ///
    /// - Parameter taskName: ユーザーが指定したタスクの名称.
    static func add(_ taskName: String) {
        
        let object = Task()
        object.taskID = realmTaskDaoHelper.newId()!
        object.name = taskName
        object.lastModify = Date()
        
        realmTaskDaoHelper.add(d: object)
    }
    
    
    /// タスク情報を更新する
    ///
    /// - Parameter model: タスクのモデルクラス
    static func update(model:Task){
        guard let target = realmTaskDaoHelper.findFirst(key: model.taskID as AnyObject) else {
            return
        }
        
        let object = Task()
        object.taskID = target.taskID
        object.name = model.name
        object.lastModify = Date()
        _ = realmTaskDaoHelper.update(d: object)
        
    }
    
    /// 単一のタスクを削除する
    ///
    /// - Parameter taskID: タスクID
    static func delete(taskID: Int) {
        guard let object = TaskDao.realmTaskDaoHelper.findFirst(key: taskID as AnyObject) else { return }

        realmTaskDaoHelper.delete(d: object)
    }
    
    /// タスクを全て削除する
    static func deleteAll() {
        TaskDao.realmTaskDaoHelper.deleteAll()
    }
    
    /// 該当のタスクを取得する
    ///
    /// - Parameter taskID: タスクID
    /// - Returns: タスク
    static func findByID(taskID: Int) -> Task? {
        return TaskDao.realmTaskDaoHelper.findFirst(key: taskID as AnyObject)
    }
    
    /// 全てのタスクを取得する
    ///
    /// - Returns: タスクモデルの配列.更新日時の降順でソート済み
    /// - precondition: タスクが存在すること。
    static func findAll() -> [Task] {
        let objects = TaskDao.realmTaskDaoHelper
            .findAll()
            .sorted(byKeyPath: "lastModify", ascending: false)
        return objects.map { Task(value: $0) }
    }
}

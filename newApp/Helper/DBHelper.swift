//
//  DBHelper.swift
//  newApp
//
//  Created by Pablo De La Cruz on 2/16/22.
//

import Foundation
import SQLite3

class DBHelper {
    var db : OpaquePointer?
    var path : String = "myDb.sqlite"
    init() {
        self.db = createDB()
        self.createTable()
    }
    
    func createDB() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(path)
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("There is an error creating DB")
            return nil
            
        }else {
            print("Database has been created with path \(path)")
            return db
        }
    }
    
    func createTable(){
        let query = "CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, password TEXT);"
        
        var createTable : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &createTable, nil) == SQLITE_OK {
            if sqlite3_step(createTable) == SQLITE_DONE{
                print("Table Creation SUCCESS")
            } else {
                print("Table Creation FAILED")
            }
        }else {
            print("Table Preparation Failed")
        }
    }
}

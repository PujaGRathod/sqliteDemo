//
//  ViewController.swift
//  sqliteDemo
//
//  Created by Puja Rathod on 15/06/19.
//  Copyright © 2019 Puja Rathod. All rights reserved.
//

import UIKit
import SQLite3
//https://www.appcoda.com/fmdb-sqlite-database/
//http://www.theappguruz.com/blog/use-sqlite-database-swift
//http://www.sqlitetutorial.net/sqlite-update/
//https://www.simplifiedios.net/swift-sqlite-tutorial/
//https://www.sitepoint.com/managing-data-in-ios-apps-with-sqlite/
class ViewController: UIViewController {
    var marrStudentData : NSMutableArray!
    var db: OpaquePointer?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.createDBFile()
    }
    func getStudentData()
    {
        marrStudentData = NSMutableArray()
        marrStudentData = ModelManager.getInstance().getAllStudentData()
        
    }
    
    
    @IBAction func btnSaveClicked(_ sender: Any) {
        
        let studentInfo: StudentInfo = StudentInfo()
        studentInfo.Name = "Puja"
        studentInfo.Marks = "Abcd"
        let isInserted = ModelManager.getInstance().addStudentData(studentInfo: studentInfo)
        if isInserted {
            Util.invokeAlertMethod(strTitle: "", strBody: "Record Inserted successfully.", delegate: nil)
        } else {
            Util.invokeAlertMethod(strTitle: "", strBody: "Error in inserting record.", delegate: nil)
        }
        
//        //creating a statement
//        var stmt: OpaquePointer?
//
//        //the insert query
//        let queryString = "INSERT INTO Heroes (name, powerrank) VALUES (?,?)"
//
//        //preparing the query
//        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
//            let errmsg = String(cString: sqlite3_errmsg(db)!)
//            print("error preparing insert: \(errmsg)")
//            return
//        }
//
//        //binding the parameters
//        if sqlite3_bind_text(stmt, 1, "Puja", -1, nil) != SQLITE_OK{
//            let errmsg = String(cString: sqlite3_errmsg(db)!)
//            print("failure binding name: \(errmsg)")
//            return
//        }
//
//        if sqlite3_bind_int(stmt, 2, 123) != SQLITE_OK{
//            let errmsg = String(cString: sqlite3_errmsg(db)!)
//            print("failure binding name: \(errmsg)")
//            return
//        }
//
//
//        if sqlite3_bind_int(stmt, 3, 1111) != SQLITE_OK{
//            let errmsg = String(cString: sqlite3_errmsg(db)!)
//            print("failure binding name: \(errmsg)")
//            return
//        }
//
//        //executing the query to insert values
//        if sqlite3_step(stmt) != SQLITE_DONE {
//            let errmsg = String(cString: sqlite3_errmsg(db)!)
//            print("failure inserting hero: \(errmsg)")
//            return
//        }
    }
}


extension ViewController {
    
    func createDBFile() {
       let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("DemoTest.sqlite")
        print("fileURL:- \(fileURL)")
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        } else {
            print("database opened success fully")
            self.createTable(tblName: "TblTest")
        }
    }
    
    func createTable(tblName:String) {
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS \(tblName) (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, powerrank INTEGER,rank INTEGER)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        } else {
            print("table isCreated")
        }
    }
}

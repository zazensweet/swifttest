//
//  SecondViewController.swift
//  tabtest
//
//  Created by Shinichiro Yamamoto on 2015/12/01.
//  Copyright © 2015年 shinichiro yamamoto. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // セクションのタイトル情報
    let testSection = ["ひらがな", "カタカナ"]
    
    // セルの中の情報
    let testArray = [
        ["あいうえお", "かきくけこ", "さしすせそ"],
        ["アイウエオ", "カキクケコ", "サシスセソ"]
    ]
    
    // セルの大グループ（セクション）の数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return testArray.count
    }
    
    // セクションのタイトル
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return testSection[section]
    }
    
    // セルの小グループの数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray[section].count
    }
    
    // セルの文字
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "myCell")

        cell.textLabel?.text = String(testArray[indexPath.section][indexPath.row])
        return cell
    }
    
    
    /*
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "myCell")
        cell.textLabel?.text = testArray[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let testA = Int(testArray.count)
        return testA
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


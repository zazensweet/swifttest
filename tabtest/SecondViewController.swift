//
//  SecondViewController.swift
//  tabtest
//
//  Created by Shinichiro Yamamoto on 2015/12/01.
//  Copyright © 2015年 shinichiro yamamoto. All rights reserved.
//

import UIKit


class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    // テーブルビュー
    @IBOutlet var testTable: UITableView!

    

    // JSONを格納
    private var jsonData = [[String:AnyObject]]()
    
    // JSONデータ
    private let jsonString:String = "[{\"title\": \"Section1\", \"data\": [\"section1-1\",\"section1-2\",\"section1-3\",\"section1-4\"]},{\"title\": \"Section2\", \"data\": [\"section2-1\",\"section2-2\",\"section2-3\",\"section2-4\"]},{\"title\": \"Section3\", \"data\": [\"section3-1\",\"section3-2\",\"section3-3\",\"section3-4\"]},{\"title\": \"Section4\", \"data\": [\"section4-1\",\"section4-2\",\"section4-3\",\"section4-4\"]}]"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // テーブルビューのデリゲートを設定する
        testTable.delegate = self
        
        // テーブルビューのデータソースを設定する
        testTable.dataSource = self
        
        // チェック
        do {
            // JSON文字列をNSDataに変換
            let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding)
            // NSDataを配列に変換して格納
            jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! Array
            print(jsonData)
        } catch {
            print("error: \(error)")
        }
        
        
    }
    
    
    
    // セクションの個数を返す
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return jsonData.count
    }
    
    // セクション毎の行数を返す
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonData[section]["data"] == nil ? 0 : jsonData[section]["data"]!.count
    }
    
    // セクションのタイトルを返す
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(jsonData[section]["title"]!)
    }

    // 各行のセルを返す
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // セルを用意する
        let cell = UITableViewCell(style:.Default, reuseIdentifier: "cell")
        if jsonData[indexPath.section]["data"] == nil {
            return cell
        }
        cell.textLabel?.text = jsonData[indexPath.section]["data"]![indexPath.row] == nil ? "-" : String(jsonData[indexPath.section]["data"]![indexPath.row])
        return cell
        
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


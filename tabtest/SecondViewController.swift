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

    
    //// 「　NewFile　→　Other　→　Empty　」JSONデータ（jsondata.json）を作成して試してみる。
    var json:NSArray!
    
    func getJson() {
        
        // let URL:NSURL = NSURL(string: "https://")!
        // let jsonData :NSData = NSData(contentsOfURL: URL)!
        
        // 擬似的にJSONデータを読む
        let path = NSBundle.mainBundle().pathForResource("jsondata", ofType: "json")
        let myjson = NSData(contentsOfFile: path!)
        do {
            json = try NSJSONSerialization.JSONObjectWithData(myjson!, options: .MutableContainers) as! NSArray
        } catch  {
            // エラー処理
        }
        
        // 反応を見てみる
        
        print("オプショナルなまま取り出す：\(json[0]["title"])")
        print("オプショナルなまま取り出す：\(json[0]["data"])")
        
        if let hoge = json[1]["data"] as? NSArray {
            print("as? NSArrayにして取り出す（オプショナルじゃなくなる）：\(hoge[0])")
        } else {
            print("fail")
        }

    }
    
    
    
    ////// とりあえずの措置としてJSONを使わず。。
    // セクションのタイトル情報
    let sectionTitle = ["Section1", "Section2", "Section3", "Section4"]
    
    // セル情報
    let tableData = [
        ["section1-1", "section1-2", "section1-3", "section1-4"],
        ["section2-1", "section2-2", "section2-3", "section2-4"],
        ["section3-1", "section3-2", "section3-3", "section3-4"],
        ["section4-1", "section4-2", "section4-3", "section4-4"]
    ]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // テーブルビューのデリゲートを設定する
        testTable.delegate = self
        
        // テーブルビューのデータソースを設定する
        testTable.dataSource = self
        
        //// JSON的な試し
        getJson()
        
    }
    
    
    
    /*　UITableViewDataSourceプロトコル */
    
    // セクションの個数を決める
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    // セクション内の行数を決める
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = tableData[section]
        return sectionData.count
    }
    
    // セクションのタイトルを決める
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    // セルを作る
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // セルを用意する
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "myCell")
        // セクションの内容を取り出す
        let sectionData = tableData[indexPath.section]
        // セクションの内容かセルに入れる情報を取り出す
        let cellData = sectionData[indexPath.row]
        // 用意されたセルに情報入れる
        cell.textLabel?.text = cellData
        return cell
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  FirstViewController.swift
//  tabtest
//
//  Created by Shinichiro Yamamoto on 2015/12/01.
//  Copyright © 2015年 shinichiro yamamoto. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    // ラベル
    @IBOutlet weak var txtChange: UILabel!
    
    // テキストフィールド
    @IBOutlet weak var testTextField: UITextField!
    
    // スクロールビュー
    @IBOutlet weak var scvBackGround: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // テキストフィールドとラベルの初期化
        testTextField.text = ""
        txtChange.text = ""
        testTextField.layer.borderWidth = 4
        testTextField.layer.borderColor = UIColor.grayColor().CGColor
        
        // ラベルを可変
        txtChange.sizeToFit()
        
    }
    
    
    
    @IBAction func realTimeText() {
        
        // テキストフィールドに入力するとリアルタイムにラベルに反映される
        txtChange.text = testTextField.text
        
        // テキストフィールドの文字数を取得
        let countTF = Int(testTextField.text!.characters.count)
        print(countTF)
        
        // 文字数が10以下は枠線黒、11以上は枠線赤
        if countTF <= 10 {
            print("10以下")
            testTextField.layer.borderColor = UIColor.blackColor().CGColor
        } else {
            print("11以上")
            testTextField.layer.borderColor = UIColor.redColor().CGColor
        }
        
    }
    
    
    // リターンするとキーボードを閉じる
    @IBAction func keyClose() {
    }
    
    
    
    
    
    // テキストフィールドタップ
    func textFieldShouldBeginEditing(textField: UITextField!) -> Bool {
        testTextField = textField
        return true
    }
    
    // テキストフィールドリターン
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func handleKeyboardWillShowNotification(notification: NSNotification) {
        
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let myBoundSize: CGSize = UIScreen.mainScreen().bounds.size
        
        let txtLimit = testTextField.frame.origin.y + testTextField.frame.height + 8.0
        let kbdLimit = myBoundSize.height - keyboardScreenEndFrame.size.height
        
        if txtLimit >= kbdLimit {
            scvBackGround.contentOffset.y = txtLimit - kbdLimit
        }
        
    }
    
    func handleKeyboardWillHideNotification(notification: NSNotification) {
        scvBackGround.contentOffset.y = 0
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "handleKeyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "handleKeyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


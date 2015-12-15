//
//  FirstViewController.swift
//  tabtest
//
//  Created by Shinichiro Yamamoto on 2015/12/01.
//  Copyright © 2015年 shinichiro yamamoto. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {
    
    
    
    // ラベル
    @IBOutlet weak var txtChange: UILabel!
    
    // テキストフィールド
    @IBOutlet weak var testTextField: UITextField!
    
    // スクロールビュー
    @IBOutlet weak var scvBackGround: UIScrollView!
    
    // 通知センターのインスタンス
    let notificationCenter = NSNotificationCenter.defaultCenter()
    
    // アクティブなテキストフィールド
    var activeTextField = UITextField()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // テキストフィールドのdelegate設定
        testTextField.delegate = self
        
        // テキストフィールドの初期設定
        testTextField.text = ""
        testTextField.layer.borderWidth = 4
        testTextField.layer.borderColor = UIColor.grayColor().CGColor
        
        // ラベルの初期設定
        txtChange.text = "テキストフィールドの文字が反映される"
        txtChange.layer.borderWidth = 1
        txtChange.layer.borderColor = UIColor.grayColor().CGColor
        txtChange.sizeToFit()
        
    }
    
    
    
    // デリゲートメソッド：テキストフィールドに改行が入力された時
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        // キーボードを閉じる
        self.view.endEditing(true)
        
        // 改行の入力を行わない
        return false
        
    }
    
    
    
    // デリゲートメソッド：テキストフィールドが入力状態になった時
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        // アクティブなテキストフィールドをセット
        activeTextField = textField
        return true
        
    }
    
    
    
    // 画面が表示される直前に実行されるメソッド
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // キーボードの表示時：イベントハンダラとしてaddObserverで登録
        notificationCenter.addObserver(self, selector: "handleKeyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        
        // キーボードの非表示時：イベントハンダラとしてaddObserverで登録
        notificationCenter.addObserver(self, selector: "handleKeyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
        
        // テキストフィールド変更時：イベントハンダラとしてaddObserverで登録
        notificationCenter.addObserver(self, selector: "handleTextFieldDidChange:", name: UITextFieldTextDidChangeNotification, object: nil)
        
        // テキストフィールド編集終了時：イベントハンダラとしてaddObserverで登録
        notificationCenter.addObserver(self, selector: "handleTextFieldDidEndEditing:", name: UITextFieldTextDidEndEditingNotification, object: nil)
        
    }
    
    
    
    // 別の画面に遷移した直後に実行されるメソッド
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        // キーボードの表示時：removeObserverで解除
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        
        // キーボードの非表示時：removeObserverで解除
        notificationCenter.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
        // テキストフィールド変更時：removeObserverで解除
        notificationCenter.removeObserver(self, name: UITextFieldTextDidChangeNotification, object: nil)
        
        // テキストフィールド編集終了時：removeObserverで解除
        notificationCenter.removeObserver(self, name: UITextFieldTextDidEndEditingNotification, object: nil)
        
    }
    
    
    
    // テキストフィールド変更時：実行されるメソッド
    func handleTextFieldDidChange(notification: NSNotification) {
        
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
        
        // ラベルにテキストフィールドの内容を反映
        txtChange.text = testTextField.text
        
    }
    
    
    
    // テキストフィールド編集終了時：実行されるメソッド
    func handleTextFieldDidEndEditing(notification: NSNotification) {
        
        // ラベルにテキストフィールドの内容を反映
        txtChange.text = testTextField.text
        
    }
    
    
    
    // キーボードの表示時：実行されるメソッド
    func handleKeyboardWillShowNotification(notification: NSNotification) {
        
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let boundSize: CGSize = UIScreen.mainScreen().bounds.size
        
        // テキストフィールドの下位置
        let textFieldPositionBottom = activeTextField.frame.origin.y + activeTextField.frame.height
        
        // キーボードの上位置
        let keyboardPositionTop = boundSize.height - keyboardScreenEndFrame.size.height
        
        // スクロールビューを移動させる
        if textFieldPositionBottom >= keyboardPositionTop {
            scvBackGround.contentOffset.y = (textFieldPositionBottom + 8.0) - keyboardPositionTop
        }
        
    }
    
    
    
    // キーボードの非表示時：実行されるメソッド
    func handleKeyboardWillHideNotification(notification: NSNotification) {
        scvBackGround.contentOffset.y = 0
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ThirdViewController.swift
//  tabtest
//
//  Created by Shinichiro Yamamoto on 2015/12/09.
//  Copyright © 2015年 shinichiro yamamoto. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UITextFieldDelegate {

    
    
    // ラベル：Eメール
    @IBOutlet weak var labelEmail: UILabel!
    
    // ラベル：パスワード
    @IBOutlet weak var labelPassword: UILabel!
    
    // ラベル：自由
    @IBOutlet weak var labelFree: UILabel!
    
    // テキストフィールド：Eメール
    @IBOutlet weak var textFieldEmail: UITextField!
    
    // テキストフィールド：パスワード
    @IBOutlet weak var textFieldPassword: UITextField!
    
    // テキストフィールド：自由
    @IBOutlet weak var textFieldFree: UITextField!
    
    // スクロールビュー
    @IBOutlet weak var scvBG: UIScrollView!
    
    
    
    // タグ：ナンバリング
    let textFieldEmailTag: Int = 1
    let textFieldPasswordTag: Int = 2
    let textFieldFreeTag: Int = 3
    

    
    // 通知センターのインスタンス
    let notificationCenter = NSNotificationCenter.defaultCenter()
    
    // アクティブなテキストフィールド
    var activeTextField = UITextField()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // テキストフィールドのdelegate設定
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
        textFieldFree.delegate = self
        
        // テキストフィールドにタグを設定
        textFieldEmail.tag = textFieldEmailTag
        textFieldPassword.tag = textFieldPasswordTag
        textFieldFree.tag = textFieldFreeTag
    
        // テキストフィールド：パスワード：非表示
        textFieldPassword.secureTextEntry = true
        
        // ラベルの初期設定
        labelEmail.text = ""
        labelPassword.text = ""
        labelFree.text = ""

    }
    
    
    
    // デリゲートメソッド：テキストフィールドが入力状態になった時
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        // アクティブなテキストフィールドをセット
        activeTextField = textField
        return true
        
    }
    
    
    
    // デリゲートメソッド：テキストフィールドに改行が入力された時
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        switch textField.tag {
            
        case textFieldEmailTag:
            // 次のケースと合わせて処理するためスルー
            fallthrough
            
        case textFieldPasswordTag:
            // 次のテキストフィールドをフォーカスさせる
            view.viewWithTag(textField.tag + 1)!.becomeFirstResponder()
            // テキスト反映処理
            setText()
            
        default:
            // その他は、キーボードを閉じる
            self.view.endEditing(true)
            //テキスト反映処理
            setText()
            
        }
        
        // 改行の入力を行わない
        return false
        
    }
    
    // テキスト反映処理
    func setText() {
        labelEmail.text = textFieldEmail.text
        labelPassword.text = textFieldPassword.text
        labelFree.text = textFieldFree.text
    }
    
    
    
    // 画面が表示される直前に実行されるメソッド
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // キーボードの表示時：イベントハンダラとしてaddObserverで登録
        notificationCenter.addObserver(self, selector: "handleKeyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        
        // キーボードの非表示時：イベントハンダラとしてaddObserverで登録
        notificationCenter.addObserver(self, selector: "handleKeyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // 別の画面に遷移した直後に実行されるメソッド
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        // キーボードの表示時：removeObserverで解除
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        
        // キーボードの非表示時：removeObserverで解除
        notificationCenter.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
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
            scvBG.contentOffset.y = (textFieldPositionBottom + 8.0) - keyboardPositionTop
        }
        
    }
    
    // キーボードの非表示時：実行されるメソッド
    func handleKeyboardWillHideNotification(notification: NSNotification) {
        scvBG.contentOffset.y = 0
    }
    
    
    
    // 画面をタップ：キーボード下げる
    @IBAction func tapView(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

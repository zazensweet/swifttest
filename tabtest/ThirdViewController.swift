//
//  ThirdViewController.swift
//  tabtest
//
//  Created by Shinichiro Yamamoto on 2015/12/09.
//  Copyright © 2015年 shinichiro yamamoto. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    
    
    // スクロールビュー
    @IBOutlet weak var scvBG: UIScrollView!
    
    
    
    // テキストフィールド：Eメール
    @IBOutlet weak var textFieldEmail: UITextField!
    
    // テキストフィールド：パスワード
    @IBOutlet weak var textFieldPassword: UITextField!
    
    // テキストフィールド：自由
    @IBOutlet weak var textFieldFree: UITextField!
    
    
    
    // ラベル：Eメール
    @IBOutlet weak var labelEmail: UILabel!
    
    // ラベル：パスワード
    @IBOutlet weak var labelPassword: UILabel!
    
    // ラベル：自由
    @IBOutlet weak var labelFree: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        // テキストフィールド：パスワード：非表示
        textFieldPassword.secureTextEntry = true
        
        
        
    }
    
    
    
    // 画面をタップ：キーボード下げる
    @IBAction func tapView(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    

    
    func handleKeyboardWillShowNotification(notification: NSNotification) {
        
        // フォーカスしてるテキストフィールドを調べてswitchで振り分ける？？
        // var slctTextField =
        
        
        
        // userInfo
        let userInfo = notification.userInfo!
        
        // キーボードの表示完了時の位置と大きさ
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        // 画面のサイズ
        let myBoundSize: CGSize = UIScreen.mainScreen().bounds.size
        
        // （A）「画面上部」から「テキストフィールドの下」までの距離　＋　余白として８
        // エラー回避のため一旦「textFieldEmail」を入れてる
        let txtLimit = textFieldEmail.frame.origin.y + textFieldEmail.frame.height + 8.0
        
        // （B）「画面上部」から「表示されたキーボードの上」までの距離
        let kbdLimit = myBoundSize.height - keyboardScreenEndFrame.size.height
        
        // （A）の方が長いとき（B）
        if txtLimit >= kbdLimit {
            
            // スクロール位置：Y：差分
            scvBG.contentOffset.y = txtLimit - kbdLimit
            
        }
        
    }
    
    
    
    func handleKeyboardWillHideNotification(notification: NSNotification) {
        
        // スクロール位置：Y：0
        scvBG.contentOffset.y = 0
        
    }
    
    
    
    // 画面が表示される直前
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 通知
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        
        notificationCenter.addObserver(self, selector: "handleKeyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        
        notificationCenter.addObserver(self, selector: "handleKeyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    
    
    // 別の画面に遷移した直後
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        // 通知
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        // 通知：削除
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        
        // 通知：削除
        notificationCenter.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

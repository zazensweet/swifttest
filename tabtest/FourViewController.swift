//
//  FourViewController.swift
//  tabtest
//
//  Created by Shinichiro Yamamoto on 2015/12/18.
//  Copyright © 2015年 shinichiro yamamoto. All rights reserved.
//

import UIKit

class FourViewController: UIViewController, UIWebViewDelegate {

    
    // WebView
    @IBOutlet weak var testWebView: UIWebView!
    
    // textView
    @IBOutlet weak var testTextView: UITextView!
    
    // URL入力テキストフィールド
    @IBOutlet weak var urlTextField: UITextField!
    
    // 戻るボタン
    @IBOutlet weak var returnButton: UIButton!
    
    // 進むボタン
    @IBOutlet weak var nextButton: UIButton!
    
    // 更新ボタン
    @IBOutlet weak var refresh: UIButton!
    
    // Goボタン
    @IBOutlet weak var urlButton: UIButton!
    
    // APIボタン
    @IBOutlet weak var apiButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testWebView.delegate = self
        
        urlTextField.text = "https://www.apple.com/jp"
        
    }
    
    
    // 戻るボタンをタップした時
    @IBAction func returnPage() {
        testWebView.goBack()
    }
    
    
    // 進むボタンをタップした時
    @IBAction func nextPage() {
        testWebView.goForward()
    }
    
    
    // 更新ボタンをタップした時
    @IBAction func refreshPage() {
        testWebView.reload()
    }
    
    
    // Goボタンをタップした時
    @IBAction func goURL() {
        
        // URL
        let targetURL = urlTextField.text
        // URLの設定
        let requestURL = NSURL(string: targetURL!)
        // リクエストの作成
        let req = NSURLRequest(URL: requestURL!)
        // リクエストの実行
        testWebView.loadRequest(req)
        
    }
    
    
    // ページがすべて読み込み終わった時呼ばれるデリゲートメソッド
    func webViewDidFinishLoad(webView: UIWebView) {
    }
    
    // ページがloadされ始めた時、呼ばれるデリゲートメソッド
    func webViewDidStartLoad(webView: UIWebView) {
    }
    
    
    
/*
    // apiButtonをタップした時
    @IBAction func getApi() {
        
        let targetURL = urlTextField.text
        let requestURL = NSURL(string: targetURL!)
        let req = NSURLRequest(URL: requestURL!)
        
        NSURLConnection.sendAsynchronousRequest(request: req, queue: .MainQueue, completionHandler: dispStations)
        
    }
*/

    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

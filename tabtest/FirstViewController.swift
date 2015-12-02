//
//  FirstViewController.swift
//  tabtest
//
//  Created by Shinichiro Yamamoto on 2015/12/01.
//  Copyright © 2015年 shinichiro yamamoto. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var txtChange: UILabel!
    
    @IBOutlet weak var testTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        txtChange.text = "テキストをプログラムから変更テキストをプログラムから変更テキストをプログラムから変更"
        txtChange.sizeToFit()
        
    }

    @IBAction func realTimeText() {
        txtChange.text = testTextField.text
    }
    
    @IBAction func keyClose() {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


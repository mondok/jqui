//
//  ViewController.swift
//  jqui
//
//  Created by Matthew Mondok on 8/31/15.
//  Copyright (c) 2015 Matthew Mondok. All rights reserved.
//

import Cocoa

class JsonProcessViewController: NSViewController {
    
    @IBOutlet var jqQueryOutput: NSTextView!
    @IBOutlet weak var jqQueryTextField: NSTextField!
    @IBOutlet var jsonInputTextView: NSTextView!
    
    var _queryRunner:QueryRunner = QueryRunner()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @IBAction func processJson(sender: AnyObject) {
        let output = _queryRunner.runTask(jsonInputTextView.string!, query: jqQueryTextField.stringValue)
        jqQueryOutput.string = output
    }
    
   
    
}


//
//  JsonProcessViewController.swift
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
    @IBOutlet weak var nameTextField: NSTextFieldCell!
    
    var _queryRunner:QueryRunner = QueryRunner()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var representedObject: AnyObject? {
        didSet {        }
    }
    @IBAction func prettifyTapped(sender: AnyObject) {
        var inputText = jsonInputTextView.string!
        jsonInputTextView.string = JsonUtils.prettyPrint(inputText)
    }
    
    @IBAction func processJsonTapped(sender: AnyObject) {
        var inputText = jsonInputTextView.string!
        var query = jqQueryTextField.stringValue
        
        if !JsonUtils.isValidJson(inputText){
            showError("Invalid JSON entered")
            return
        }
        if query == "" {
            showError("Please enter a query")
            return
        }
        
        let output = _queryRunner.runTask(inputText, query: query)
        jqQueryOutput.string = output
        
    }
    
    func showError(err:String){
        var alert = NSAlert()
        alert.informativeText = err
        alert.runModal()
    }
    
    
}


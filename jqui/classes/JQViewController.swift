//
//  ViewController.swift
//  jqui
//
//  Created by Matthew Mondok on 9/27/15.
//  Copyright © 2015 Matthew Mondok. All rights reserved.
//

import Cocoa

class JQViewController: NSViewController {


    
    @IBOutlet var jqOutputTextView: NSTextView!
    @IBOutlet var jsonInputTextView: NSTextView!
    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var jqQueryTextField: NSTextField!

    
    let _queryRunner:JQQueryRunner = JQQueryRunner()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        loadDoc()
    }
    
    func loadDoc(){
        let doc = document()
        nameTextField.stringValue = doc.savedName
        jqQueryTextField.stringValue = doc.query
        jqOutputTextView.string = doc.queryResult
        jsonInputTextView.string = doc.originalJson
    }
    
    override var representedObject: AnyObject? {
        didSet {        }
    }
    
    func document() -> JQDocument{
        let doc = self.view.window?.windowController?.document as! JQDocument
        if doc.savedName.characters.count == 0{
            doc.savedName = "Untitled"
        }
        return doc
    }
    
    @IBAction func prettifyTapped(sender: AnyObject) {
        let inputText = jsonInputTextView.string!
        jsonInputTextView.string = JQJsonUtils.prettyPrint(inputText)
    }
    
    @IBAction func processJsonTapped(sender: AnyObject) {
        let inputText = jsonInputTextView.string!
        let query = jqQueryTextField.stringValue
        
        if !JQJsonUtils.isValidJson(inputText){
            showError("Invalid JSON entered")
            return
        }
        if query == "" {
            showError("Please enter a query")
            return
        }
        
        let output = _queryRunner.runTask(inputText, query: query)
        jqOutputTextView.string = output
        
    }
    
    func showError(err:String){
        let alert = NSAlert()
        alert.informativeText = err
        alert.runModal()
    }


}


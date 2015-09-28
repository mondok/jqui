//
//  Document.swift
//  jqui
//
//  Created by Matthew Mondok on 9/27/15.
//  Copyright © 2015 Matthew Mondok. All rights reserved.
//

import Cocoa

class JQDocument: NSDocument {
    var savedName:String = ""
    var originalJson:String = ""
    var query:String = ""
    var queryResult:String = ""
    
    var _contentViewControler:JQViewController?
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }
    
    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
        // Add any code here that needs to be executed once the windowController has loaded the document's window.
    }
    
    override class func autosavesInPlace() -> Bool {
        return true
    }
    
    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let windowController = storyboard.instantiateControllerWithIdentifier("Document Window Controller") as! NSWindowController
        _contentViewControler = windowController.contentViewController as? JQViewController
        self.addWindowController(windowController)
    }
    
    override func dataOfType(typeName: String) throws -> NSData {
        var obj = [String: String]()
        if _contentViewControler != nil{
         obj = ["s": _contentViewControler!.nameTextField.stringValue,
            "o": safeString(_contentViewControler!.jsonInputTextView.string!),
            "q": _contentViewControler!.jqQueryTextField.stringValue,
            "qr": safeString(_contentViewControler!.jqOutputTextView.string!)]
        }
        
        let json = JQJsonUtils.jsonStringify(obj)
        return json.dataUsingEncoding(NSUTF8StringEncoding)!
    }
    
    override func readFromData(data: NSData, ofType typeName: String) throws {
        var obj:[String:String]
        
        
        if let json = NSString(data: data, encoding: NSUTF8StringEncoding){
            let str = String(json)
            obj = convertStringToDictionary(str)!
            savedName = obj["s"]!
            originalJson = obj["o"]!
            query = obj["q"]!
            queryResult = obj["qr"]!
        }
        
    }
    
    func safeString(str: String?) -> String{
        if str == nil{
            return ""
        }
        return str!
    }
    
    func convertStringToDictionary(jsonStr: String) -> [String:String]? {
        let data = jsonStr.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
            
            if let dict = json as? [String: String] {
                return dict
            }
            
        }
        catch {
            print(error)
        }
        return nil
    }
    
    
}


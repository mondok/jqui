//
//  JQSavedQuery.swift
//  jqui
//
//  Created by Matthew Mondok on 9/9/15.
//  Copyright (c) 2015 Matthew Mondok. All rights reserved.
//

import Cocoa

class JQSavedQuery: NSDocument {
    var savedName:String = ""
    var originalJson:String = ""
    var query:String = ""
    var queryResult:String = ""
    
    init(name:String, json:String, query:String){
        self.savedName = name
        self.originalJson = json
        self.query = query
    }
    
    func saveToDisk(pathAndName:String){
        let strVal = JsonUtils.jsonStringify(self, prettyPrinted: false)
        strVal.writeToFile(pathAndName, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
    }
    
    class func loadFromDisk(pathAndName:String) -> JQSavedQuery? {
        var obj:JQSavedQuery?
        if let strVal = NSString(contentsOfFile: pathAndName, encoding: NSUTF8StringEncoding, error: nil){
            obj = JsonUtils.jsonToAny(strVal as String, err: nil) as! JQSavedQuery?
        }
        return obj
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
        let storyboard = NSStoryboard(name: "Main", bundle: nil)!
        let windowController = storyboard.instantiateControllerWithIdentifier("Document Window Controller") as! NSWindowController
        self.addWindowController(windowController)
    }
    
    override func dataOfType(typeName: String, error outError: NSErrorPointer) -> NSData? {
        // Insert code here to write your document to data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning nil.
        // You can also choose to override fileWrapperOfType:error:, writeToURL:ofType:error:, or writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
        outError.memory = NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        return nil
    }
    
    override func readFromData(data: NSData, ofType typeName: String, error outError: NSErrorPointer) -> Bool {
        // Insert code here to read your document from the given data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning false.
        // You can also choose to override readFromFileWrapper:ofType:error: or readFromURL:ofType:error: instead.
        // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
        outError.memory = NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        return false
    }
}

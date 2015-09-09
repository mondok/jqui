//
//  JQSavedQuery.swift
//  jqui
//
//  Created by Matthew Mondok on 9/9/15.
//  Copyright (c) 2015 Matthew Mondok. All rights reserved.
//

import Cocoa

class JQSavedQuery: NSObject {
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
}

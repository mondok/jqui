//
//  JsonUtils.swift
//  jqui
//
//  Created by Matthew Mondok on 8/31/15.
//  Copyright (c) 2015 Matthew Mondok. All rights reserved.
//

import Foundation


class JsonUtils{
    class func isValidJson(str:String)->Bool{
        var error: NSError?
        jsonToAny(str, err: &error)
        return error == nil
    }
    
    class func prettyPrint(str:String)->String{
        var error: NSError?
        if let obj:AnyObject = jsonToAny(str, err: &error){
            return jsonStringify(obj, prettyPrinted: true)
        }
        return str
    }
    
    class func jsonStringify(value: AnyObject, prettyPrinted: Bool = false) -> String {
        var options = prettyPrinted ? NSJSONWritingOptions.PrettyPrinted : nil
        if NSJSONSerialization.isValidJSONObject(value) {
            if let data = NSJSONSerialization.dataWithJSONObject(value, options: options, error: nil) {
                if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    return string as String
                }
            }
        }
        return ""
    }
    
    class func jsonToAny(str:String, err:NSErrorPointer) -> AnyObject?{
        var data = str.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        let obj : AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: err)
        return obj
    }
}
//
//  JQJsonUtils.swift
//  jqui
//
//  Created by Matthew Mondok on 8/31/15.
//  Copyright (c) 2015 Matthew Mondok. All rights reserved.
//

import Foundation


class JQJsonUtils{
    class func isValidJson(str:String)->Bool{
        var error: NSError?
        do {
            try jsonToAny(str)
        } catch let error1 as NSError {
            error = error1
        }
        return error == nil
    }
    
    class func prettyPrint(str:String)->String{
        do {
            let obj:AnyObject = try jsonToAny(str)
            return jsonStringify(obj, prettyPrinted: true)
        } catch {print("Unable to pretty print \(error)")}
        return str
    }
    
    class func validJson(value: AnyObject) -> Bool{
        return NSJSONSerialization.isValidJSONObject(value)
    }
    
    class func jsonStringify(value: AnyObject, prettyPrinted: Bool = false) -> String {
        let options:NSJSONWritingOptions = prettyPrinted ? NSJSONWritingOptions.PrettyPrinted : NSJSONWritingOptions.init(rawValue: 0)
        if validJson(value) {
            if let data = try? NSJSONSerialization.dataWithJSONObject(value, options: options) {
                if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    return string as String
                }
            }
        }
        return ""
    }
    
    class func jsonToAny(str:String) throws -> AnyObject{
        var err: NSError! = NSError(domain: "Migrator", code: 0, userInfo: nil)
        let data = str.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        let obj : AnyObject?
        do {
            obj = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
        } catch let error as NSError {
            err = error
            obj = nil
        }
        if let value = obj {
            return value
        }
        throw err
    }
}
import Cocoa

class QueryRunner{
    
    func runTask(json:String, query:String)->String{
        let bundlePath = NSBundle.mainBundle().pathForResource("jq-osx-amd64", ofType: nil)        
        
        let task = NSTask()
        let path = saveTextToTemp(json)
        task.launchPath =  bundlePath!
        
        task.arguments = [query,  path]
        
        let pipe = NSPipe()
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = NSString(data: data, encoding: NSUTF8StringEncoding)
        return String(output!)
    }
    
    func saveTextToTemp(text:String) -> String{
        let file = "scratch.json"
        var path:String = ""
        
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            path = dir.stringByAppendingPathComponent(file);
            text.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding, error: nil);
            let text2 = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)
            
        }
        return path
    }
}
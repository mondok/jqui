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
        
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent(file)

        do {
            try text.writeToURL(fileURL, atomically: false, encoding: NSUTF8StringEncoding)
        } catch _ {
        };
        
        return fileURL.path!
    }
}
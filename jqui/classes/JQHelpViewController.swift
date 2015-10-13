//
//  JQHelpViewController.swift
//  jqui
//
//  Created by Matthew Mondok on 8/31/15.
//  Copyright (c) 2015 Matthew Mondok. All rights reserved.
//

import Foundation
import WebKit

class JQHelpViewController: NSViewController {
    
    @IBOutlet weak var helpWebView: WebView!

    override func viewDidLoad() {
        let url = NSURL(string: "https://stedolan.github.io/jq/manual/#Basicfilters")!
        let req = NSURLRequest(URL: url)
        helpWebView.mainFrame.loadRequest(req)
        super.viewDidLoad()
    }
    
}


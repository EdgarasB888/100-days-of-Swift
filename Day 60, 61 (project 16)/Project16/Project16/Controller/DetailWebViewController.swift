//
//  DetailWebViewController.swift
//  Project16
//
//  Created by Edgaras Blauzdys on 2023-01-09.
//

import WebKit
import UIKit

class DetailWebViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    
    var url: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView()
        view = webView
        
        showWebView()
    }

    func showWebView() {
        var finalUrl: URL!
        
        switch url {
        case "Rome":
            finalUrl = URL(string: "https://en.wikipedia.org/wiki/Rome")
        case "London":
            finalUrl = URL(string: "https://en.wikipedia.org/wiki/London")
        case "Oslo":
            finalUrl = URL(string: "https://en.wikipedia.org/wiki/Oslo")
        case "Paris":
            finalUrl = URL(string: "https://en.wikipedia.org/wiki/Paris")
        case "Washington DC":
            finalUrl = URL(string: "https://en.wikipedia.org/wiki/Washington")
        default:
            finalUrl = URL(string: "https://ru.wikipedia.org/wiki/")
        }
        webView.load(URLRequest(url: finalUrl!))
        webView.allowsBackForwardNavigationGestures = true
    }
   
}

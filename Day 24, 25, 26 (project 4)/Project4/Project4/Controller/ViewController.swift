//
//  ViewController.swift
//  Project4
//
//  Created by Edgaras Blauzdys on 2022-11-28.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate
{
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com"]
    
    override func loadView()
    {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: webView, action: #selector(webView.goBack))
        let forwardButton = UIBarButtonItem(image: UIImage(systemName: "arrow.right"), style: .plain, target: webView, action: #selector(webView.goForward))
                
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
    
        toolbarItems = [progressButton, spacer, backButton, forwardButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    @objc func openTapped()
    {
        let ac = UIAlertController(title: "Open page", message: nil, preferredStyle: .actionSheet)
        
        for website in websites
        {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem //important for iPad
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction)
    {
        guard let actionTitle = action.title else { return }
        guard let url = URL(string: "https://" + actionTitle) else { return }
        
        //second way
        //let url = URL(string: "https://" + action.title!)!
        
        webView.load(URLRequest(url: url))
    }
    
    //used when webkit finishes loading it's page
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    {
        title = webView.title
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
        if keyPath == "estimatedProgress"
        {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void)
    {
        let url = navigationAction.request.url
        
        if let host = url?.host
        {
            for website in websites
            {
                if host.contains(website)
                {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
        actionController(title: url!)
    }
    
    func actionController(title: URL)
    {
        if !title.absoluteString.contains("about")
        {
            let ac = UIAlertController(title: "Warning!", message: "The website \(title) is not allowed", preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            
            present(ac, animated: true)
        }
        else
        {
            print("about")
        }
    }
}


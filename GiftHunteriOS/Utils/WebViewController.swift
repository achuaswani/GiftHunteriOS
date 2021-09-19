//
//  WebViewController.swift
//  ShoppingCart
//
//  Created by Aswani G on 8/2/20.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        let myURL = URL(string: AppConstants.WEBVIEWTESTURL)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        webView.allowsBackForwardNavigationGestures = true
    }
}

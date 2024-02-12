//
//  WebViewController.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 12.02.2024.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var url: URL!

    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView

        let request = URLRequest(url: url)
        webView.load(request)
    }
}


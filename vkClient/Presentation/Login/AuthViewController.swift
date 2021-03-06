//
//  AuthViewController.swift
//  vkClient
//
//  Created by Василий Слепцов on 19.09.2021.
//

import UIKit
import WebKit
import Firebase

class AuthViewController: UIViewController {

    @IBOutlet var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !Session.shared.token.isEmpty, !Session.shared.userId.isEmpty {
            performSegue(withIdentifier: "moveToAnimate", sender: self)
        }
        authorizeToVK()
        
    }
    

    func authorizeToVK() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7955696"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "140488159"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "1"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)
    }

}

extension AuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        guard let token = params["access_token"], let userId = params["user_id"] else { return }
        
        Session.shared.token = token
        Session.shared.userId = userId
        
        let ref = Database.database().reference(withPath: "users")
        let user = UserFirebase(id: userId)
        let userContainerRef = ref.child(userId)
        userContainerRef.setValue(user.toAnyObject())
        
        self.performSegue(withIdentifier: "moveToAnimate", sender: self)
        
        decisionHandler(.cancel)
    }
}

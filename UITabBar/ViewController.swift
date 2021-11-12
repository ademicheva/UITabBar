//
//  ViewController.swift
//  UITabBar
//
//  Created by Алина on 11.11.2021.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var urlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlTextField.delegate = self
        webView.navigationDelegate = self
        
        let homePage = "https://www.apple.com/"
        let url = URL(string: homePage) // 3. СОздадим константу и присвоим
        let request = URLRequest(url: url!) // 2 (восклицательный знак стави потому что url optional)

        
        urlTextField.text = homePage // для отображения сайта в текстфилде
        
        webView.load(request) // 1. Позаоляет загрузить URL запрос. Его необходимо создать
        webView.allowsBackForwardNavigationGestures = true // это свойсвтво позволяет при помощи свайпов возвращаться назад или вперед
    }
    
    
    
    @IBAction func forwardButtonAction(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
}


extension ViewController: UITextFieldDelegate, WKNavigationDelegate {
    // подписавшись под данный протокол нам доступен метод textFieldShouldReturn
    // данный метод позвол]ет вернуть данные из текстовой строки
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlString = textField.text!
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        webView.load(request)
        
        textField.resignFirstResponder()
        
        return true
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        urlTextField.text = webView.url?.absoluteString // мы строку адресса переносим в текстовое поле
        
        // сделаем возможность включения кнопок Back и Forward
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
        
        
    }
}

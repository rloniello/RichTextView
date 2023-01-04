//
//  ViewController.swift
//  RichTextView
//
//  Created by Russell on 9/8/22.
//

import UIKit


class ViewController: UIViewController {
    
    private var richTextView: RichTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.richTextView = RichTextView()
        self.setupSubviews()
    }

    func setupSubviews() {
        self.richTextView.center = self.view.center
        self.view.addSubview(self.richTextView)
    }
    
}

//
//  ViewController.swift
//  LightTransparentNavBar
//
//  Created by 홍창남 on 2018. 2. 17..
//  Copyright © 2018년 홍창남. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let offset = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.size.height)!

        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: offset * -1).isActive = true
        scrollView.delegate = self
        setNavbar()
        extendedLayoutIncludesOpaqueBars = true
    }

    func setNavbar() {
        if let navigationBar = self.navigationController?.navigationBar as? LightTransparentNavBar {
            navigationBar.isTransparent = true
            navigationBar.hideBottomNavigationLine = true
            navigationBar.maxOffset = 1500
            navigationBar.color = .blue
        }
    }

    @IBAction func GoToBottomTapped(_ sender: UIButton) {
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
        scrollView.setContentOffset(bottomOffset, animated: true)
    }

    @IBAction func GoToTopTapped(_ sender: UIButton) {

        let offset = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.size.height)!

        scrollView.setContentOffset(CGPoint(x: 0, y: offset * -1), animated: true)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let navigationBar = self.navigationController?.navigationBar as? LightTransparentNavBar {
            navigationBar.scrollViewDidScroll(scrollView)
        }
    }
}

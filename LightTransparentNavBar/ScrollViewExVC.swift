//
//  ScrollViewExVC.swift
//  LightTransparentNavBar
//
//  Created by 홍창남 on 2018. 2. 19..
//  Copyright © 2018년 홍창남. All rights reserved.
//

import UIKit

class ScrollViewExVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let offset = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.size.height)!

        scrollView.delegate = self
        scrollView.contentInset.top = offset * -1
        extendedLayoutIncludesOpaqueBars = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavbar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParentViewController {
            if let navCon = self.navigationController {
                if let vc = navCon.topViewController as? ViewController {
                    vc.scrollViewDidScroll(vc.tableView)
                }
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setNavbar()
    }

    func setNavbar() {
        if let navBar = self.navigationController?.navigationBar as? LightTransparentNavBar {
            navBar.color = .yellow
            navBar.isTransparent = true
            navBar.hideBottomNavigationLine = true
            navBar.tintColor = .blue
        }
    }

    @IBAction func goToBottomTapped(_ sender: UIButton) {
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
        scrollView.setContentOffset(bottomOffset, animated: true)
    }

    @IBAction func goToTopTapped(_ sender: UIButton) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}

extension ScrollViewExVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y

        if let navBar = self.navigationController?.navigationBar as? LightTransparentNavBar {

            if offset > 0 {

                let alpha = offset / (1500 - scrollView.frame.size.height)
                navBar.setBackground(color: navBar.color.withAlphaComponent(alpha))
                navBar.isTranslucent = alpha >= 1.0 ? false : true

            }
        }

    }
}

//
//  ViewController.swift
//  LightTransparentNavBar
//
//  Created by 홍창남 on 2018. 2. 17..
//  Copyright © 2018년 홍창남. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var navAlpha: CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavbar()
    }

    func setNavbar() {
        if let navBar = self.navigationController?.navigationBar as? LightTransparentNavBar {
            navBar.color = .darkGray
            navBar.isTransparent = true
            navBar.hideBottomNavigationLine = true
            navBar.tintColor = .black

            if let navAlpha = navAlpha {
                navBar.setBackground(color: navBar.color.withAlphaComponent(navAlpha))
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if let navBar = self.navigationController?.navigationBar as? LightTransparentNavBar {
//            navBar.setNavBarToDefault()
        }
    }
}

extension ViewController {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let navBar = self.navigationController?.navigationBar as? LightTransparentNavBar {

            if scrollView.contentOffset.y > 0 {
                let maxHeight = self.tableView.contentSize.height

                let alpha = scrollView.contentOffset.y / (maxHeight - scrollView.frame.size.height)

                self.navAlpha = alpha
                navBar.setBackground(color: navBar.color.withAlphaComponent(alpha))

                if alpha >= 1.0 {
                    navBar.isTranslucent = false
                } else {
                    navBar.isTranslucent = true
                }
            }
        }

    }

}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "example1")

        cell.textLabel?.text = "example1"
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToScrollExample", sender: nil)
    }
}

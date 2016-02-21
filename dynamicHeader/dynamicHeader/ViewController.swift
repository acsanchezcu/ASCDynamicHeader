//
//  ViewController.swift
//  dynamicHeader
//
//  Created by Abel Sánchez Custodio on 20/2/16.
//  Copyright © 2016 acsanchezcu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: DynamicHeaderScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let view : UIImageView = UIImageView.init(image: UIImage.init(named: "headerImage"))
        view.contentMode = UIViewContentMode.ScaleAspectFill
        
        let contentView : UIView = UIView.init()

        contentView.backgroundColor = UIColor.redColor()
        
        scrollView.headerView = view
        scrollView.contentView = contentView

        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.translucent = true
        self.navigationController!.view.backgroundColor = UIColor.clearColor()
        
    }
}


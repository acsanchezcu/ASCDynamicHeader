//
//  ViewController.swift
//  dynamicHeader
//
//  Created by Abel Sánchez Custodio on 20/2/16.
//  Copyright © 2016 acsanchezcu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var scrollView: DynamicHeaderScrollView?
    
    @IBOutlet weak var contentView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let headerView : UIImageView = UIImageView.init(image: UIImage.init(named: "headerImage"))
        headerView.contentMode = UIViewContentMode.ScaleAspectFill
        
        contentView.removeFromSuperview()
        
        scrollView = DynamicHeaderScrollView.init()
        
        view.addSubview(scrollView!)
        
        UIView.embedView(scrollView!)
        
        scrollView!.headerView = headerView
        scrollView!.contentView = contentView

        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.translucent = true
        self.navigationController!.view.backgroundColor = UIColor.clearColor()
        
    }
}


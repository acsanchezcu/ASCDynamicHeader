//
//  DynamicHeaderScrollView.swift
//  dynamicHeader
//
//  Created by Abel Sánchez Custodio on 20/2/16.
//  Copyright © 2016 acsanchezcu. All rights reserved.
//

import UIKit

import Foundation

class DynamicHeaderScrollView: UIView, UIScrollViewDelegate {
    
    //MARK: - Properties
    
    var headerView : UIView = UIView.init() {
        didSet {
            
            initialize()
        }
    }
    
    var contentView : UIView = UIView.init() {
        didSet {
            
            initialize()
        }
    }
    
    var headerHeight : Float = 250.0 {
        didSet {
            initialize()
        }
    }
    
    private var headerContainerView : UIView?
    private var scrollContainerView : UIScrollView?
    
    private var topConstraint : NSLayoutConstraint?
    private var bottomConstraint : NSLayoutConstraint?

    //MARK: - Init
    
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)!
//        
//        initialize()
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        initialize()
//    }
    
    //MARK: - Private Methods
    
    func initialize() {
        
        addHeaderContainerView()
        
        addScrollView()
        
        scrollContainerView?.delegate = self
    }
    
    func addHeaderContainerView() {

        headerContainerView?.removeFromSuperview()
        
        headerContainerView = UIView.init()
        
        headerContainerView?.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(headerContainerView!)
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        let views = ["view": headerContainerView!]
        
        let widthConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[view(width)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["width" : screenSize.width], views: views)
        
        let heightConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[view(height)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["height" : headerHeight], views: views)
        
        addConstraints(widthConstraints)
        addConstraints(heightConstraints)
        
        headerContainerView?.addSubview(headerView)
        
        headerView.clipsToBounds = false
        
        UIView.embedView(headerView)
        
        for constraint in constraints {
            if constraint.firstItem === headerContainerView! && constraint.firstAttribute == .Top && constraint.secondItem === self {
                topConstraint = constraint
            }
        }
        
        bottomConstraint = headerContainerView?.constraints[3]
    }
    
    func addScrollView() {
        
        scrollContainerView?.removeFromSuperview()
        
        scrollContainerView = UIScrollView.init()
        
        scrollContainerView?.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(scrollContainerView!)
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        let views = ["view": scrollContainerView!, "headerView": headerContainerView!]
        
        let widthConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        
        let heightConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[headerView][view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["height" : headerHeight], views: views)
        
        addConstraints(widthConstraints)
        addConstraints(heightConstraints)
        
        scrollContainerView?.addSubview(contentView)
        
        UIView.embedViewWithSize(contentView, size: CGSize.init(width: screenSize.width, height: 1000))
    }
    
    //MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        var margin = round(scrollView.contentOffset.y)
        
        if margin != 0 {
            margin = margin * (-1)
        }
        
        if margin < -186 {
            topConstraint?.constant = -186
            bottomConstraint?.constant = 0
        } else if margin >= 0 {
            topConstraint?.constant = 0
            bottomConstraint?.constant = margin * (-1)
        } else if margin < 0 {
            topConstraint?.constant = margin
            bottomConstraint?.constant = 0
        }
    }
}

//
//  View+Constraint.swift
//  CodeAsses
//
//https://medium.com/@kemalekren/swift-create-custom-tableview-cell-with-programmatically-in-ios-835d3880513d

import UIKit
extension UIView {
 
    //MARK: - all constraints
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool) {
    
        anchor (top: top, left: left, bottom: bottom, right: right, paddingTop: paddingTop, paddingLeft: paddingLeft, paddingBottom: paddingBottom, paddingRight: paddingRight, enableInsets: enableInsets)
        
        anchor(width: width, height: height)
    }
    
    //MARK: - individual sides constraints

    func anchor(top: NSLayoutYAxisAnchor?, paddingTop: CGFloat, enableInsets: Bool) {
               
        translatesAutoresizingMaskIntoConstraints = false

        var topInset = CGFloat(0)
        if enableInsets {
           let insets = self.safeAreaInsets
           topInset = insets.top
        }

        if let top = top {
           self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
        }
    }
    
    func anchor(bottom: NSLayoutYAxisAnchor?, paddingBottom: CGFloat, enableInsets: Bool) {
          
        translatesAutoresizingMaskIntoConstraints = false

        var bottomInset = CGFloat(0)
        if enableInsets {
            let insets = self.safeAreaInsets
            bottomInset = insets.bottom
        }

        if let bottom = bottom {
           bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
        }
    }
    
    func anchor(left: NSLayoutXAxisAnchor?,paddingLeft: CGFloat) {
            
        translatesAutoresizingMaskIntoConstraints = false

        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
    }
    
    func anchor(right: NSLayoutXAxisAnchor?,paddingRight: CGFloat) {
           
        translatesAutoresizingMaskIntoConstraints = false

        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
    }
    
    //MARK: - all/some sides constraints

    func anchor(left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingLeft: CGFloat, paddingRight: CGFloat){
        
        self.anchor(left: left, paddingLeft: paddingLeft)
        self.anchor(right: right, paddingRight: paddingRight)
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, paddingTop: CGFloat, paddingBottom: CGFloat, enableInsets: Bool){
        
        self.anchor(top: top, paddingTop: paddingTop, enableInsets: enableInsets)
        self.anchor(bottom: bottom, paddingBottom: paddingBottom, enableInsets: enableInsets)
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, enableInsets: Bool){
    
        self.anchor(top: top, paddingTop: paddingTop, enableInsets: enableInsets)
        self.anchor(bottom: bottom, paddingBottom: paddingBottom, enableInsets: enableInsets)
        self.anchor(left: left, paddingLeft: paddingLeft)
        self.anchor(right: right, paddingRight: paddingRight)
    }
    
    //MARK: - width and height constraints
    
    func anchor(width: CGFloat) {
    
        translatesAutoresizingMaskIntoConstraints = false

         if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
         }
    }
    
    func anchor(height: CGFloat) {
    
        translatesAutoresizingMaskIntoConstraints = false
         if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
         }
    }
    
    //width and height constraints
    func anchor(width: CGFloat, height: CGFloat) {
    
        self.anchor(width: width)
        self.anchor(height: height)
    }
    
    //MARK: - centering constraints

    func anchor(centerX: NSLayoutXAxisAnchor?){
        
        translatesAutoresizingMaskIntoConstraints = false
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
    }
    
    func anchor(centerY: NSLayoutYAxisAnchor?){
        
        translatesAutoresizingMaskIntoConstraints = false
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    func anchor(centerX: NSLayoutXAxisAnchor?, centerY: NSLayoutYAxisAnchor?){
        self.anchor(centerX:centerX)
        self.anchor(centerY:centerY)
    }
 
}

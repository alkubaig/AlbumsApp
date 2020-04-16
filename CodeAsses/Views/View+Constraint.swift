//
//  View+Constraint.swift
//  CodeAsses
//
//https://medium.com/@kemalekren/swift-create-custom-tableview-cell-with-programmatically-in-ios-835d3880513d

import UIKit
extension UIView {
 
    //all constraints
    func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool) {
    
        anchor (top: top, left: left, bottom: bottom, right: right, paddingTop: paddingTop, paddingLeft: paddingLeft, paddingBottom: paddingBottom, paddingRight: paddingRight, enableInsets: enableInsets)
        
        anchor(width: width, height: height)
    }
    
    //all sides constraints
    func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, enableInsets: Bool) {
    
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)
        
        if enableInsets {
            let insets = self.safeAreaInsets
            topInset = insets.top
            bottomInset = insets.bottom
        }
        
        translatesAutoresizingMaskIntoConstraints = false
     
         if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
         }
         if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
         }
         if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
         }
         if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
         }
    }
    
    //width and height constraints
    func anchor(width: CGFloat, height: CGFloat) {
    
         if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
         }
         if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
         }
    }
    
    //centering constraints
    func anchor(centerX: NSLayoutXAxisAnchor?, centerY: NSLayoutYAxisAnchor?){
        
        translatesAutoresizingMaskIntoConstraints = false

        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
 
}

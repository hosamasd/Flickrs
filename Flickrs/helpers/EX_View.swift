//
//  EX_View.swift
//  AqarZellos
//
//  Created by hosam on 02/08/2021.
//

import SwiftUI

extension UIBezierPath {
    var path: Path {
        return Path(self.cgPath)
    }
    
    func addQuadCurve(to point: CGPoint, control: CGPoint) {
        self.addQuadCurve(to: point, controlPoint: control)
    }
    
    convenience init(_ callback: (inout UIBezierPath) -> ()) {
        var path = UIBezierPath()
        callback(&path)
        self.init(cgPath: path.cgPath)
    }
}

extension View {
    
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
            .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
    
    func backgroundColor(_ color: Color) -> some View {
        return self.background(color)
    }
    //for add border specific location
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
    
    
    //for keyboard height
    //    func KeyboardAwarePadding() -> some View {
    //        ModifiedContent(content: self, modifier: KeyboardAwareModifier())
    //    }
    
    func getSafeArea() -> UIEdgeInsets? {
        return UIApplication.shared.windows.first?.safeAreaInsets
    }
    
    func getFrameSize() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func frameWidth() -> CGFloat {
        getFrameSize().width
    }
    
    func frameHeight() -> CGFloat {
        getFrameSize().height
    }
    
    func imageHeight() -> CGFloat {
        getFrameSize().height < 750 ? 300 : 350
    }
    
    func isSmallDevice() -> Bool {
        UIScreen.main.bounds.height < 750
    }
    
    func isFaoundBottomSafe() -> CGFloat? {
        return   UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 0 : UIApplication.shared.windows.first?.safeAreaInsets.bottom
    }
}


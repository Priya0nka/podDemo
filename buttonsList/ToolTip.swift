//
//  ToolTip.swift
//  UIShapes
//
//  Created by mac on 22/11/22.
//

import Foundation
import UIKit

class ToolTip: UIView {

    // Singleton instance
    static let shared = ToolTip.sharedInstanceFromNib (
        size: CGSize(width: 100,
                     height: 45)
    )

    class private func sharedInstanceFromNib(size: CGSize) -> (ToolTip) {
        guard let view = Bundle.main.loadNibNamed("ToolTip",
                                                  owner: self,
                                                  options: nil)?.first as? ToolTip else {
            return ToolTip()
        }
        view.frame.size = size
        return view
    }
    
    @IBOutlet weak var textContainerView: UIView! {
        didSet {
            self.textContainerView.layer.cornerRadius = 6
            self.textContainerView.clipsToBounds = true
        }
    }

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var downTriangleView: UIView! {
        didSet {
            self.downTriangleView.setDownTriangle(.black)
        }
    }

    func config(x: CGFloat, y: CGFloat, headerText: String) {
        guard let viewController = self.topController() else { return }
        self.titleLabel.text = headerText

        let label = UILabel()
        label.text = headerText
        label.numberOfLines = 1
        label.sizeToFit()

        self.frame = CGRect(x: x,
                            y: y,
                            width: label.frame.width + 32,
                            height: 45)

        viewController.view.addSubview(self)
    }

    func onTapClose() {
        self.removeFromSuperview()
    }

    class func removeToolTip() {
        ToolTip.shared.onTapClose()
    }

    // MARK: - Open Functions
    // For show alertView

    class func showToolTip(
        headerTitle: String,
        x: CGFloat,
        y: CGFloat) {
            ToolTip.shared.config(x: x,
                                  y: y,
                                  headerText: headerTitle)
        }

    func topController() -> UIViewController? {
        if var topController = UIWindow.key?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

extension UIView {

    func setRightTriangle(_ color: UIColor = .blue) {
        let heightWidth = self.frame.size.width
        let path = CGMutablePath()
        path.move(to: CGPoint(x: heightWidth/2, y: 0))
        path.addLine(to: CGPoint(x:heightWidth, y: heightWidth/2))
        path.addLine(to: CGPoint(x:heightWidth/2, y:heightWidth))
        path.addLine(to: CGPoint(x:heightWidth/2, y:0))
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = color.cgColor
        self.layer.insertSublayer(shape, at: 0)
    }

    func setLeftTriangle(_ color: UIColor = .blue) {
        let heightWidth = self.frame.size.width
        let path = CGMutablePath()
        path.move(to: CGPoint(x: heightWidth/2, y: 0))
        path.addLine(to: CGPoint(x:0, y: heightWidth/2))
        path.addLine(to: CGPoint(x:heightWidth/2, y:heightWidth))
        path.addLine(to: CGPoint(x:heightWidth/2, y:0))
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = color.cgColor
        self.layer.insertSublayer(shape, at: 0)
    }

    func setUpTriangle(_ color: UIColor = .blue) {
        let heightWidth = self.frame.size.width
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: heightWidth))
        path.addLine(to: CGPoint(x:heightWidth/2, y: heightWidth/2))
        path.addLine(to: CGPoint(x:heightWidth, y:heightWidth))
        path.addLine(to: CGPoint(x:0, y:heightWidth))
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = color.cgColor
        self.layer.insertSublayer(shape, at: 0)
    }

    func setDownTriangle(_ color: UIColor = .blue) {
        let heightWidth = self.frame.size.width
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x:heightWidth/2, y: heightWidth/2))
        path.addLine(to: CGPoint(x:heightWidth, y:0))
        path.addLine(to: CGPoint(x:0, y:0))
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = color.cgColor
        self.layer.insertSublayer(shape, at: 0)
    }

    @available(iOS 15.0, *)
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
            // Doesn't seem to work
            print("Detent changed")
        }
}

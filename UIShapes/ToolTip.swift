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

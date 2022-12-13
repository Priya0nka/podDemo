//
//  ViewController.swift
//  UIShapes
//
//  Created by mac on 22/11/22.
//

import UIKit
import Lottie

class ViewController: UIViewController, UISheetPresentationControllerDelegate {

    @IBOutlet weak var rightTriangleView: UIView!
    @IBOutlet weak var leftTriangleView: UIView!
    @IBOutlet weak var topTriangleView: UIView!
    @IBOutlet weak var bottomTriangleView: UIView!
    @IBOutlet weak var toolTipButton: UIButton!
    @IBOutlet var animationView: AnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.rightTriangleView.setRightTriangle(.red)
        self.leftTriangleView.setLeftTriangle(.green)
        self.topTriangleView.setUpTriangle(.yellow)
        self.bottomTriangleView.setDownTriangle(.purple)
        
        self.animationView.animation = Animation.named("confetti") 
        self.animationView.contentMode = .scaleAspectFit
        self.animationView.loopMode = .loop
        self.animationView.animationSpeed = 0.5
        //view.addSubview(animationView!)
        self.animationView.play()
    }

    @IBAction func openEditUserVcAction(_ sender: Any) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditUserProfileViewController") as? EditUserProfileViewController ?? EditUserProfileViewController()
        viewController.modalPresentationStyle = .custom

//        if let sheet = viewController.sheetPresentationController {
//            sheet.delegate = self
//            sheet.selectedDetentIdentifier = .large
//            sheet.prefersGrabberVisible = false
//            sheet.detents = [.large(),.medium()]
//            sheet.preferredCornerRadius = 20
//        }
        self.present(viewController, animated: false, completion: nil)
    }

    @IBAction func openBottmSheetAction(_ sender: Any) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BottomSheetViewController") as? BottomSheetViewController ?? BottomSheetViewController()
        viewController.modalPresentationStyle = .custom
        self.present(viewController, animated: false, completion: nil)
    }

    @IBAction func buttonAction(_ sender: Any) {
        ToolTip.showToolTip(headerTitle: "Inactive",
                            x: toolTipButton.center.x - 100,
                            y: toolTipButton.center.y - 100)

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            ToolTip.removeToolTip()
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

    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
            // Doesn't seem to work
            print("Detent changed")
        }
}

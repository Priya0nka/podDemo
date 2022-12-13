//
//  EditUserProfileViewController.swift
//  UIShapes
//
//  Created by mac on 22/11/22.
//

import UIKit

class EditUserProfileViewController: UIViewController,
                                     UIGestureRecognizerDelegate {

    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var bgView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bgView.roundCorners(20)
        self.bgView.addPanGesture {
            self.dismiss(animated: true)
            self.exitButton.backgroundColor = .clear
        }
        self.bgView.isUserInteractionEnabled = true
    }

    @IBAction func exitButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
        sender.backgroundColor = .clear
    }
}

extension UIView {
    func roundCorners(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

class MyTapGestureRecognizer: UITapGestureRecognizer {
    var action : (()->Void)? = nil
}
extension UIView {
    func addTapGesture(action : @escaping () -> Void) {
        let tap = MyTapGestureRecognizer(target: self , action: #selector(self.handleTap(_:)))
        tap.action = action
        tap.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
        
    }
    @objc func handleTap(_ sender: MyTapGestureRecognizer) {
        sender.action!()
    }
}

    // MARK: - PanGesture Recogniser
extension UIView {
    func addPanGesture(action : @escaping () -> Void) {
        let pan = MyPanGestureRecognizer(target: self,
                                         action: #selector(self.handlePan(_:)))
        pan.action = action
        self.addGestureRecognizer(pan)
        self.isUserInteractionEnabled = true
    }

    @objc func handlePan(_ sender: MyPanGestureRecognizer) {
        sender.addPan(gestureRecognizer: sender)
    }

}

class MyPanGestureRecognizer: UIPanGestureRecognizer {
    var action: (()-> Void)? = nil
    var viewHeight = CGFloat()
    
    func addPan(gestureRecognizer: UIPanGestureRecognizer) {
        if self.viewHeight == 0.0 {
            self.viewHeight = gestureRecognizer.view!.center.y
        }
        switch gestureRecognizer.state {
        case .began, .changed :
            let translation = gestureRecognizer.translation(in: view)
            if gestureRecognizer.view!.center.y >= (viewHeight) {
                if (translation.y + gestureRecognizer.view!.center.y) >= viewHeight {
                    gestureRecognizer.view!.center =
                    CGPoint(x: gestureRecognizer.view!.center.x,
                            y: gestureRecognizer.view!.center.y + translation.y)
                }
            }
            gestureRecognizer.setTranslation(CGPoint(x: 0, y: 0), in: view)
        case .ended :
            if gestureRecognizer.view!.center.y > 900 {
                UIView.animate(withDuration: 0.3, animations: {
                    gestureRecognizer.view!.center =
                    CGPoint(x: gestureRecognizer.view!.center.x,
                            y: 2000)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                        self.action!()
                    })
                })
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x,
                                                             y: self.viewHeight)
                }, completion: nil)
            }
        default:
            break
        }
    }
}

//
//  BottomSheetViewController.swift
//  UIShapes
//
//  Created by mac on 29/11/22.
//

import UIKit

class BottomSheetViewController: UIViewController {

    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var bgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bgView.roundCorners(20)
        bgView.addPanGesture {
            self.exitButton.backgroundColor = .clear
            self.dismiss(animated: true)
        }
    }

    @IBAction func exitButtonAction(_ sender: Any) {
        self.exitButton.backgroundColor = .clear
        self.dismiss(animated: true)
    }
}

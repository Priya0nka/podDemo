//
//  ViewController.swift
//  buttonsList
//
//  Created by Priyanka on 03/01/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet var optionButtons: [UIButton]!

    var arr = [Any]()
    let viewModel = Test()
    let abc = true

    override func viewDidLoad() {
        super.viewDidLoad()
        selectButton.layer.cornerRadius = selectButton.frame.height / 2
        optionButtons.forEach{ (btn) in
            btn.layer.cornerRadius = btn.frame.height / 2
            btn.isHidden = true
            btn.alpha = 0
        }

        if abc {
            self.arr = viewModel.modelOneArr
        } else {
            self.arr = viewModel.modelTwoArr
        }
    }

    @IBAction func selectionButtonAction(_ sender: Any) {
        optionButtons.forEach{ btn in
            UIView.animate(withDuration: 0.7) {
                btn.isHidden = !btn.isHidden
                btn.alpha = btn.alpha == 0 ? 1 : 0
                btn.layoutIfNeeded()
            }
        }
        ToolTip.showToolTip(headerTitle: "Inactive",
                            x: view.center.x - 100,
                            y: view.center.y - 100)

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            ToolTip.removeToolTip()
        }
    }

    @IBAction func optionButtonAction(_ sender: UIButton) {
       if let btlText = sender.titleLabel?.text {
            print(btlText)
        }
    }

    func swapValues<T>(_ a: inout [T]) {
        self.arr = a
    }

}


struct ModelOne {
    var name = ""
    var image = ""
}

struct ModelTwo {
    var isSelected = false
}

class Test {
    var modelOneArr: [ModelOne] = [ModelOne(name: "priya", image: "sdfsd"),
                                   ModelOne(name: "shristy", image: "sdfsd"),
                                   ModelOne(name: "arti", image: "fsdfs")]
    var modelTwoArr: [ModelTwo] = [ModelTwo(isSelected: true),
                                   ModelTwo(isSelected: false),
                                   ModelTwo(isSelected: false),
                                   ModelTwo(isSelected: true)]
}

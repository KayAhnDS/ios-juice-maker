//
//  ManageStockViewController.swift
//  JuiceMaker
//
//  Created by Eunsoo KIM on 2021/10/26.
//

import UIKit

class ManageStockViewController: UIViewController {

    var deliverdAllStock = ["0", "0", "0", "0", "0"]
    var juiceMaker: JuiceMaker?
    
    @IBOutlet var fruitQuantityLabels: [UILabel]!
    @IBOutlet var fruitQuantityStepper: [UIStepper]!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .systemGray5
        
        setFruitQuantityLable()
        setFruitQuantityStepper()
    }
    
    func setFruitQuantityLable() {
        for index in 0...fruitQuantityLabels.count - 1 {
            fruitQuantityLabels[index].text = deliverdAllStock[index]
        }
    }
    
    func setFruitQuantityStepper() {
        var labelTexts = [String]()
        
        for label in fruitQuantityLabels {
            labelTexts.append(String(label.text ?? "0"))
        }
        
        for index in 0...fruitQuantityLabels.count - 1 {
            fruitQuantityStepper[index].value = Double(Int(labelTexts[index]) ?? 0)
        }
    }
    
    @IBAction func touchUpDismissButton(_ sender: UIBarButtonItem) {
        updateStock()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpFruitQuantityStepper(_ sender: UIStepper) {
        fruitQuantityLabels[sender.tag].text = String(Int(sender.value))
    }
    
    func updateStock() {
        var fruitNames = [Fruit.Name]()
        for name in Fruit.Name.allCases {
            fruitNames.append(name)
        }
        
        var updatingFruitsQuantity = [Fruit]()
        for index in 0...fruitQuantityLabels.count - 1 {
            updatingFruitsQuantity.append(Fruit(name: fruitNames[index],
                                   quantity: Int(fruitQuantityLabels[index].text ?? "0") ?? 0))
        }

        juiceMaker?.updateStock(to: updatingFruitsQuantity)
    }
}

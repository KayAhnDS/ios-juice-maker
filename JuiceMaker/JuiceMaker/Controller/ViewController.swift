//
//  JuiceMaker - ViewController.swift
//  Created by safari and Red.
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    var fruitStore = FruitStore.fruitStore
    var juiceMaker = JuiceMaker()
    
    @IBOutlet weak var strawberryLabel: UILabel!
    @IBOutlet weak var bananaLabel: UILabel!
    @IBOutlet weak var pineappleLabel: UILabel!
    @IBOutlet weak var kiwiLabel: UILabel!
    @IBOutlet weak var magoLabel: UILabel!
    
    @IBOutlet weak var strawberryJuiceButton: UIButton!
    @IBOutlet weak var bananaJuiceButton: UIButton!
    @IBOutlet weak var pineappleJuiceButton: UIButton!
    @IBOutlet weak var kiwiJuiceButton: UIButton!
    @IBOutlet weak var mangoJuiceButton: UIButton!
    @IBOutlet weak var strawberryAndBananaJuiceButton: UIButton!
    @IBOutlet weak var mangoAndKiwiJuiceButton: UIButton!
    
    @IBAction func orderButton(_ sender: UIButton) {
        guard let juice = matchButtonToJuice(sender) else { return }
        if juiceMaker.checkOrder(juice) {
            showSuccessAlert(juice.koreanName)
        } else {
            showFailureAlert()
        }
        updateFruitLable()
    }
    
    func matchButtonToJuice(_ button: UIButton) -> JuiceMaker.Juice? {
        var juice: JuiceMaker.Juice?
        switch button {
        case strawberryJuiceButton:
            juice = .strawberryJuice
        case bananaJuiceButton:
            juice = .bananaJuice
        case pineappleJuiceButton:
            juice = .pineappleJuice
        case kiwiJuiceButton:
            juice = .kiwiJuice
        case mangoJuiceButton:
            juice = .mangoJuice
        case strawberryAndBananaJuiceButton:
            juice = .strawberryAndBananaJuice
        case mangoAndKiwiJuiceButton:
            juice = .mangoAndKiwiJuice
        default:
            juice = nil
        }
        return juice
    }
        
    
    func updateFruitLable() {
        strawberryLabel.text = String(fruitStore.getStock(of: .strawberry))
        bananaLabel.text = String(fruitStore.getStock(of: .banana))
        pineappleLabel.text = String(fruitStore.getStock(of: .pineapple))
        kiwiLabel.text = String(fruitStore.getStock(of: .kiwi))
        magoLabel.text = String(fruitStore.getStock(of: .mango))
    }
    
    func showSuccessAlert(_ alertMessage: String) {
        let alertCountroll = UIAlertController(title: Phrases.noticeTitle.text, message: alertMessage + Phrases.readyForJuice.text, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Phrases.ok.text, style: .default, handler: nil )
        alertCountroll.addAction(okAction)
        present(alertCountroll, animated: false, completion: nil)
    }
    
    func showFailureAlert() {
        let alertCountroll = UIAlertController(title: Phrases.noticeTitle.text, message: Phrases.questionForStockChange.text, preferredStyle: .alert)
        let moveAction = UIAlertAction(title: Phrases.yes.text, style: .default, handler: { _ in self.moveStockCorrectionView() })
        let cancelAction = UIAlertAction(title: Phrases.no.text, style: .default, handler: nil )
        alertCountroll.addAction(moveAction)
        alertCountroll.addAction(cancelAction)
        present(alertCountroll, animated: false, completion: nil)
    }
    
    
    @IBAction func clickStockCorrectionButton(_ sender: UIButton) {
        moveStockCorrectionView()
    }
    
    func moveStockCorrectionView() {
        let stockCorrectionView = self.storyboard?.instantiateViewController(withIdentifier: "stockCorrection")
        stockCorrectionView?.modalTransitionStyle = .coverVertical
        stockCorrectionView?.modalPresentationStyle = .automatic
        self.present(stockCorrectionView!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateFruitLable()
        
        // Do any additional setup after loading the view.
    }
}

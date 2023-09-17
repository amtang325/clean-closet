//
//  NewItemViewController.swift
//  Clean Closet
//
//  Created by Rebecca Yu on 9/16/23.
//

import UIKit
import FirebaseDatabase
import FirebaseCore
import Firebase
import FirebaseAuth

class NewItemViewController: UIViewController {
    
    var ref:DatabaseReference?
    
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var brandField: UITextField!
    @IBOutlet weak var materialField: UITextField!
    
    let userEmail = Auth.auth().currentUser?.uid ?? "test"
    
    var brandScores = ["Abercrombie & Fitch": 83.25,
                            "Adidas": 140,
                            "Aeropostale": 7.5,
    "Amazon": 64.25,
    "American Eagle": 53.5,
    "Gucci": 199.25,
    "Gymshark": 67,
                            "H&M": 177.75,
                "Hollister Co.": 83.25,
    "Kohl's": 41.75,
    "LL Bean": 21,
    "Louis Vuitton": 72,
    "Lululemon": 129.75,
    "Macy's": 16.5,
    "Marc Jacobs": 71,
                "Michael Kors": 58.5,
    "New Balance": 133.75,
    "Nike": 124.75,
    "Nordstrom": 65.25,
    "Patagonia": 99.5,
    "SHEIN": 16.5,
    "UGG": 141.75,
    "Under Armour": 69.25,
    "Uniqlo": 126.5,
    "Urban Outfitters": 32.5,
    "Zara": 124.5]
    
    var textiles = ["Polyester": 1,
    "Acrylic": 2,
    "Cotton": 2.5,
    "Rayon": 1.5,
    "Nylon": 2,
    "Organic Cotton": 5,
    "Hemp": 4,
    "Linen": 4.5,
    "Tencel Lyocell": 5,
    "Recycled Polyester": 4.5,
    "Econyl Fabric": 3.5]
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        chatGPTClient.generateText(prompt: "Hello, how are you?") { result in
//            switch result {
//            case .success(let text):
//                print(text)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        let brandScore: Double? = brandScores[brandField.text ?? ""]
        let materialScore: Double? = textiles[materialField.text ?? ""]
        let score: Double? = (((brandScore ?? 5.0) / 20.0) + (materialScore ?? 5.0 * 2)) / 2.0
        let controller = storyboard?.instantiateViewController(identifier: "result") as! ResultViewController
        
        // print(userEmail ?? "empty string")
        ref?.child("Items").child(userEmail).childByAutoId().setValue(["type": typeField.text ?? "", "brand": brandField.text ?? "", "material": materialField.text ?? "", "score": score] as [String : Any])
        
        controller.text = String(format: "%.1f", score ?? 5.0)
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ProfileViewController.swift
//  Clean Closet
//
//  Created by Rebecca Yu on 9/17/23.
//

import UIKit
import FirebaseDatabase
import FirebaseCore
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController {
    var ref: DatabaseReference?
    var scores = [Double]()
    let userEmail = Auth.auth().currentUser?.uid ?? "test"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = Database.database().reference()
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(identifier: "average") as! AverageViewController

        // TO DO: FUNCTION TO GET AVERAGE SCORE OF USER
        ref?.child("Items").child(Auth.auth().currentUser?.uid ?? "").observeSingleEvent(of: .value, with: { snapshot in
            let allChildren = snapshot.children.allObjects as! [DataSnapshot]
            for snap in allChildren {
                if let score = snap.childSnapshot(forPath: "score").value as? Double {
                    self.scores.append(score)
                }
            }
        })
        
        let average: Double? = scores.reduce(0.0, +) / Double(scores.count)
//        ref?.child("Items").child(userEmail).childByAutoId().setValue(["avgscore": average] as [String : Any])
        
        controller.text = String(format: "%.1f", average ?? 5.0)
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

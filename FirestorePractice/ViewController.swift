//
//  ViewController.swift
//  FirestorePractice
//
//  Created by Rosendo Vazquez on 07/11/22.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class ViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfNickName: UITextField!
    @IBOutlet weak var tfScore: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.13, green: 0.20, blue: 0.33, alpha: 1.00)
    }
    
    func getTexts() -> [String:String] {
        var dataInput = ["":""]
        
        guard let name = tfName.text,
              let nickName = tfNickName.text,
              let score = tfScore.text else { return  dataInput }
        
        dataInput = ["Name":name,
                     "NickName":nickName,
                     "Score":score]
        
        return dataInput
    }
    
    func saveDataOnFirestore(params:[String:String]) {
        var status = false
        params.map { [weak self] _, value in
            if !value.isEmpty{
               status = true
            }else{
                status = false
                showErrors(tf: (self?.tfName)!)
                showErrors(tf: (self?.tfNickName)!)
                showErrors(tf: (self?.tfScore)!)
            }
            
        }
        
        if status {
            var ref: DocumentReference? = nil
            ref = db.collection("Characters").addDocument(data: params) { [weak self] err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added \(ref?.documentID ?? "")")
                    self?.clearUI()
                }
            }
        }
        
        
    }
    
    func clearUI()  {
        tfName.text = ""
        tfNickName.text = ""
        tfScore.text = ""
    }
    
    
    func showErrors(tf:UITextField){
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.red.cgColor
        tf.placeholder = "Ingrese un valor"
    }
    
    
    @IBAction func save(_ sender: Any) {
        saveDataOnFirestore(params: getTexts())
    }
    
    
    @IBAction func search(_ sender: Any) {
        let vc = SearchViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}


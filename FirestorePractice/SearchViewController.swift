//
//  SearchViewController.swift
//  FirestorePractice
//
//  Created by Rosendo Vazquez on 07/11/22.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class SearchViewController: UIViewController {
    let db = Firestore.firestore()
    
    @IBOutlet weak var tfSearch: UITextField!
    
    
    @IBOutlet weak var lblResults: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblResults.numberOfLines = 0
        lblResults.lineBreakMode = .byWordWrapping
    }


    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    
    @IBAction func eraseDocument(_ sender: Any) {
        guard let docToErase = tfSearch.text else { return }
        eraseDocumentFromFirestore(id: docToErase)
    }
    
    @IBAction func searchAction(_ sender: Any) {
        search()
    }
    
    func search(){
        lblResults.text = ""
        fetchDocuments()
    }
    
    func fetchDocuments(){
                       
        db.collection("Characters").getDocuments { (snapshotQuery, error) in
            if let error = error {
                print("Error fetching documents: \n \(error.localizedDescription)")
            }else{
                snapshotQuery?.documents.forEach({[weak self] document in
                    print(document.documentID)
                    self?.lblResults.text = (self?.lblResults.text ?? "") + document.documentID + "\n"
                    document.data().map { (key, value) in
                        self?.lblResults.text = (self?.lblResults.text ?? "") + "\(key): \(value) \n"
                        
                    }
                })
            }
        }
    }
    
    
    func eraseDocumentFromFirestore(id:String)  {
        db.collection("Characters").document(id).delete() {[weak self] err in
            if let err = err {
                self?.lblResults.text = err.localizedDescription
            }else{
                self?.search()
            }
            
        }
    }
}

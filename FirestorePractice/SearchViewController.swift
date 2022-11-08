//
//  SearchViewController.swift
//  FirestorePractice
//
//  Created by Rosendo Vazquez on 07/11/22.
//

import UIKit

class SearchViewController: UIViewController {

    
    @IBOutlet weak var tfSearch: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        // Do any additional setup after loading the view.
    }


    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func searchAction(_ sender: Any) {
        guard let txtToSearch = tfSearch.text else { return }
        print("Searching.... \(txtToSearch)")
    }
    
}

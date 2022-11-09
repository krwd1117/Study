//
//  ViewController.swift
//  MoyaStudy
//
//  Created by 2jw.kim on 2022/11/09.
//

import UIKit

import Moya

class ViewController: UIViewController {

    let provider = MoyaProvider<CPLambda>()
    
    @IBOutlet weak var APITestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        provider.request(.getData("https://reqres.in/")) { result in
            print("result -> ", result)
            
            switch result {
            case .success(let response):
                print(response.data)
                print(response.request as Any)
                print(response.response as Any)
                print(response.statusCode)
                print("response.data -> ", response.data)
            case .failure(let error):
                print(error)
            }
            
        }
    }
}


//
//  WatsonSentimentController.swift
//  WatsonSentimentAnalysisApp
//
//  Created by Achraf MAHHA on 21/03/2017.
//  Copyright © 2017 Achraf MAHHA. All rights reserved.
//

import UIKit
import AlchemyLanguageV1

class WatsonSentimentController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!

    override func viewDidLoad() {
    
        super.viewDidLoad()
    }


    @IBAction func sendToWatsonPressed(sender: AnyObject) {
        
        NSLog(textField.text!)
        //checking sentiment
        
        let apiKey = ""
        let alchemyLanguage = AlchemyLanguage(apiKey: apiKey)
       
        // alchemyLanguage
        
        let url = textField.text!
        let failure = { (error: Error) in print(error) }

    
        DispatchQueue.main.async(){
            
            alchemyLanguage.getTextSentiment(fromContentAtURL: url, failure: failure)  {
                
                sentiment in
                
                DispatchQueue.main.sync(){
                self.statusLabel.text = "Status : " + (sentiment.docSentiment?.type)!
                }
            }
        
          }
        
        }

    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true)
    }
}


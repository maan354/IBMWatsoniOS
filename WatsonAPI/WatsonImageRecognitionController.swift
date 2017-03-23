//
//  WatsonImageRecognitionController.swift
//  WatsonAlchemyAPI
//
//  Created by MAHHA on 22/03/2017.
//  Copyright © 2017 MAHHA. All rights reserved.
//

import UIKit
import VisualRecognitionV3

class WatsonImageRecognitionController: UIViewController {
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var resultatLbl: UILabel!
    
    
    
    @IBAction func sendToWatsonPressed(_ sender: Any) {
        
        var status = "En attente du traitement de l'image se trouvant à l'adresse : " + urlTextField.text!
        
        //Adding Watson Visual Recognition
        let apiKey = ""
        let version = "2017-03-23" // Utiliser la date d'aujourd'hui pour la version la plus récente
        
        let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)
       
        let urlString = urlTextField.text!
        
        let url = URL(string: urlString)!
        
        let failure = { (error: Error) in print(error) }
        

        DispatchQueue.main.async(){

            visualRecognition.classify(image: urlString, failure: failure) { classifiedImages in

            
            status = "Résultat : " + (classifiedImages.images.description)
           
            DispatchQueue.main.sync(){
                self.resultatLbl.text = status
            }

            // Si on détecte une classification *********************************************
          
            if (!classifiedImages.images.isEmpty && !classifiedImages.images[0].classifiers.isEmpty && !classifiedImages.images[0].classifiers[0].classes.isEmpty) {
                
            // On récupère le contenu de la classification **********************************
                status = status + "Classification : " + classifiedImages.images[0].classifiers[0].classes[0].classification
                
                print(status)

                
            // Détection des visages sur l'image ********************************************
                if (!classifiedImages.images[0].classifiers[0].classes[0].classification.isEmpty && "person" == classifiedImages.images[0].classifiers[0].classes[0].classification) {
                    
                    
                    status = status + "> Un visage est détecté! \n"
                    
                    print(status)

                    
                    // Plus de détails sur le visage   ***********************************
                    visualRecognition.detectFaces(inImageFile: url, success: {
                        imagesWithFaces in
                    
                        if (!imagesWithFaces.images[0].faces.isEmpty) {
                            status = status + "> Son age Max : " + imagesWithFaces.images[0].faces[0].age.max!.description
                            
                            
                            status = status + "> Son age Min : " + imagesWithFaces.images[0].faces[0].age.min!.description
                            
                            
                            status = status + "> Son sexe : " + imagesWithFaces.images[0].faces[0].gender.gender
                            
                            print(status)
                        }
                    })
                    //*******************************************************************
                    
                }
                
            }
    
        }
            
     }

    
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func backPressed(_ sender: Any) {
        
        dismiss(animated: true)

    }
   
}

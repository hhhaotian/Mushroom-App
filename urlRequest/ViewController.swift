//
//  ViewController.swift
//  urlRequest
//
//  Created by Haotian Zhu on 22/5/19.
//  Copyright © 2019 Haotian Zhu. All rights reserved.
//

import UIKit

struct Message: Decodable{
    
    let timestamp: String
    let className: String
    let classProb: String
    let boxes: Array<Array<Float>>
    
}

struct Connection: Decodable {
    let timestamp: String
    let connection: String
}




class ViewController: UIViewController, UINavigationControllerDelegate,  UIImagePickerControllerDelegate {
    
    
    
//    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var predictImage: UIImage!
    var labelInfo: String!
    var httpResponse: Int!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        view.addSubview(activityIndicator)
    }
    
    
    @IBAction func getRequest(_ sender: Any) {
//        indicator.startAnimating()
        activityIndicator.startAnimating()
        myGETRequest()
            { josn, error in
                if let connection = josn as? Connection{
//                    print(connection.timestamp)
//                    print(httpResponse)
//                    name = connection.timestamp
//                    group.leave()
                    self.labelInfo = connection.timestamp
                    DispatchQueue.main.async() {
                        // your UI update code
                        if self.httpResponse == 200{
                            self.label.text = self.labelInfo
                            self.activityIndicator.stopAnimating()
                        }
                    }
                    
                }
            
        }

    }
    
    
    @IBAction func postRequest(_ sender: Any) {
        activityIndicator.startAnimating()
        myPOSTRequest(){
            json, error in
            if let json = json as? Message{
                self.labelInfo = json.className
                var boxes: Array<Array<Float>>!
                boxes = json.boxes
                print(boxes[0] as Any)
                DispatchQueue.main.async() {
                    // your UI update code
                    if self.httpResponse == 200{
                        self.label.text = self.labelInfo
                        self.activityIndicator.stopAnimating()
//                        print(json.boxes)
                    }
                    if self.httpResponse == 500{
                        self.activityIndicator.stopAnimating()
                        self.label.text = "HTTP 500 Error"
                    }
                }
                
            }
        }
        
    }
    
    
    func encodeImage()-> Data{

        let imageData = predictImage.pngData()
        let encodeing = imageData?.base64EncodedData()
        return encodeing!

    }
    
    
    
    @IBAction func photoSource(_ sender: Any) {
        label.text = "Press POST buttom"
        print("photo button")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo source", message: "Select photo from", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
                
            }else{
                
                print("Camera is not available")
                
            }
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Image Library", style: .default, handler: { (UIAlertAction) in
            
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.predictImage = image
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func myGETRequest(completion: @escaping (_ json: Any?, _ error: Error?)->()){
        guard let url = URL(string: "http://35.201.9.84/") else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            if let response = response{
                let httpStatus = response as? HTTPURLResponse
                self.httpResponse = httpStatus!.statusCode
                print(httpStatus!.statusCode)
               
            }
            
            if let data = data{
                do{
                    
                    let connection = try JSONDecoder().decode(Connection.self, from: data)

                    completion(connection, error)
                    
                } catch{
                    print(error)
                }
                
            }
            
            }.resume()
    }
    
    
    func myPOSTRequest(completion: @escaping (_ json: Any?, _ error: Error?)->()){
        label.text = "Please wait..."
        let output = encodeImage()
        guard let url = URL(string: "http://35.201.9.84/api/test") else {return}
        var request = URLRequest(url: url)
        request.addValue("image/jpeg", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = output
        let session = URLSession.shared
        session.dataTask(with: request){
            (data, response, error) in
            if let response = response{

                let httpStatus = response as? HTTPURLResponse
                self.httpResponse = httpStatus!.statusCode
                print(httpStatus!.statusCode)
            }
            
            if let data = data{
                do{
                    let json = try JSONDecoder().decode(Message.self, from: data)
                    completion(json, error)
                    
                } catch{
                    print(error)
                }
            }
            }.resume()
        
    }
    
    
}


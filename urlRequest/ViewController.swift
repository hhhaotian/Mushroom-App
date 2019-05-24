//
//  ViewController.swift
//  urlRequest
//
//  Created by Haotian Zhu on 22/5/19.
//  Copyright © 2019 Haotian Zhu. All rights reserved.
//

import UIKit

struct Message{
    let timestamp: String
    let from: String
    let msg: Dictionary<String, Any>
    
    init(json: [String: Any]) {
        timestamp = json["timestamp"] as? String ?? ""
        from = json["from"] as? String ?? ""
        msg = json["msg"] as? Dictionary<String, Any> ?? [:]
        
    }
}

var httpResponse: Int = 0

class ViewController: UIViewController, UINavigationControllerDelegate,  UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//         let image: UIImage
        
    }
    
    
    @IBAction func getRequest(_ sender: Any) {
        
        guard let url = URL(string: "http://35.201.9.84/") else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            if let data = data{
                do{
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {return}
                    let message = Message(json: json)
                    print(message.msg)
//                    imageType.text = message.msg
                    
                } catch{
                    print(error)
                }

            }
            
        }.resume()
        
    }
    
    func encodeImage()-> Data{

        let image = UIImage(named: "img856")
//        let iamgeView = UIImageView(image: image)
//        view.addSubview(iamgeView)
        let imageData = image?.pngData()
        let encodeing = imageData?.base64EncodedData()
        return encodeing!

    }
    
   
    
    @IBAction func postRequest(_ sender: Any) {
        
        let output = encodeImage()
        guard let url = URL(string: "http://35.201.9.84/api/test") else {return}
        var request = URLRequest(url: url)
        request.addValue("image/jpeg", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = output
        print(request)
        var name: String?
        let session = URLSession.shared
        session.dataTask(with: request){
            (data, response, error) in
            if let response = response{
//                print (response)
                let httpStatus = response as? HTTPURLResponse
                if httpStatus!.statusCode == 200{
                    httpResponse = httpStatus!.statusCode
                }
            }
            
            if let data = data{
                do{
                    
                    
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {return}
//                    print(json)
                    let message = Message(json: json)
                    print(message.msg["className"]!)
                    name = message.msg["className"] as! String
                   

                } catch{
                    print(error)
                }
            }
        }.resume()
        
        print(name)
        if httpResponse == 200{
//            print(name!)
            label.text = name
            print(name)
        }
        
        
    }
    
    
    
    @IBAction func photoSource(_ sender: Any) {
        label.text = "photo"
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
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
//    func URLRequest(completion: @escaping ){
//        
//    }
    
    
}


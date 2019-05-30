//
//  MushroomIntro.swift
//  urlRequest
//
//  Created by Haotian Zhu on 26/5/19.
//  Copyright © 2019 Haotian Zhu. All rights reserved.
//

import UIKit
import SwiftyJSON

class MushroomIntro: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var mushroomName: UILabel!
    
    var mushroomType: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mushroomType = receivedData.className!
        mushroomName.text = mushroomType
        let num : Int = mushwiki[mushroomType]["feature"].array!.count
        print("num of rows " + String(num))
        return num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = mushwiki[mushroomType]["feature"][indexPath.row].stringValue
        print("cell value")
        return cell
    }

}

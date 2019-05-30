//
//  MushroomIntro.swift
//  urlRequest
//
//  Created by Haotian Zhu on 26/5/19.
//  Copyright © 2019 Haotian Zhu. All rights reserved.
//

import UIKit
import SwiftyJSON

<<<<<<< HEAD
class MushroomIntro: UIViewController {

    @IBOutlet weak var mushroomName: UILabel!
  
    @IBOutlet weak var infocell1: UILabel!
    
    
    let mushroomsDict = [
        "button mushroom":["feature":"Eatable","info":"Also called the table mushroom, white mushroom, common mushroom, cultivated mushroom, and called champignon de Paris in France, it is one of the most widely cultivated mushrooms in the world."],
        "death cap":["feature":"Poisonous", "info":"Smooth, yellowish-green to olive-brown cap; white gills; white stem; membranous skirt on stem; cup-like structure around the base of the stem."],
        "earthball mushroom":["feature":"Poisonous", "info":"This very common mushroom appears to be responsible for the most mushroom poisonings each year in the UK. This is possibly due to confusion with Common Puffballs or even Truffles. "],
        "ghost fungus":["feature":"Poisonous","info":"information of ghost fungus"],
        "haymakers mushroom":["feature":"Poisonous", "info":"In short grass lawns, pastures, from late spring to early autumn. Very common and widespread."],
        "king oyster mushroom":["feature":"Eatable", "info":"Information of king oyster mushroom"],
        "pleurotus ostreatus":["feature":"Eatable", "info":"Information of pleurotus ostreatus"],
        "shaggy parasol":["feature":"Eatable", "info":"Information of shaggy parasol"],
        "shimeji mushroom":["feature":"Eatble", "info":"Inforamtion of shimeji mushroom"],
        "slippery jack":["feature":"Poision", "info":"Information of slippery jack"],
        "yellow-staining mushroom":["feature":"Poision", "info":"Information of yellow-staining mushroom"],
        "green-spored parasol":["feature":"Poision", "info":"Information of green-spored parasol"],
        "none":["feature":"None", "info":"None"]
    ]
=======
class MushroomIntro: UIViewController, UITableViewDelegate, UITableViewDataSource {
>>>>>>> 0ebb082bb5e6c1ae24e48859d21ee7b6c4e8e434
    
    @IBOutlet var mushroomName: UILabel!
    
    var mushroomType: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
<<<<<<< HEAD
        var mushroomType: String = ""
        do{
            mushroomType = receivedData.className ?? "none"
            mushroomName.text = mushroomType
//            cell1.text = mushroomsDict[mushroomType]?["feature"]
        
        }catch{
            print("no value")
        }
=======
>>>>>>> 0ebb082bb5e6c1ae24e48859d21ee7b6c4e8e434
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

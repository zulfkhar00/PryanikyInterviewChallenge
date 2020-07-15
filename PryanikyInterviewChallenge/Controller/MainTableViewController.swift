//
//  MainTableViewController.swift
//  PryanikyInterviewChallenge
//
//  Created by Zulfkhar Maukey on 15/7/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import UIKit
import SDWebImage

class MainTableViewController: UITableViewController, DataProviderDelegate {
    
    var dataProvider: DataProvider?
    var dataArray = [Data]()
    var viewArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataProvider = DataProvider()
        dataProvider?.delegate = self
        dataProvider?.fetchData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let name = viewArray[indexPath.row]
        
        if name == "hz" {
            for singleData in dataArray {
                if singleData.name == name {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as! TextTableViewCell
                    cell.nameLabel.text = singleData.data.text
                    return cell
                }
            }
        }
        
        if name == "picture" {
            for singleData in dataArray {
                if singleData.name == name {
                    let url = URL(string: singleData.data.url!)
                    let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageTableViewCell
                    cell.firstImageView.sd_setImage(with: url)
                    return cell
                }
            }
        }
        
        if name == "selector" {
            for singleData in dataArray {
                if singleData.name == name {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "testingCell", for: indexPath) as! TestingTableViewCell
                    let optionButtons = cell.optionButtons!
                    let count = singleData.data.variants!.count
                    
                    for button in optionButtons {
                        button.isHidden = true
                    }
                    
                    for index in 0..<count {
                        let titleForButton = singleData.data.variants![index].text
                        optionButtons[index].setTitle(titleForButton, for: .normal)
                        optionButtons[index].isHidden = false
                    }
                    
                    return cell
                }
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as! TextTableViewCell
        cell.nameLabel.text = "No matching data found."
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = viewArray[indexPath.row]
        var id: String?
        
        if name == "selector" {
            for singleData in dataArray {
                if singleData.name == name {
                    id = String(singleData.data.selectedId!)
                }
            }
        }
        
        let ac = UIAlertController(title: "Info", message: "name: \(name), id: \(id ?? "no")", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        ac.addAction(action)
        present(ac, animated: true)
        
    }
    
    func get(data: Model) {
        dataArray = data.data
        viewArray = data.view
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    @IBAction func questionAnswered(_ sender: UIButton) {
        let buttonTitle = sender.currentTitle!
        var id = ""
        
        for singleData in dataArray {
            if singleData.name == "selector" {
                guard let variants = singleData.data.variants else {return}
                for option in variants {
                    if option.text == buttonTitle {
                        id = String(option.id)
                    }
                }
            }
        }
        
        let ac = UIAlertController(title: "Button Info", message: "id: \(id)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        ac.addAction(action)
        present(ac, animated: true)
    }
    

}

//
//  TableListViewController.swift
//  GoogleMapsTest
//
//  Created by Gerardo Castillo Duran  on 2/24/19.
//  Copyright © 2019 Gerardo Castillo Duran . All rights reserved.
//

import UIKit

class TableListViewController: UIViewController {
    var address = [Address]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    
}
    func loadData(){
        Address.allAddreess { (addresAPI, success) in
            if success == true{
                self.address = addresAPI!
                self.tableView.reloadData()
            }
        }
    }

}

extension TableListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return address.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as? BasicInfoTableViewCell
        cell?.lblTitle.text = address[indexPath.row].alias
     
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueInfoAll", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is  AllInfoViewController
        {
            let vc = segue.destination as? AllInfoViewController
            vc?.address = address[(sender as? Int)!]
    }
    }
    
}

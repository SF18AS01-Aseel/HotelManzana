//
//  SelectRoomTypeTableViewController.swift
//  HotelManzana
//
//  Created by Aseel Alshohatee on 3/5/19.
//  Copyright © 2019 Aseel Alshohatee. All rights reserved.
//

import UIKit

protocol SelectRoomTypeTableViewControllerDelegate {   //p. 709
    func didSelect(roomType: RoomType);
}

class SelectRoomTypeTableViewController: UITableViewController {   //p. 706
    
    var delegate: SelectRoomTypeTableViewControllerDelegate?; //p. 709
   
    var roomType: RoomType?;                                  //p. 708

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return RoomType.all.count;
        
    }
    // this method is what fix the cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCell", for: indexPath);
        
        // Configure the cell...
        let roomType: RoomType = RoomType.all[indexPath.row];   //p. 707
        cell.textLabel?.text = roomType.name;
        cell.detailTextLabel?.text = String(format: "$ %.2f", roomType.price);
        
        if let selectedRoomType: RoomType = self.roomType,
            selectedRoomType == roomType {   //call our type method
            cell.accessoryType = .checkmark;
        } else {
            cell.accessoryType = .none;
        }
        
       
        
        return cell;
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        roomType = RoomType.all[indexPath.row]
        delegate?.didSelect(roomType: roomType!)
        tableView.reloadData()
    }
    
    
}

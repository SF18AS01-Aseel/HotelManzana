//
//  AddRegistrationTableViewController.swift
//  HotelManzana
//
//  Created by Aseel Alshohatee on 3/5/19.
//  Copyright © 2019 Aseel Alshohatee. All rights reserved.
//

import UIKit
var x = 328;

class AddRegistrationTableViewController: UITableViewController,
SelectRoomTypeTableViewControllerDelegate{
    
    
    var registration: Registration? {
        get {
            
            
            guard let roomType = roomType else { return nil }
            
            let firstName = firstNameTextField.text ?? ""
            let lastName = lastNameTextField.text ?? ""
            let email = emailTextField.text ?? ""
            let checkInDate = checkInDatePicker.date
            let checkOutDate = checkOutDatePicker.date
            let numberOfAdults = Int(numberOfAdultStepper.value)
            let numberOfChildren = Int(numberOfChildrenStepper.value)
            let hasWifi = wifiSwitch.isOn
            
            return Registration(firstName: firstName,
                                lastName: lastName,
                                emailAddress: email,
                                checkInDate: checkInDate,
                                checkOutDate: checkOutDate,
                                numberOfAdults: numberOfAdults,
                                numberOfChildren: numberOfChildren,
                                roomType: roomType,
                                hasWifi: hasWifi)
        }
        
        set (newRegistration){
            guard let newRegistration: Registration = newRegistration else {
                fatalError("received nil registration");
                
            }
            firstNameTextField.text = newRegistration.firstName
            lastNameTextField.text = newRegistration.lastName
            emailTextField.text = newRegistration.emailAddress
            
            checkInDatePicker.date = newRegistration.checkInDate;
            checkOutDatePicker.date = newRegistration.checkOutDate;
            
            numberOfAdultStepper.value = Double(newRegistration.numberOfAdults)
            numberOfChildrenStepper.value = Double(newRegistration.numberOfChildren)
            
            wifiSwitch.isOn = newRegistration.hasWifi;
            roomType = newRegistration.roomType;
        }
    }
    
    
    
    
    // cell group 1
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // cell group 2
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    // cell group 3
    
    
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var numberOfAdultStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    
    //// cell group 4
    
    @IBOutlet weak var wifiSwitch: UISwitch!
    // to hide the cell(date picker) while is not use
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section:
        1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section:
        1)
    
    var isCheckInDatePickerShown: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    
    var isCheckOutDatePickerShown: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    //// cell group 5
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    var roomType: RoomType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad");
        updateDateViews();
        // to get today date  and make sure that nothing go before today date
        let midnightToday: Date = Calendar.current.startOfDay(for: Date());   //p. 695
        checkInDatePicker.minimumDate = midnightToday;
        checkInDatePicker.date = midnightToday;
        updateNumberOfGuests();
        updateRoomType()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
    }
    
    /*
     @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem) {
     let firstName = firstNameTextField.text ?? ""
     let lastName = lastNameTextField.text ?? ""
     let email = emailTextField.text ?? ""
     let checkInDate = checkInDatePicker.date
     let checkOutDate = checkOutDatePicker.date
     let numberOfAdults = Int(numberOfAdultStepper.value)
     let numberOfChildren = Int(numberOfChildrenStepper.value)
     let hasWifi = wifiSwitch.isOn
     
     print("DONE TAPPED")
     print("firstName: \(firstName)")
     print("lastName: \(lastName)")
     print("email: \(email)")
     print("checkIn: \(checkInDate)")
     print("checkOut: \(checkOutDate)")
     print("numberOfAdults: \(numberOfAdults)")
     print("numberOfChildren: \(numberOfChildren)")
     
     print("wifi: \(hasWifi)")
     print("email: \(email)")
     print("checkIn: \(checkInDate)")
     print("checkOut: \(checkOutDate)")
     print("numberOfAdults: \(numberOfAdults)")
     print("numberOfChildren: \(numberOfChildren)")
     print("wifi: \(hasWifi)")
     //print("roomType: \(roomChoice)")
     
     
     
     
     }
     
     
     */
    func updateDateViews(){
        
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(60 * 60 * 24);   //p. 695
        // chaning the date into string
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        checkInDateLabel.text = dateFormatter.string(from:
            checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from:
            checkOutDatePicker.date)
        
        
        
    }
    
    
    @IBAction func datePickerValueChange(_ sender: UIDatePicker) {
        updateDateViews();
    }
    
    
    
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {   //p. 698
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row):
            return isCheckInDatePickerShown ? 216.0 : 0.0;
            
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row):
            return isCheckOutDatePickerShown ? 216.0 : 0.0;
            
        default:
            return 44.0
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section,
              checkInDatePickerCellIndexPath.row - 1):
            
            /*  if isCheckInDatePickerShown {
             isCheckInDatePickerShown = false
             } else if isCheckOutDatePickerShown {
             isCheckOutDatePickerShown = false
             isCheckInDatePickerShown = true
             } else {
             isCheckInDatePickerShown = true
             }*/
            // to make it easier
            isCheckInDatePickerShown = !isCheckInDatePickerShown;
            isCheckOutDatePickerShown = false;
            tableView.performBatchUpdates(nil)
            /*
             tableView.beginUpdates()
             tableView.endUpdates()
             */
        case (checkOutDatePickerCellIndexPath.section,
              checkOutDatePickerCellIndexPath.row - 1):
            /*
             if isCheckOutDatePickerShown {
             isCheckOutDatePickerShown = false
             } else if isCheckInDatePickerShown {
             isCheckInDatePickerShown = false
             isCheckOutDatePickerShown = true
             } else {
             isCheckOutDatePickerShown = true
             }
             */
            // to make it easier
            isCheckOutDatePickerShown = !isCheckOutDatePickerShown;
            isCheckInDatePickerShown = false;
            
            tableView.performBatchUpdates(nil)
            /*tableView.beginUpdates()
             tableView.endUpdates()
             */
        default:
            break
        }
    }
    
    func updateNumberOfGuests() {
        numberOfAdultsLabel.text = "\(Int(numberOfAdultStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests();
    }
    @IBAction func wifiSwitchChanged(_ sender: Any) {
        
    }
    func updateRoomType() {   //pp. 710-711
        if let roomType: RoomType = roomType {
            roomTypeLabel.text = roomType.name;
        } else {
            roomTypeLabel.text = "Not Set";
        }
    }
    func didSelect(roomType: RoomType) {   //p. 711
        self.roomType = roomType;
        updateRoomType();
    }
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        if segue.identifier == "SelectRoomType" {
            let destinationViewController = segue.destination as?
            SelectRoomTypeTableViewController
            destinationViewController?.delegate = self
            destinationViewController?.roomType = roomType
        }
        
    }
    // MARK: - Table view data source
    
}

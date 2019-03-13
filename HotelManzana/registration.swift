//
//  registration.swift
//  HotelManzana
//
//  Created by Aseel Alshohatee on 3/5/19.
//  Copyright © 2019 Aseel Alshohatee. All rights reserved.
//

import Foundation
struct Registration {
    var firstName: String;
    var lastName: String;
    var emailAddress: String;
    
    var checkInDate: Date;
    var checkOutDate: Date;
    
    var numberOfAdults: Int;
    var numberOfChildren: Int;
    
    var roomType: RoomType;
    var hasWifi: Bool;
}


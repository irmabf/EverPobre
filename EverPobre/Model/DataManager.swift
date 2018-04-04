//
//  DataManager.swift
//  EverPobre
//
//  Created by Irma Blanco on 04/04/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit
import CoreData

class DataManager: NSObject {
    
    static let sharedManager = DataManager()
    
    lazy var peristentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Everpobre")
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            
            if let err = error {
                //Error to handle
                print(err)
            }
            
        })
        
        return container
    }()
}

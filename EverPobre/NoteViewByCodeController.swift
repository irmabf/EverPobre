//
//  NoteViewByCodeController.swift
//  EverPobre
//
//  Created by Irma Blanco on 02/04/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

class NoteViewByCodeController: UIViewController {

    //Siempre que hago una view por codigo necesito un metodo donde defino la vista
    override func loadView() {
        let backView = UIView()
        backView.backgroundColor = .orange
        self.view = backView
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

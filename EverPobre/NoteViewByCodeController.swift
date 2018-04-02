//
//  NoteViewByCodeController.swift
//  EverPobre
//
//  Created by Irma Blanco on 02/04/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

class NoteViewByCodeController: UIViewController {

    // Mark: - Properties
    let dateLabel = UILabel()
    let expirationDate = UILabel()
    let titleTextField = UITextField()
    let noteTextView = UITextView()
    
    
    
    //Siempre que hago una view por codigo necesito un metodo donde defino la vista
    override func loadView() {
        
        let backView = UIView()
        
        backView.backgroundColor = .white
        
        dateLabel.text = "25/01/2018"
        backView.addSubview(dateLabel)
        
        expirationDate.text = "00/00/00"
        backView.addSubview(expirationDate)
        
        titleTextField.placeholder = "Title note"
        backView.addSubview(titleTextField)
        
        noteTextView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"
        backView.addSubview(noteTextView)
        
        // Mark: - Autolayout
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        expirationDate.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        noteTextView.translatesAutoresizingMaskIntoConstraints = false
        
        //Creo un diccionario de vistas
        let viewDict =
            ["dateLabel": dateLabel, "noteTextView": noteTextView, "titleTextField": titleTextField,"expirationDate": expirationDate
        ]
        //Horizontals
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "|-10-[titleTextField]-10-[expirationDate]-10-[dateLabel]-10-|", options: [], metrics: nil, views: viewDict)
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "|-10-[noteTextView]-10-|", options: [], metrics: nil, views: viewDict))
        
        //Verticals
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[dateLabel]-10-[noteTextView]-10-|", options: [], metrics: nil, views: viewDict))
        
    
    
        constraints.append(NSLayoutConstraint(item: dateLabel, attribute: .top, relatedBy: .equal, toItem: backView, attribute: .top, multiplier: 1, constant: 20))
        
       
        constraints.append(NSLayoutConstraint(item: titleTextField, attribute: .lastBaseline, relatedBy: .equal, toItem: dateLabel, attribute: .lastBaseline, multiplier: 1, constant: 0))
        
           constraints.append(NSLayoutConstraint(item: expirationDate, attribute: .lastBaseline, relatedBy: .equal, toItem: dateLabel, attribute: .lastBaseline, multiplier: 1, constant: 0))
        
        backView.addConstraints(constraints)
        
        self.view = backView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

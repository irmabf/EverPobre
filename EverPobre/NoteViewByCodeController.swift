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
    
    let imageView = UIImageView()
    
    
    var topImgConstraint: NSLayoutConstraint!
    var bottomImgConstraint: NSLayoutConstraint!
    var leftImgConstraint: NSLayoutConstraint!
    var rightImgConstraint: NSLayoutConstraint!
    
    var relativePoint: CGPoint!
    
    
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
        
        imageView.backgroundColor = .orange
        backView.addSubview(imageView)
        
        // Mark: - Autolayout
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        expirationDate.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        noteTextView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        //Creo un diccionario de vistas
        let viewDict =
            ["dateLabel": dateLabel, "noteTextView": noteTextView, "titleTextField": titleTextField,"expirationDate": expirationDate
        ]
        //Horizontals
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "|-10-[titleTextField]-10-[expirationDate]-10-[dateLabel]-10-|", options: [], metrics: nil, views: viewDict)
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "|-10-[noteTextView]-10-|", options: [], metrics: nil, views: viewDict))
        
        //Verticals
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[dateLabel]-10-[noteTextView]-10-|", options: [], metrics: nil, views: viewDict))
        
        
        
    
    
        constraints.append(NSLayoutConstraint(item: dateLabel, attribute: .top, relatedBy: .equal, toItem: backView.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 20))
        
       
        constraints.append(NSLayoutConstraint(item: titleTextField, attribute: .lastBaseline, relatedBy: .equal, toItem: dateLabel, attribute: .lastBaseline, multiplier: 1, constant: 0))
        
           constraints.append(NSLayoutConstraint(item: expirationDate, attribute: .lastBaseline, relatedBy: .equal, toItem: dateLabel, attribute: .lastBaseline, multiplier: 1, constant: 0))
        
        //Img view constraints
    
      
        // Img View Constraint.
        
        topImgConstraint = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: noteTextView, attribute: .top, multiplier: 1, constant: 20)
        
        bottomImgConstraint = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: noteTextView, attribute: .bottom, multiplier: 1, constant: -20)
        
        leftImgConstraint = NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: noteTextView, attribute: .left, multiplier: 1, constant: 20)
        
        rightImgConstraint = NSLayoutConstraint(item: imageView, attribute: .right, relatedBy: .equal, toItem: noteTextView, attribute: .right, multiplier: 1, constant: -20)
        
        var imgConstraints = [NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 100)]
        
        imgConstraints.append(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 150))
        
        imgConstraints.append(contentsOf: [topImgConstraint,bottomImgConstraint,leftImgConstraint,rightImgConstraint])
        
        
        backView.addConstraints(constraints)
        backView.addConstraints(imgConstraints)
        
        NSLayoutConstraint.deactivate([bottomImgConstraint,rightImgConstraint])
        
        
        
        self.view = backView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeGesture = UISwipeGestureRecognizer(target: noteTextView, action: #selector(resignFirstResponder))
        
        swipeGesture.direction = .down
        
        view.addGestureRecognizer(swipeGesture)
        
        imageView.isUserInteractionEnabled = true
        
        
//        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(moveImage))
        
//        doubleTapGesture.numberOfTapsRequired = 2
        
//        imageView.addGestureRecognizer(doubleTapGesture)
        
        let moveViewGesture = UILongPressGestureRecognizer(target: self, action: #selector(userMoveImage))
        
        imageView.addGestureRecognizer(moveViewGesture)
    }
    
    @objc func userMoveImage(longPressGesture: UILongPressGestureRecognizer){
     
        
        switch longPressGesture.state {
        case .began:
            closeKeyBoard()
            relativePoint = longPressGesture.location(in: imageView)
            UIView.animate(withDuration: 0.1, animations: {
                self.imageView.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
            })
        case .changed:
            let location = longPressGesture.location(in: noteTextView)
            leftImgConstraint.constant = location.x - relativePoint.x
            topImgConstraint.constant = location.y - relativePoint.y
        case .ended, .cancelled:
            UIView.animate(withDuration: 0.1, animations: {
                self.imageView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            })
        default:
            break
        }
        
        //let locationInSuperView = longPressGesture.location(in: view)
        
        
        
        //print("View \(locationInSuperView.x) y noteTextView \(location.x)")
        /*let location = longPressGesture.location(in: noteTextView)
        leftImgConstraint.constant = location.x
        topImgConstraint.constant = location.y*/
    }
    
   
    @objc func moveImage(tapGesture:UITapGestureRecognizer){

        
        if topImgConstraint.isActive{
            if leftImgConstraint.isActive{
                leftImgConstraint.isActive = false
                rightImgConstraint.isActive = true
            }
            else{
                topImgConstraint.isActive = false
                bottomImgConstraint.isActive = true
            }
        }
        else{
            if leftImgConstraint.isActive{
                bottomImgConstraint.isActive = false
                topImgConstraint.isActive = true
            }
            else{
                rightImgConstraint.isActive = false
                leftImgConstraint.isActive = true
            }
        }
        
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidLayoutSubviews() {
        var rect = view.convert(imageView.frame, to: noteTextView )
        rect = rect.insetBy(dx: -15, dy: -15)
        let paths = UIBezierPath(rect: rect)
        noteTextView.textContainer.exclusionPaths = [paths]
    }
    @objc func closeKeyBoard() {
        print("No es continuado, es discreto")
        if noteTextView.isFirstResponder{
            noteTextView.resignFirstResponder()
        }else if titleTextField.isFirstResponder{
            titleTextField.resignFirstResponder()
        }
    }

}


























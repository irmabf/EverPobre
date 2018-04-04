//
//  NotesTableViewController.swift
//  EverPobre
//
//  Created by Irma Blanco on 04/04/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {

    
    var noteList:[Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewNote))
    }

   
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return noteList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
        }

        cell?.textLabel?.text = noteList[indexPath.row].title
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteViewController = NoteViewByCodeController()
        noteViewController.note = noteList[indexPath.row]
        navigationController?.pushViewController(noteViewController, animated: true)
    }
    
    @objc func addNewNote() {
        
    }

}

//
//  ToDoDetailTableViewController.swift
//  ToDoList
//
//  Created by William Templeton on 2/9/20.
//  Copyright © 2020 William Templeton. All rights reserved.
//

import UIKit

class ToDoDetailTableViewController: UITableViewController {
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var noteView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        //this chunk below can be easily copy/pasted into new projects
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
    }
}

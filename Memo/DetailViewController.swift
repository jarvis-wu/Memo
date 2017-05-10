//
//  DetailViewController.swift
//  Memo
//
//  Created by Jarvis@Rave on 2017-05-09.
//  Copyright © 2017 Jarvis@Rave. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
	
	@IBOutlet weak private var titleTextField: UITextField!
	
	@IBOutlet weak private var notesTextField: UITextField!
	
	private var userDefaults: UserDefaults = UserDefaults.standard
	
	private var newMemo: Memo = Memo()
	
	var toDoData: NSDictionary = NSDictionary()
	
	@IBAction private func deleteItem(_ sender: AnyObject) {
		newMemo.userDefaults = userDefaults
		newMemo.dataSet.setObject(titleTextField.text!, forKey: "itemTitle" as NSCopying)
		newMemo.dataSet.setObject(notesTextField.text!, forKey: "itemNote" as NSCopying)
		newMemo.itemList = userDefaults.object(forKey: "itemList") as? NSMutableArray
		newMemo.delete()
		// Dismiss the current VC from navigation stack. No segue needed.
		self.navigationController?.popViewController(animated: true)
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		titleTextField.isUserInteractionEnabled = false
		notesTextField.isUserInteractionEnabled = false
		titleTextField.text = toDoData.object(forKey: "itemTitle") as? String
		notesTextField.text = toDoData.object(forKey: "itemNote") as? String
	}

}

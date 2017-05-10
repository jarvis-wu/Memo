//
//  AddViewController.swift
//  Memo
//
//  Created by Jarvis@Rave on 2017-05-09.
//  Copyright © 2017 Jarvis@Rave. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
	
	@IBOutlet weak private var titleTextField: UITextField!
	
	@IBOutlet weak private var notesTextField: UITextField!
	
	private var userDefaults: UserDefaults = UserDefaults.standard
	
	private var newMemo: Memo = Memo()
	
	@IBAction private func addButtonTapped(_ sender: Any) {
		newMemo.userDefaults = userDefaults
		newMemo.dataSet.setObject(titleTextField.text!, forKey: "itemTitle" as NSCopying)
		newMemo.dataSet.setObject(notesTextField.text!, forKey: "itemNote" as NSCopying)
		newMemo.itemList = userDefaults.object(forKey: "itemList") as? NSMutableArray
		newMemo.add()
		self.navigationController?.popViewController(animated: true) // dismiss AddVC
	}
	
	// Enable keyboard dismissal
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
		view.endEditing(true)
		super.touchesBegan(touches, with: event)
	}
	
}

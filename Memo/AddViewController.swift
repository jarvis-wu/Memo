//
//  AddViewController.swift
//  Memo
//
//  Created by Jarvis@Rave on 2017-05-09.
//  Copyright © 2017 Jarvis@Rave. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

	@IBOutlet weak var titleTextField: UITextField!
	
	@IBOutlet weak var notesTextField: UITextField!
	
	@IBAction func addButtonTapped(_ sender: Any) {
		let userDefaults: UserDefaults = UserDefaults.standard
		
		var itemList: NSMutableArray? = userDefaults.object(forKey: "itemList") as? NSMutableArray
		
		let dataSet: NSMutableDictionary = NSMutableDictionary()
		dataSet.setObject(titleTextField.text!, forKey: "itemTitle" as NSCopying)
		dataSet.setObject(notesTextField.text!, forKey: "itemNote" as NSCopying)
		
		if (itemList != nil) { // data already available
			let newMutableList: NSMutableArray = NSMutableArray()
			for dict in itemList! {
				newMutableList.add(dict as! NSDictionary)
			}
			
			userDefaults.removeObject(forKey: "itemList")
			newMutableList.add(dataSet)
			userDefaults.set(newMutableList, forKey: "itemList")
			
		} else { // this is the first item in the todo list
			userDefaults.removeObject(forKey: "itemList")
			itemList = NSMutableArray()
			itemList!.add(dataSet)
			userDefaults.set(itemList, forKey: "itemList")
		}
		
		userDefaults.synchronize()
		
		self.navigationController?.popViewController(animated: true)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
		view.endEditing(true)
		super.touchesBegan(touches, with: event)
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

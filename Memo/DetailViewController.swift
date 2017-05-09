//
//  DetailViewController.swift
//  Memo
//
//  Created by Jarvis@Rave on 2017-05-09.
//  Copyright © 2017 Jarvis@Rave. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
	
	@IBOutlet weak var titleTextField: UITextField!
	
	@IBOutlet weak var notesTextField: UITextField!
	
	var toDoData: NSDictionary = NSDictionary()
	
	@IBAction func deleteItem(_ sender: Any) {
		let userDefaults: UserDefaults = UserDefaults.standard
		let itemListArray: NSMutableArray = userDefaults.object(forKey: "itemList") as! NSMutableArray
		let mutableItemList: NSMutableArray = NSMutableArray()
		
		for dict in itemListArray {
			mutableItemList.add(dict as! NSDictionary)
		}
		
		mutableItemList.remove(toDoData)
		
		userDefaults.removeObject(forKey: "itemList")
		userDefaults.set(mutableItemList, forKey: "itemList")
		
		userDefaults.synchronize()
		self.navigationController?.popViewController(animated: true)
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		titleTextField.isUserInteractionEnabled = false
		notesTextField.isUserInteractionEnabled = false
		
		titleTextField.text = toDoData.object(forKey: "itemTitle") as? String
		notesTextField.text = toDoData.object(forKey: "itemNote") as? String
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

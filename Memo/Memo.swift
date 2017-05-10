//
//  Memo.swift
//  Memo
//
//  Created by Jarvis@Rave on 2017-05-10.
//  Copyright © 2017 Jarvis@Rave. All rights reserved.
//

import Foundation

class Memo {
	
	var userDefaults: UserDefaults = UserDefaults()
	
	var itemList: NSMutableArray?
	
	var dataSet: NSMutableDictionary = NSMutableDictionary()
	
	func add() {
		if (itemList != nil) {	// data already available
			let newMutableList: NSMutableArray = NSMutableArray()
			for dict in itemList! {
				newMutableList.add(dict as! NSDictionary)
			}
			userDefaults.removeObject(forKey: "itemList")
			newMutableList.add(dataSet)
			userDefaults.set(newMutableList, forKey: "itemList")
			
		} else {	// this is the first item in the todo list
			userDefaults.removeObject(forKey: "itemList")
			itemList = NSMutableArray()
			itemList!.add(dataSet)
			userDefaults.set(itemList, forKey: "itemList")
		}
		
		userDefaults.synchronize()
	}
	
	func delete() {
		let temporaryItemList: NSMutableArray = NSMutableArray()
		for dict in itemList! {
			temporaryItemList.add(dict as! NSDictionary)
		} // copying
		temporaryItemList.remove(dataSet)
		userDefaults.removeObject(forKey: "itemList")
		userDefaults.set(temporaryItemList, forKey: "itemList")

		userDefaults.synchronize()
	}
	
}


import Foundation

class ItemListManager {
    
    var itemList: [SingleItem] = []
    
    func addItem(item: SingleItem) {
        itemList.append(item)
    }
    
    func deleteItem(index: Int) {
        itemList.remove(at: index)
    }
    
}

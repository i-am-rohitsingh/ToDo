//
//  ToDoItem.swift
//  ToDo
//
//  Created by Rohit Kumar on 18/01/21.
//

import Foundation
import CoreData

public class ToDoItem: NSManagedObject, Identifiable {
    @NSManaged public var itemName: String
    @NSManaged public var itemCreatedOn: Date
    @NSManaged public var itemDescription: String
}

extension ToDoItem{
    static func getAllToDoItems() -> NSFetchRequest<ToDoItem>{
        let request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest() as! NSFetchRequest<ToDoItem>
        let sortDescriptor = NSSortDescriptor(key: "itemCreatedOn", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }
}

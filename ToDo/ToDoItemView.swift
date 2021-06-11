//
//  ToDoItemView.swift
//  ToDo
//
//  Created by Rohit Kumar on 18/01/21.
//

import SwiftUI

struct ToDoItemView: View {
    var toDoItemName: String = ""
    var toDoItemCreatedOn: Date?
    
    let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    let taskTimeFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(toDoItemName).font(.title3)
                Text("\(toDoItemCreatedOn!, formatter: taskDateFormat) \(toDoItemCreatedOn!, formatter: taskTimeFormat)").font(.caption)
            }
        }
    }
    
}

struct ToDoItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoItemView(toDoItemName: "Title", toDoItemCreatedOn: Date())
    }
}

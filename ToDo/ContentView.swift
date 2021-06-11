//
//  ContentView.swift
//  ToDo
//
//  Created by Rohit Kumar on 18/01/21.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: ToDoItem.getAllToDoItems()) var toDoItems: FetchedResults<ToDoItem>
    
    @State private var newToDo = ""
    
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("What's Next?")){
                    HStack{
                        TextField("New Item", text: self.$newToDo)
                        Button(action: {
                            if !self.newToDo.isEmpty{
                                let toDoItem = ToDoItem(context: self.managedObjectContext)
                                toDoItem.itemName = self.newToDo
                                toDoItem.itemCreatedOn = Date()
                                do{
                                    try self.managedObjectContext.save()
                                }catch{
                                    print(error)
                                }
                                
                                self.newToDo = ""
                            }
                        }){
                            Image(systemName: "plus.circle.fill").foregroundColor(.green).imageScale(.large)
                        }
                    }
                }.font(.headline)
                
                Section(header: Text("To Do's")){
                    if toDoItems.count > 0{
                        ForEach (self.toDoItems){toDoItem in
                            ToDoItemView(toDoItemName: toDoItem.itemName, toDoItemCreatedOn: toDoItem.itemCreatedOn)
                        }.onDelete(perform: { indexSet in
                            let deleteItem = self.toDoItems[indexSet.first!]
                            self.managedObjectContext.delete(deleteItem)
                            
                            do{
                                try managedObjectContext.save()
                            }catch{
                                print(error)
                            }
                        })
                    }else{
                        HStack{
                            VStack(alignment: .center){
                                Image("Minion")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 350.0, height: 350.0, alignment: .center)
                                    .clipped()
                                Text("You're all caught up!!!")
                            }
                        }
                    }
                }.font(.headline)
            }
            .navigationBarTitle(Text("ToDo"))
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

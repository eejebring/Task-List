//
//  ContentView.swift
//  Task-List
//
//  Created by Emil Ejebring on 2022-10-25.
//

import SwiftUI

class Task: Identifiable, ObservableObject {
    var id = UUID()
    var name: String
    var complete = false
    var categoryID: Int
    
    func toggle() { complete.toggle() }
    
    init(name: String, category: Int = 0, complete: Bool = false) {
        self.name = name
        self.complete = complete
        self.categoryID = category
    }
}

struct ContentView: View {
    var CATEGORIES = ["Uncategorized","Activities","Kitchen","Work"]
    @State var input = ""
    @State var allTasks = [Task(name: "the stuff")]
    @State var selectedCategory = 0
    
    func addTask () {
        if (input != "")  {
            DispatchQueue.main.async {
                allTasks.append(Task(name: input, category: selectedCategory))
                input = ""
            }
        }
    }
    
    @State var promptCreateTask = false
    
    var body: some View {
        VStack {
            List {
                ForEach (allTasks) { task in
                    if (selectedCategory == 0 || task.categoryID == selectedCategory) {
                        Button(action: {
                            task.toggle()
                            
                            //is it really stupid, if it is stupid but it works?
                            allTasks.append(Task(name:"not here"))
                            allTasks.removeLast()
                        }) {
                            HStack {
                                Image(systemName: task.complete ? "checkmark.square" : "square")
                                /*@START_MENU_TOKEN@*/Text(task.name)/*@END_MENU_TOKEN@*/
                            }
                            HStack {
                                Text(CATEGORIES[task.categoryID])
                            }
                        }
                        .foregroundColor(task.complete ? .green : .black)
                        .swipeActions(edge: .trailing) {
                            Button ("Delete", action: {
                                allTasks = allTasks.filter({$0.id != task.id})
                            })
                        }
                    }
                }
            }
            Menu(CATEGORIES[selectedCategory]) {
                ForEach (CATEGORIES.indices) { id in
                    Button(CATEGORIES[id], action: {selectedCategory = id})
                }
            }
            Divider()
            
            Button (action: {promptCreateTask = true}) {
                HStack {
                    Image(systemName: "plus")
                    Text("new Task")
                }
            }
            .alert( "Create task", isPresented: $promptCreateTask) {
                TextField("Task name", text: $input)
                    .onSubmit (addTask)
                Button ("Create", action: addTask)
                Button ("cancel", role: .cancel) {}
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

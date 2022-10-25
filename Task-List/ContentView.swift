//
//  ContentView.swift
//  Task-List
//
//  Created by Emil Ejebring on 2022-10-25.
//

import SwiftUI

class Task: Identifiable{
    var id = UUID()
    var name: String
    var complete = false
    
    func toggle() { complete.toggle() }
    
    init(name: String, complete: Bool = false) {
        self.name = name
        self.complete = complete
    }
}



struct ContentView: View {
    @State var input = ""
    @State var categories = [
        "uncetegorized": [Task(name: "the stuff")],
        "kitchen": [Task(name: "get ketchup")],
        "Activites": [],
        "School": []
    ]
    
    func addTask (category: String){
        if (input != "")  {
            categories[category].append(Task(name: input))
            input = ""
        }
    }
    
    @State var promptCreateTask = false
    
    var body: some View {
        VStack {
            List {
                ForEach (categories.keys.sorted(), id: \.self) { category in
                    ForEach (categories[category]!) { task in
                        Button(action: task.toggle) {
                            HStack {
                                Image(systemName: task.complete ? "checkmark.square" : "square")
                                /*@START_MENU_TOKEN@*/Text(task.name)/*@END_MENU_TOKEN@*/
                            }
                            Text(category)
                        }
                        .foregroundColor(task.complete ? .green : .black)
                        .swipeActions(edge: .trailing) {
                            Button ("Delete", action: {
                                categories[category] = (categories[category] ?? []).filter({$0.id != task.id})
                            })
                        }
                    }
                }
            }
            
            Button (action: {promptCreateTask = true}) {
                HStack {
                    Image(systemName: "plus")
                    Text("new Task")
                }
            }
            .alert( "Create task", isPresented: $promptCreateTask) {
                var category = "School"
                TextField("Task name", text: $input)
                    .onSubmit ({addTask(category)})
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

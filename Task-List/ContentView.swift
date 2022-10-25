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
    @State var allTasks = [
        Task(name: "the thing")
    ]
    @State var input = ""
    
    func addTask (){
            if (input != "")  {
                allTasks.append(Task(name: input))
                input = ""
            }
    }
    @State var promptCreateTask = false
    
    var body: some View {
        VStack {
            Text("Task-List")
            List {
                ForEach(allTasks) { task in
                    Button(action: task.toggle) {
                        HStack {
                            Image(systemName: task.complete ? "checkmark.square" : "square")
                            /*@START_MENU_TOKEN@*/Text(task.name)/*@END_MENU_TOKEN@*/
                        }
                    }.foregroundColor(task.complete ? .green : .black)
                }
            }
            
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

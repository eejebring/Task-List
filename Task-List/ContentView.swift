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
    
    var body: some View {
        VStack {
            List {
                ForEach(allTasks) { task in
                    Button(action: {
                        allTasks.append(Task(name: "new"))
                        task.toggle()
                    }) {
                        HStack {
                            Image(systemName: task.complete ? "checkmark.square" : "square")
                            /*@START_MENU_TOKEN@*/Text(task.name)/*@END_MENU_TOKEN@*/
                        }
                    }.foregroundColor(task.complete ? .green : .black)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

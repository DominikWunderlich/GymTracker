//
//  ContentView.swift
//  GymTracker
//
//  Created by Dominik Wunderlich on 20.07.25.
//

import SwiftUI

struct ContentView: View {
    @State private var workouts: [String] = []
    @State private var showingAddWorkout = false
    @State private var newWorkoutName = ""
    
    var body: some View {
        NavigationView {
            List(workouts, id: \.self) { workout in Text(workout)
            }
            .navigationTitle("Workouts")
            .navigationBarItems(trailing:
                                    Button(action: {
                showingAddWorkout = true}) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddWorkout) {
                VStack {
                    Text("Add New Workout")
                        .font(.headline)
                    TextField("Workout Name", text: $newWorkoutName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button("Add") {
                        if !newWorkoutName.trimmingCharacters(in: .whitespaces).isEmpty {
                                workouts.append(newWorkoutName)
                                newWorkoutName = ""
                                showingAddWorkout = false
                        }
                    }
                    .padding()
                    Button("Cancel") {
                        newWorkoutName = ""
                        showingAddWorkout = false
                    }
                }
                .padding()
            }
                
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

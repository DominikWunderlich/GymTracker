//
//  ContentView.swift
//  GymTracker
//
//  Created by Dominik Wunderlich on 20.07.25.
//

import SwiftUI

// Data-Models
struct Exercise: Identifiable, Codable {
	let id = UUID()
	var name: String
	var sets: Int
	var weight: Double
	var reps: Int
}

struct Workout: Identifiable {
	let id = UUID()
	var name: String
	var exercises: [Exercise] = []
}

struct ContentView: View {
	@State private var workouts: [Workout] = []
	@State private var showingAddWorkout = false
	@State private var newWorkoutName = ""
	
	var body: some View {
		NavigationView {
			List {
				ForEach(workouts) { workout in
					NavigationLink(destination: WorkoutDetailView(workout: binding(for: workout))) {
						Text(workout.name)
					}
				}
			}
			.navigationTitle("Workouts")
			.navigationBarItems(trailing:
				Button(action: {
					showingAddWorkout = true
				}) {
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
							workouts.append(Workout(name: newWorkoutName))
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
	
	// Hilfsfunktion um Binding auf ein Workout zu bekommen
	private func binding(for workout: Workout) -> Binding<Workout> {
		guard let index = workouts.firstIndex(where: { $0.id == workout.id }) else {
			fatalError("Workout not found")
		}
		return $workouts[index]
	}
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

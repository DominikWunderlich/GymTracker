//
//  ContentView.swift
//  GymTracker
//
//  Created by Dominik Wunderlich on 20.07.25.
//

import SwiftUI

// Data-Models
struct Exercise: Identifiable, Codable {
    let id: UUID
	var name: String
	var sets: Int
	var weight: Double
	var reps: Int
    
    init(id: UUID = UUID(), name: String, sets: Int, weight: Double, reps: Int) {
        self.id = id
        self.name = name
        self.sets = sets
        self.weight = weight
        self.reps = reps
    }
}

struct Workout: Identifiable {
	let id = UUID()
	var name: String
	var exercises: [Exercise] = []
}

struct TrainingLogEntry: Identifiable, Codable {
    let id: UUID
    let date: Date
    let workoutName: String
    let performedExercises: [Exercise]
    
    init(id: UUID = UUID(), date: Date = Date(), workoutName: String, performedExercises: [Exercise]) {
        self.id = id
        self.date = date
        self.workoutName = workoutName
        self.performedExercises = performedExercises
    }
}

struct ContentView: View {
	@State private var workouts: [Workout] = []
	@State private var showingAddWorkout = false
	@State private var newWorkoutName = ""
    @State private var trainingLogs: [TrainingLogEntry] = []
	
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("MY Workouts")) {
                    ForEach(workouts) { workout in
                        NavigationLink(destination: WorkoutDetailView(
                            workout: binding(for: workout),
                            onLogCompleted: { logEntry in
                                trainingLogs.append(logEntry)
                            })) {
                            Text(workout.name)
                        }
                    }
                }

                if !trainingLogs.isEmpty {
                    Section(header: Text("Training History")) {
                        ForEach(trainingLogs) { log in
                            VStack(alignment: .leading) {
                                Text(log.workoutName)
                                    .font(.headline)
                                Text(log.date, style: .date)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Workouts")
            .navigationBarItems(
                trailing: Button {
                    showingAddWorkout = true
                } label: {
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

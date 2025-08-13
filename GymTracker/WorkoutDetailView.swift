//
//  WorkoutDetailView.swift
//  GymTracker
//
//  Created by Dominik Wunderlich on 11.08.25.
//

import SwiftUI

struct WorkoutDetailView: View {
	@Binding var workout: Workout
    var onLogCompleted: (TrainingLogEntry) -> Void
	@State private var newExerciseName = ""
	@State private var newExerciseSets = ""
	@State private var newExerciseReps = ""
	@State private var newExerciseWeight = ""
	
	var body: some View {
		VStack {
            // Start Training Button
            NavigationLink(destination: WorkoutSessionView(workout: workout) {
                logEntry in onLogCompleted(logEntry)
            }) {
                Text("Start Training")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
			List {
				ForEach(workout.exercises) { exercise in
					HStack {
						Text(exercise.name)
							.font(.headline)
						Spacer()
						Text("\(exercise.sets) Sets")
						Text("× \(exercise.reps) Reps")
						Text("× \(exercise.weight, specifier: "%.1f") kg")
	
					}
				}
			}
			
			HStack {
				TextField("Exercise Name", text: $newExerciseName)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.frame(maxWidth: 150)
				
				TextField("Sets", text: $newExerciseSets)
					.keyboardType(.numberPad)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.frame(maxWidth: 60)
				
				TextField("Reps", text: $newExerciseReps)
					.keyboardType(.numberPad)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.frame(maxWidth: 60)
				
				TextField("kg", text: $newExerciseWeight)
					.keyboardType(.decimalPad)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.frame(maxWidth: 60)
					
				
				Button("Add") {
					if let weight = Double(newExerciseWeight),
					   let reps = Int(newExerciseReps),
					   let sets = Int(newExerciseSets),
					   !newExerciseName.trimmingCharacters(in: .whitespaces).isEmpty {
						
						workout.exercises.append(
							Exercise(name: newExerciseName, sets: sets, weight: weight, reps: reps)
						)
						
						// Felder leeren
						newExerciseName = ""
						newExerciseSets = ""
						newExerciseWeight = ""
						newExerciseReps = ""
					}

				}
                .padding()
			}
		}
		.navigationTitle(workout.name)
	}
}

//
//  WorkoutDetailView.swift
//  GymTracker
//
//  Created by Dominik Wunderlich on 11.08.25.
//

import SwiftUI

struct WorkoutDetailView: View {
	@Binding var workout: Workout
	@State private var newExerciseName = ""
	@State private var newExerciseSets = ""
	@State private var newExerciseReps = ""
	@State private var newExerciseWeight = ""
	
	var body: some View {
		VStack {
			List {
				ForEach(workout.exercises) { exercise in
					HStack {
						Text(exercise.name)
							.font(.headline)
						Spacer()
						Text("\(exercise.sets) Sets")
						Text("× \(exercise.reps) Wdh")
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
					
				
				Button("Hinzufügen") {
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
			}
			.padding()
		}
		.navigationTitle(workout.name)
	}
}

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
	
	var body: some View {
		VStack {
			List {
				ForEach(workout.exercises) { exercise in
					Text(exercise.name)
				}
			}
			
			HStack {
				TextField("Neue Übung", text: $newExerciseName)
					.textFieldStyle(RoundedBorderTextFieldStyle())
				Button("Hinzufügen") {
					if !newExerciseName.trimmingCharacters(in: .whitespaces).isEmpty {
						workout.exercises.append(Exercise(name: newExerciseName))
						newExerciseName = ""
					}
				}
			}
			.padding()
		}
		.navigationTitle(workout.name)
	}
}

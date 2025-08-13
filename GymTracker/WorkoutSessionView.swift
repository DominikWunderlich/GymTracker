//
//  WorkoutSessionView.swift
//  GymTracker
//
//  Created by Dominik Wunderlich on 13.08.25.
//

import SwiftUI

struct WorkoutSessionView: View {
    var workout: Workout
    var onFinish: (TrainingLogEntry) -> Void
    
    // Save exercise values during the workout
    @State private var performedExercises: [Exercise]
    
    init(workout: Workout, onFinish: @escaping (TrainingLogEntry) -> Void) {
        self.workout = workout
        self.onFinish = onFinish
        // Startvalues: from the pre-created Exercises
        _performedExercises = State(initialValue: workout.exercises)
    }
    
    var body: some View {
        Form {
            ForEach($performedExercises) { $exercise in
                Section(header: Text(exercise.name)) {
                    // Sets
                    Stepper("Sets: \(exercise.sets)", value: $exercise.sets, in: 1...10)
                    
                    // Reps
                    HStack {
                        Text("Reps:")
                        TextField("", value: $exercise.reps, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                            .frame(width: 60)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    // Weight
                    HStack {
                        Text("Weight (kg):")
                        TextField("Weight", value: $exercise.weight, formatter: decimalFormatter)
                            .keyboardType(.decimalPad)
                            .frame(width: 80)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
            }
        }
        .navigationTitle("Training: \(workout.name)")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Finish") {
                    let logEntry = TrainingLogEntry(
                        workoutName: workout.name,
                        performedExercises: performedExercises
                    )
                    onFinish(logEntry)
                }
            }
        }
    }
    // Decimal Formatter
    private var decimalFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        return formatter
    }
}

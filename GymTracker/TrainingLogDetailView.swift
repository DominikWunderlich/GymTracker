//
//  TrainingLogDetailView.swift
//  GymTracker
//
//  Created by Dominik Wunderlich on 17.08.25.
//

import SwiftUI

struct TrainingLogDetailView: View {
    // Diese View erwartet einen TrainingLogEntry, um dessen Details anzuzeigen
    let logEntry: TrainingLogEntry

    var body: some View {
        List {
            // Zeige die einzelnen Übungen des absolvierten Trainings an
            ForEach(logEntry.performedExercises) { exercise in
                VStack(alignment: .leading, spacing: 5) {
                    Text(exercise.name)
                        .font(.headline)
                    Text("Sätze: \(exercise.sets)  ·  Wdh: \(exercise.reps)  ·  Gewicht: \(exercise.weight, specifier: "%.1f") kg")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 5)
            }
        }
        .navigationTitle(logEntry.workoutName) // Setzt den Titel der Ansicht
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(logEntry.workoutName).font(.headline)
                    Text(logEntry.date, style: .date).font(.footnote).foregroundColor(.secondary)
                }
            }
        }
    }
}

// #Preview {
//    TrainingLogDetailView()
// }

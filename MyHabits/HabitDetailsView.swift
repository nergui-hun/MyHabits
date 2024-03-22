//
//  HabitDetailsVoew.swift
//  MyHabits
//
//  Created by M M on 3/16/24.
//

import SwiftUI

struct HabitDetailsView: View {

    private let store = HabitsStore.shared
    let habit: Habit
    @State var trackedDates: [Date] = []
    @Binding var refreshFlag: Bool

    @State private var onEditingHabit = false

    var body: some View {
        NavigationView {
            List {
                Section("АКТИВНОСТЬ") {
                    ForEach(0..<store.dates.count) { index in
                        HStack {
                            Text(store.trackDateString(forIndex: index)!)
                            if store.habit(habit, isTrackedIn: store.dates[index]) {
                                Spacer()
                                Image(systemName: "checkmark")
                                    .foregroundStyle(Color.accentColor)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Edit")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    onEditingHabit = true
                }
            }
        }
        .fullScreenCover(isPresented: $onEditingHabit, onDismiss: {refreshFlag.toggle()}, content: {
            EditHabitView(onDismiss: { refreshFlag.toggle() }, refreshList: {refreshFlag.toggle()}, habit: habit)
        })
    }

    private func fetchTrackedDates(habit: Habit) -> [Date] {
        var tracked: [Date] = []
        for index in 0..<store.dates.count {
            if store.habit(habit, isTrackedIn: store.dates[index]) {
                tracked.append(store.dates[index])
            }
        }
        return tracked
    }
}

/*#Preview {
    HabitDetailsView(habit: Habit(name: "1", date: Date(), color: Color.accentColor))
}*/

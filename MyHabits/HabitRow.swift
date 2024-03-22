//
//  HabitCellView.swift
//  MyHabits
//
//  Created by M M on 3/14/24.
//

import SwiftUI

struct HabitRow: View {
    @ObservedObject var store = HabitsStore.shared

    private let habit: Habit
    @State var isEditingHabit = false
    @Binding var refreshFlag: Bool

    init(habit: Habit, refreshFlag: Binding<Bool>) {
        self.habit = habit
        self._refreshFlag = refreshFlag
    }

    var body: some View {
        NavigationLink(destination: HabitDetailsView(habit: habit, refreshFlag: $refreshFlag)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(habit.name)
                        .font(.custom("SFProText-Semibold", size: 17))
                        .foregroundStyle(habit.color)
                        .padding(EdgeInsets(.init(top: 8, leading: 0, bottom: 0, trailing: 0)))
                    Text(habit.dateString)
                        .font(.custom("SFProText-Regular", size: 13))
                        .foregroundStyle(.gray)
                        .padding(EdgeInsets(.init(top: 0, leading: 0, bottom: 16, trailing: 0)))
                    Text("Counter: \(habit.trackDates.count)")
                        .font(.custom("SFProText-Regular", size: 13))
                        .foregroundStyle(.secondary)
                        .padding(EdgeInsets(.init(top: 8, leading: 0, bottom: 8, trailing: 0)))
                }

                Spacer()

                Button(action: {
                    if habit.isAlreadyTakenToday {
                        store.untrack(habit)
                    } else {
                        store.track(habit)
                    }
                    refreshFlag.toggle()
                }) {
                    Image(systemName: habit.isAlreadyTakenToday ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundStyle(habit.color)
                }

                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

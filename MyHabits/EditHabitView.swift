//
//  EditHabitView.swift
//  MyHabits
//
//  Created by M M on 3/16/24.
//

import SwiftUI

struct EditHabitView: View {
    private let store = HabitsStore.shared

    @Environment(\.presentationMode) var presentationMode
    var onDismiss: () -> Void
    var refreshList: () -> Void

    let habit: Habit?
    private var habitText: String
    @State private var habitName: String
    @State private var selectedColor: Color
    @State private var selectedTime: Date
    @State private var showAlert = false
    @State private var deleteHabit = false

    init(onDismiss: @escaping () -> Void, refreshList: @escaping () -> Void, habit: Habit?) {
        self.onDismiss = onDismiss
        self.refreshList = refreshList
        self.habit = habit

        if let habit = habit {
            self.habitText = habit.name
            self.habitName = habit.name
            self.selectedColor = habit.color
            self.selectedTime = habit.date
        } else {
            self.habitText = "Start jogging, sleep for 8 hours etc"
            self.habitName = ""
            self.selectedColor = Color.orange
            self.selectedTime = Date()
        }
    }

    var body: some View {
        NavigationView {

            VStack(alignment: .leading) {
                Text("NAME")
                    .font(.custom("SFProText-Semibold", size: 13))
                TextField(habitText, text: $habitName)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                Text("COLOR")
                    .font(.custom("SFProText-Semibold", size: 13))
                ColorPicker(selection: $selectedColor, supportsOpacity: false, label: {})
                    .frame(width: 25)
                Text("TIME")
                    .font(.custom("SFProText-Semibold", size: 13))
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
                HStack {
                    Text("Every day at")
                    Text(formattedTime(selectedTime))
                        .foregroundStyle(Color.accentColor)
                }
                DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .padding(.leading)
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showAlert = true
                    }) {
                        Text("Delete habit")
                    }
                    .opacity(habit == nil ? 0 : 1) //hide and disable the button
                    .foregroundStyle(Color.red)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Delete habit?"), message: Text(""), primaryButton: .default(Text("Yes"), action: {
                            if let habit = habit {
                                store.deleteHabit(habit: habit)
                            }
                            onDismiss()
                            refreshList()
                            presentationMode.wrappedValue.dismiss()
                        }), secondaryButton: .cancel(Text("Cancel")))
                    }
                    Spacer()
                }
            }
            .onDisappear { refreshList() }
            .padding()
            .navigationTitle("Edit habit")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        onDismiss()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        if let habit = habit {
                            store.editHabit(habit: habit, newData: Habit(name: habitName, date: selectedTime, color: selectedColor))
                            store.save()
                            onDismiss()
                            refreshList()
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            store.habits.append(Habit(name: habitName, date: selectedTime, color: selectedColor))
                            store.save()
                            onDismiss()
                            refreshList()
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }

    private func formattedTime(_ time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: time)
    }
}

#Preview {
    EditHabitView(onDismiss: {}, refreshList: {}, habit: nil)
}

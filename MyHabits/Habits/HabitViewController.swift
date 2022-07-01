//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by M M on 6/12/22.
//

import Foundation
import UIKit

class HabitViewController: UIViewController {

    //=============================PROPERTIES=================================//
    /*
     1. private let saveButton: UIBarButtonItem
     2. private let habitNameLabel: UILabel
     3. private let habitNameTextField: UITextField
     4. private let habitColorLabel: UILabel
     5. private lazy var habitColorButton: UIButton
     6. private let habitTimeLabel: UILabel
     7. private let timeLabel: UILabel
     8. private let timePicker: UIDatePicker
     9. private let contentView: UIView
     10. let elementSize: CGFloat
     11. private let dateFormatter: DateFormatter()
     */

    private let habitsViewController = HabitsViewController()
    var isNew: Bool = true
    var habitID: Int = -1

    private lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Сохранить"
        button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "SFProText-Semibold", size: 17)!], for: .normal)
        button.tintColor = UIColor(named: "Lilac")
        button.target = self
        button.action = #selector(saveHabit)
        return button
    } ()

    private let habitNameLabel: UILabel = {
        let label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.tintColor = .black
        label.font = UIFont(name: "SFProText-Semibold", size: 13)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()

    private let habitNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.text = ""

        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    } ()

    private let habitColorLabel: UILabel = {
        let label = UILabel()
        label.text = "ЦВЕТ"
        label.tintColor = .black
        label.font = UIFont(name: "SFProText-Semibold", size: 13)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()

    let colorWell: UIColorWell = {
        let colorWell = UIColorWell()
        colorWell.supportsAlpha = false
        colorWell.selectedColor = .systemOrange
        colorWell.translatesAutoresizingMaskIntoConstraints = false
        return colorWell
    } ()

    private let habitTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ"
        label.tintColor = .black
        label.font = UIFont(name: "SFProText-Semibold", size: 13)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = formatTime()
        label.tintColor = .black
        label.font = UIFont(name: "SFProText-Regular", size: 17)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()

    private let timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.locale = Locale(identifier: "ru-RU")
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.addTarget(HabitViewController.self, action: #selector(labelTimeSet), for: .allTouchEvents)

        timePicker.translatesAutoresizingMaskIntoConstraints = false
        return timePicker
    } ()

    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.red, for: .normal)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()

    private let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        return contentView
    } ()

    let elementSize: CGFloat = 30

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru-RU")
        formatter.timeStyle = .short
        return formatter
    } ()

    private lazy var timeString: String = "Каждый день в \(timePicker.date.formatted(date: .omitted, time: .shortened))"

    

    //===============================METHODS==================================//
    /*
     1. override func viewDidLoad()
     2. override func viewDidAppear(_ animated: Bool)
     3. private func setupView()
     4. private func setConstraints()
     5. private func addElements()
     6. private func setupNavBar()
     7. @objc func formatTime()
     8. @objc func labelTimeSet()
     9. @objc func saveHabit()
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        deleteButton.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        habitNameTextField.becomeFirstResponder()
    }

    private func setupView() {
        view.backgroundColor = UIColor(named: "ghostWhite")
        
        setupNavBar()
        addElements()
        setConstraints()

        deleteButton.isHidden = habitID == -1 ? true : false
    }

    private func setConstraints() {
        contentView.pin(to: view)
        let spacing: CGFloat = 16

        NSLayoutConstraint.activate([
            habitNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing),
            habitNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: spacing),
            habitNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -spacing),
            habitNameLabel.heightAnchor.constraint(equalToConstant: elementSize),

            habitNameTextField.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor),
            habitNameTextField.leftAnchor.constraint(equalTo: habitNameLabel.leftAnchor),
            habitNameTextField.rightAnchor.constraint(equalTo: habitNameLabel.rightAnchor),
            habitNameTextField.heightAnchor.constraint(equalToConstant: elementSize),

            habitColorLabel.topAnchor.constraint(equalTo: habitNameTextField.bottomAnchor),
            habitColorLabel.leftAnchor.constraint(equalTo: habitNameLabel.leftAnchor),
            habitColorLabel.rightAnchor.constraint(equalTo: habitNameLabel.rightAnchor),
            habitColorLabel.heightAnchor.constraint(equalToConstant: elementSize),

            colorWell.topAnchor.constraint(equalTo: habitColorLabel.bottomAnchor),
            colorWell.leftAnchor.constraint(equalTo: habitNameLabel.leftAnchor),
            colorWell.widthAnchor.constraint(equalToConstant: elementSize),
            colorWell.heightAnchor.constraint(equalToConstant: elementSize),

            habitTimeLabel.topAnchor.constraint(equalTo: colorWell.bottomAnchor),
            habitTimeLabel.leftAnchor.constraint(equalTo: habitNameLabel.leftAnchor),
            habitTimeLabel.rightAnchor.constraint(equalTo: habitNameLabel.rightAnchor),
            habitTimeLabel.heightAnchor.constraint(equalToConstant: elementSize),

            timeLabel.topAnchor.constraint(equalTo: habitTimeLabel.bottomAnchor),
            timeLabel.leftAnchor.constraint(equalTo: habitNameLabel.leftAnchor),
            timeLabel.rightAnchor.constraint(equalTo: habitNameLabel.rightAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: elementSize),

            timePicker.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            timePicker.leftAnchor.constraint(equalTo: habitNameLabel.leftAnchor),

            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18),
            deleteButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
            deleteButton.widthAnchor.constraint(equalToConstant: 180)
        ].compactMap({ $0 }))
    }
    
    @objc func deleteHabit() {
        let alert = UIAlertController(title: "Удалить привычку" , message: "Вы хотите удалить привычку \"\(habitNameTextField.text!)\"?", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        let deleteAction = UIAlertAction(title: "Удалить", style: .default) { (action) -> Void in
            HabitsStore.shared.habits.remove(at: self.habitID)
            let habitsViewController = HabitsViewController()
            self.navigationController?.pushViewController(habitsViewController, animated: true)
            self.dismiss(animated: true, completion: nil)
        }

        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        self.present(alert, animated: true, completion: nil)
    }

    private func addElements() {
        contentView.addSubview(habitNameLabel)
        contentView.addSubview(habitNameTextField)
        contentView.addSubview(habitColorLabel)
        contentView.addSubview(colorWell)
        contentView.addSubview(habitTimeLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(timePicker)
        contentView.addSubview(deleteButton)
        view.addSubview(contentView)
    }

    private func setupNavBar() {
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "ghostWhite")
        self.navigationController?.navigationBar.tintColor = UIColor(named: "Lilac")
        self.navigationItem.setRightBarButton(saveButton, animated: true)
        self.navigationController?.navigationBar.prefersLargeTitles = false

        title = habitID == -1 ? "Создать" : "Править"
    }

    @objc func formatTime() -> String {
        var timeString: String = ""
        timeString = "Каждый день в \(dateFormatter.string(from: timePicker.date))"
        return timeString
    }

    @objc func labelTimeSet() {
        timeLabel.text = "Каждый день в \(formatTime())"
    }

    @objc func saveHabit(_ sender: UIBarButtonItem) {
        var nameExists: Bool = false
        if let name: String = habitNameTextField.text {
            if name != "" {
                nameExists = true
                if let color = colorWell.selectedColor {
                    let store = HabitsStore.shared

                    if habitID == -1 {
                        let newHabit = Habit(name: name, date: timePicker.date, color: color)
                        store.habits.append(newHabit)
                    } else {
                        HabitsStore.shared.habits[habitID].name.removeAll(keepingCapacity: true)
                        HabitsStore.shared.habits[habitID].name = name
                        HabitsStore.shared.habits[habitID].color = color
                        HabitsStore.shared.habits[habitID].date = timePicker.date
                    }

                    let habitsViewController = HabitsViewController()
                    self.navigationController?.pushViewController(habitsViewController, animated: true)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }

        if nameExists == false {
            print("Введите название привычки")
        }
    }

    func editHabit(name: String, color: UIColor, date: Date) {
        setupView()

        habitNameTextField.text = name
        colorWell.selectedColor = color
        timePicker.date = date
    }

}

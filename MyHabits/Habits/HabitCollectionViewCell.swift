//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by M M on 6/18/22.
//

import Foundation
import UIKit

class HabitCollectionViewCell: UICollectionViewCell {

    // MARK: - Delegates

    weak var habitDelegate: HabitDelegate?

    // MARK: - View Elements
    
    private let habitView: UIView = {
        let habitView = UIView()
        habitView.backgroundColor = .white
        habitView.clipsToBounds = true
        habitView.layer.cornerRadius = 8
        habitView.translatesAutoresizingMaskIntoConstraints = false
        return habitView
    } ()

    private let habitNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Semibold", size: 17)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let habitTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()

    private let counterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()

    let checkBoxButton: UIButton = {
        let button = UIButton()
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(markHabit), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()

    private var habit: [Habit] = []

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Methods
    
    private func addElements() {
        self.contentView.addSubview(habitView)
        habitView.addSubview(habitNameLabel)
        habitView.addSubview(habitTimeLabel)
        habitView.addSubview(counterLabel)
        habitView.addSubview(checkBoxButton)
    }


    private func setConstraints() {
        let spacing: CGFloat = 20
        habitView.pin(to: self.contentView)

        NSLayoutConstraint.activate([
            habitNameLabel.topAnchor.constraint(equalTo: habitView.topAnchor, constant: spacing),
            habitNameLabel.leftAnchor.constraint(equalTo: habitView.leftAnchor, constant: spacing),
            habitNameLabel.rightAnchor.constraint(equalTo: habitView.rightAnchor, constant: -103),

            habitTimeLabel.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: 4),
            habitTimeLabel.leftAnchor.constraint(equalTo: habitNameLabel.leftAnchor),
            habitTimeLabel.rightAnchor.constraint(equalTo: habitNameLabel.rightAnchor),
            habitTimeLabel.heightAnchor.constraint(equalToConstant: 12),

            counterLabel.bottomAnchor.constraint(equalTo: habitView.bottomAnchor, constant: -spacing),
            counterLabel.leftAnchor.constraint(equalTo: habitNameLabel.leftAnchor),
            counterLabel.widthAnchor.constraint(equalToConstant: 188),
            counterLabel.heightAnchor.constraint(equalToConstant: 18),

            checkBoxButton.topAnchor.constraint(equalTo: habitView.topAnchor, constant: 46),
            checkBoxButton.rightAnchor.constraint(equalTo: habitView.rightAnchor, constant: -25),
            checkBoxButton.widthAnchor.constraint(equalToConstant: 38),
            checkBoxButton.heightAnchor.constraint(equalToConstant: 38)
        ].compactMap({ $0 }))
    }

    func setup(id: Int) {
        habit = fetchData()
        habitNameLabel.text = habit[id].name
        habitNameLabel.textColor = habit[id].color
        habitTimeLabel.text = "\(habit[id].dateString)"
        checkBoxButton.tintColor = habit[id].color
        checkBoxButton.tag = id
        checkBoxImage(isTaken: habit[id].isAlreadyTakenToday)
        counterLabel.text = "Счётчик: \(habit[id].trackDates.count)"
    }

    private func checkBoxImage(isTaken: Bool) {
        if isTaken {
            checkBoxButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        } else {
            checkBoxButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }
    
    @objc func markHabit(sender: UIButton!) {
        if sender.image(for: .normal) == UIImage(systemName: "circle") {
            sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            HabitsStore.shared.track(HabitsStore.shared.habits[sender.tag])

            habitDelegate?.updateData()
        }
    }


    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension HabitCollectionViewCell {
    func fetchData() -> [Habit] {
        return HabitsStore.shared.habits
    }
}

//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by M M on 6/22/22.
//

import Foundation
import UIKit

class HabitDetailsViewController: UIViewController {

    // MARK: - Properties
    
    var dataSource: [Date] = []
    var habitID: Int = -1

    private let datesLabel: UILabel = {
        let label = UILabel()
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.16

        label.attributedText = NSMutableAttributedString(
            string: "АКТИВНОСТЬ", attributes: [NSAttributedString.Key.kern: -0.08,
                                               NSAttributedString.Key.paragraphStyle: paragraphStyle])

        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
        tableView.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: "detailsCell")

        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.estimatedRowHeight = UITableView.automaticDimension

        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    } ()


    private let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = UIColor(named: "ghostWhite")
        contentView.layer.borderColor = UIColor.systemGray2.cgColor
        contentView.layer.borderWidth = 0.5
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    } ()
    

    private lazy var editButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.style = .plain
        button.title = "Править"
        button.tintColor = UIColor(named: "Lilac")
        button.target = self
        button.action = #selector(editHabit)

        return button
    } ()


    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        dataSource = self.fetchData()
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        dataSource = self.fetchData()
    }


    private func setupView() {
        view.backgroundColor = .white
        setupNavBar()
        addElements()
        setConstraints()
    }


    private func addElements() {
        view.addSubview(contentView)
        contentView.addSubview(tableView)
        contentView.addSubview(datesLabel)
    }


    private func setConstraints() {
        contentView.pin(to: view)

        NSLayoutConstraint.activate([
            datesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            datesLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            datesLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            datesLabel.heightAnchor.constraint(equalToConstant: 18),

            tableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 47),
            tableView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }


    private func setupNavBar() {
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.setRightBarButton(editButton, animated: true)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.tintColor = UIColor(named: "Lilac")
    }


    @objc func editHabit() {
        let habitViewController = HabitViewController()
        self.navigationController?.pushViewController(habitViewController, animated: true)
        habitViewController.habitID = habitID
        habitViewController.title = "Править"
    }

}


// MARK: - Extensions

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath) as? HabitDetailsTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
            return cell
        }
        let dates = self.dataSource[indexPath.row]

        let isTracked = fetchTrackedDates(habit: HabitsStore.shared.habits[habitID])
        cell.setup(with: dates, isTracked: isTracked, id: indexPath.row)
        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


}

extension HabitDetailsViewController {

    func fetchData() -> [Date] {
        return HabitsStore.shared.dates
    }


    func fetchTrackedDates(habit: Habit) -> [Date] {
        var trackedDates: [Date] = []
        for index in 0..<HabitsStore.shared.dates.count {
            if HabitsStore.shared.habit(habit, isTrackedIn: HabitsStore.shared.dates[index]) == true {
                trackedDates.append(HabitsStore.shared.dates[index])
            }
        }
        return trackedDates.reversed()
    }
}

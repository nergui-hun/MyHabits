//
//  HabitDetailsTableViewCell.swift
//  MyHabits
//
//  Created by M M on 6/22/22.
//

import Foundation
import UIKit

class HabitDetailsTableViewCell: UITableViewCell {

    //=============================PROPERTIES=================================//
    let datesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()

    private let isTrackedLabel: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor(named: "Lilac")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()


    //===========================INITIALIZERS=================================//
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //===============================METHODS==================================//
    private func addSubviews() {
        addSubview(datesLabel)
        addSubview(isTrackedLabel)
    }

    private func setConstraints() {
        let datesWidth = (UIScreen.main.bounds.width - 32) * 0.75

        NSLayoutConstraint.activate([
            datesLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            datesLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            datesLabel.widthAnchor.constraint(equalToConstant: datesWidth),
            datesLabel.heightAnchor.constraint(equalToConstant: 40),

            isTrackedLabel.centerYAnchor.constraint(equalTo: datesLabel.centerYAnchor),
            isTrackedLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            isTrackedLabel.widthAnchor.constraint(equalToConstant: 20),
            isTrackedLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    func setup(with habit: Date, isTracked: [Date], id: Int) {
        datesLabel.text = "\(HabitsStore.shared.trackDateString(forIndex: id)!)"

        for index in 0..<isTracked.count {
            if habit == isTracked[index] {
                isTrackedLabel.image = UIImage(systemName: "checkmark")
            }
        }
    }

}

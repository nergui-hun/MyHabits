//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by M M on 6/18/22.
//

import Foundation
import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {

    // MARK: - View Elements
    
    private let progressView: UIView = {
        let progressView = UIView()
        progressView.backgroundColor = .white
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 8
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    } ()

    private let progressLabel: UILabel = {
        let label = UILabel()
        label.text = "Все получится!"
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()

    let percentageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        label.textColor = .systemGray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()

    private let progressBar: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.progressTintColor = UIColor(named: "Lilac")
        progressBar.trackTintColor = .systemGray
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    } ()
    

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
        self.contentView.addSubview(progressView)
        progressView.addSubview(progressLabel)
        progressView.addSubview(percentageLabel)
        progressView.addSubview(progressBar)
    }

    private func setConstraints() {
        let progressLabelWidth = self.contentView.bounds.width * 0.6
        progressView.pin(to: self.contentView)

        NSLayoutConstraint.activate([
            progressLabel.topAnchor.constraint(equalTo: progressView.topAnchor, constant: 10),
            progressLabel.leftAnchor.constraint(equalTo: progressView.leftAnchor, constant: 12),
            progressLabel.widthAnchor.constraint(equalToConstant: progressLabelWidth),
            progressLabel.bottomAnchor.constraint(equalTo: progressView.bottomAnchor, constant: -32),

            percentageLabel.topAnchor.constraint(equalTo: progressLabel.topAnchor),
            percentageLabel.leftAnchor.constraint(equalTo: progressLabel.rightAnchor, constant: 8),
            percentageLabel.rightAnchor.constraint(equalTo: progressView.rightAnchor, constant: -12),
            percentageLabel.bottomAnchor.constraint(equalTo: progressLabel.bottomAnchor),

            progressBar.topAnchor.constraint(equalTo: progressView.topAnchor, constant: 46),
            progressBar.leftAnchor.constraint(equalTo: progressView.leftAnchor, constant: 12),
            progressBar.rightAnchor.constraint(equalTo: progressView.rightAnchor, constant: -12),
            progressBar.heightAnchor.constraint(equalToConstant: 7)
        ])
    }

    func setup() {
        percentageLabel.text = "\(Int(HabitsStore.shared.todayProgress * 100)) %"
        progressBar.progress = HabitsStore.shared.todayProgress
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

//
//  InfoViewController.swift
//  MyHabits
//
//  Created by M M on 6/10/22.
//

import Foundation
import UIKit

class InfoViewController: UIViewController {

    //=============================PROPERTIES=================================//
    private let infoHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = StringsRU.infoHeaderRU.rawValue
        label.font = UIFont(name: "SFProText-Semibold", size: 17)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let infoTextLabel: UILabel = {
        let label = UILabel()
        label.text = StringsRU.infoTextRU.rawValue
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var infoScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.layer.borderWidth = 0.5
        scroll.layer.borderColor = UIColor.systemGray2.cgColor
        scroll.alwaysBounceVertical = true
        return scroll
    }()

    lazy var contentViewSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)

    //===============================METHODS==================================//
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func addElements() {
        infoScrollView.addSubview(infoHeaderLabel)
        infoScrollView.addSubview(infoTextLabel)
        view.addSubview(infoScrollView)
    }

    private func setConstraints() {
        infoScrollView.pin(to: view)

        let spacing: CGFloat = 16
        NSLayoutConstraint.activate([
            infoHeaderLabel.topAnchor.constraint(equalTo: infoScrollView.topAnchor, constant: spacing),
            infoHeaderLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: spacing),
            infoHeaderLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -spacing),

            infoTextLabel.topAnchor.constraint(equalTo: infoHeaderLabel.bottomAnchor, constant: spacing),
            infoTextLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: spacing),
            infoTextLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -spacing),
            infoTextLabel.bottomAnchor.constraint(equalTo: infoScrollView.bottomAnchor, constant: -spacing)
        ])

    }

    private func setupView() {
        view.backgroundColor = .white
        self.navigationItem.title = "Информация"
        self.navigationController?.navigationBar.backgroundColor = .white
        
        view.layer.borderColor = UIColor.systemGray2.cgColor
        view.layer.borderWidth = 0.5
        addElements()
        setConstraints()
    }
}

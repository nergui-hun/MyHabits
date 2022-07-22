//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by M M on 6/10/22.
//

import Foundation
import UIKit

    // MARK: - Protocols

protocol HabitDelegate: AnyObject {
    func updateData()
    func presentController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    func dismissController(animated: Bool, completion: (() -> Void)?)
}


class HabitsViewController: UIViewController {

    // MARK: - View Elements
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor(named: "ghostWhite")
        collection.alwaysBounceVertical = true
        collection.layer.borderColor = UIColor.systemGray2.cgColor
        collection.layer.borderWidth = 0.5
        collection.dataSource = self
        collection.delegate = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultCell")
        collection.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "progressBarCell")
        collection.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "habitCell")

        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    } ()


    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset.top = 18
        layout.sectionInset.bottom = 0
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 16
        return layout
    } ()


    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                     style: .plain, target: self, action: #selector(addHabit))
        button.tintColor = UIColor(named: "Lilac")
        return button
    }()
    

    var dataSource: [Habit] = []
    private let habitCollectionViewCell = HabitCollectionViewCell()
    private let progressCollectionViewCell = ProgressCollectionViewCell()
    let markButtonTap = UITapGestureRecognizer()



    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        dataSource = habitCollectionViewCell.fetchData()
        collectionView.reloadData()
    }


    func setupView() {
        view.backgroundColor = .white
        addElements()
        setConstraints()
    }


    private func addElements() {
        view.addSubview(collectionView)
    }


    private func setConstraints() {
        collectionView.pin(to: view)
    }


    private func setupNavBar() {
        title = "Сегодня"
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor =  UIColor(named: "Lilac")

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.setRightBarButton(addButton, animated: true)
        self.navigationItem.hidesBackButton = true
    }


    @objc private func addHabit(_ sender: UIBarButtonItem!) {
        let habitViewController = HabitViewController()
        habitViewController.habitID = -1
        self.navigationController?.pushViewController(habitViewController, animated: true)
    }


    private func itemSize(width: CGFloat, spacing: CGFloat, section: Int) -> CGSize {
        let neededWidth = width - 2 * spacing

        return CGSize(width: neededWidth, height: section == 0 ? 60 : 130)
    }

}


// MARK: - Extensions

extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { 2 }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.dataSource.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "progressBarCell", for: indexPath) as? ProgressCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
                return cell
            }
            cell.setup()
            return cell

        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "habitCell", for: indexPath) as? HabitCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
                return cell
            }
            cell.habitDelegate = self
            cell.setup(id: indexPath.row)
            return cell
        }
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing
        return self.itemSize(width: collectionView.frame.width, spacing: spacing ?? 0, section: indexPath.section)
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let habitDetailsViewController = HabitDetailsViewController()
        let habit = dataSource[indexPath.row]
        habitDetailsViewController.title = habit.name
        habitDetailsViewController.habitID = indexPath.row

        self.navigationController?.pushViewController(habitDetailsViewController, animated: true)
    }

}


extension HabitsViewController: HabitDelegate {

    func updateData() {
        collectionView.reloadData()
    }

    func presentController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        self.present(viewControllerToPresent, animated: flag, completion: completion)
    }

    func dismissController(animated: Bool, completion: (() -> Void)?) {
        self.dismiss(animated: animated, completion: completion)
    }
}

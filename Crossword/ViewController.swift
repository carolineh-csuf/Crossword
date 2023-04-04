//
//  ViewController.swift
//  Crossword
//
//  Created by csuftitan on 4/3/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let gridSize = 12
    private var itemDataSource: [[ItemDataModel]] = []
    private var flatDataSource: [ItemDataModel] {
        itemDataSource.flatMap { $0 }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = GridFlowLayout(numberOfColumns: gridSize)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .gray
        cv.register(CharItemCell.self, forCellWithReuseIdentifier: "CharItemCell")
        return cv
    }()
    
    private lazy var promptView: PromptView = {
        let v = PromptView()
        v.delegate = self
        return v
    }()
    
    let keyboardVC = KeyboardViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.url(forResource: "crossword", withExtension: "json")!
        let contents = try! Data(contentsOf: path)
        let words = try! JSONDecoder().decode([Word].self, from: contents)
     
        
        makeItemDataSource()
        setupViewHierarchy()
        addChildren()
        setupConstrains()
        
    }
    
    private func addChildren() {
        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        keyboardVC.delegate = self
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVC.view)
    }
    
    private func makeItemDataSource() {
        for _ in 0..<gridSize {
            var array: [ItemDataModel] = []
            for _ in 0..<gridSize {
                array.append(ItemDataModel(state: .unselected))
            }
            itemDataSource.append(array)
        }
    }
    
    private func setupViewHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(promptView)
//        keyboardVC.delegate = self
//        view.addSubview(keyboardVC.view)
    }
    
    private func setupConstrains() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.widthAnchor.constraint(equalTo: collectionView.heightAnchor)
        ])
        
        promptView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            promptView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            promptView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            promptView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            promptView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            keyboardVC.view.topAnchor.constraint(equalTo: promptView.bottomAnchor,constant: 20),
            keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        flatDataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharItemCell", for: indexPath) as! CharItemCell
        cell.configCell(with: flatDataSource[indexPath.item])
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("indexPath is \(indexPath.item)")
        updateItemDataSource(with: indexPath.item)
        collectionView.reloadData()
    }
    
    private func updateItemDataSource(with index: Int) {
        let coordinate = getCoordinate(from: index)
        print("coordinate is \(coordinate)")
        for i in 0..<gridSize {
            for j in 0..<gridSize {
                if promptView.direction == .horizontal {
                    if i == coordinate.x && j == coordinate.y {
                        itemDataSource[i][j].state = .selectedYellow
                    } else if i == coordinate.x && j != coordinate.y {
                        itemDataSource[i][j].state = .selectedBlue
                    } else {
                        itemDataSource[i][j].state = .unselected
                    }
                } else {
                    if i == coordinate.x && j == coordinate.y {
                        itemDataSource[i][j].state = .selectedYellow
                    } else if j == coordinate.y {
                        itemDataSource[i][j].state = .selectedBlue
                    } else {
                        itemDataSource[i][j].state = .unselected
                    }
                }
            }
        }
    }
    
    private func getCoordinate(from index: Int) ->(x: Int, y: Int) {
        var x: Int, y: Int
        x = index / gridSize
        y = index % gridSize
        return (x: x, y: y)
    }
}

extension ViewController: PromptViewDelegate {
    func leftButtonDidTap(view: PromptView) {
        guard let index = findSelectedIndex(),
              index > 0 else { return }
        updateItemDataSource(with: index - 1)
        collectionView.reloadData()
    }
    
    func rightButtonDidTap(view: PromptView) {
        guard let index = findSelectedIndex(),
              index < (gridSize * gridSize - 1) else { return }
        updateItemDataSource(with: index + 1)
        collectionView.reloadData()
    }
    
    func directionDidChange(view: PromptView) {
        guard let index = findSelectedIndex() else { return }
        updateItemDataSource(with: index)
        collectionView.reloadData()
    }
    
    private func findSelectedIndex() -> Int? {
        var selectedIndex: Int?
        for i in 0..<flatDataSource.count {
            if flatDataSource[i].state == .selectedYellow {
                selectedIndex = i
            }
        }
        return selectedIndex
    }
}

extension ViewController: KeyboardViewControllerDelegate {
    func keyboardViewController(_ vc: KeyboardViewController, didTapKey letter: Character) {

        // TODO:
        
    }
}

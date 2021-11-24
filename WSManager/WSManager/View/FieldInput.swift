//
//  FieldInput.swift
//  WSManager
//
//  Created by datNguyem on 22/11/2021.
//

import UIKit

class FieldInput: UIView, ReusableView {
    @IBOutlet weak var fieldInputCollectionView: UICollectionView!
    var prices = Price.dummyDate()
    var features = [String]()
    
    private enum Section: Int, CaseIterable {
        case info
        case price
        case feature
        case image
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil}
            
            let section: NSCollectionLayoutSection
            switch sectionKind {
            case .info:
                section = self.createInforSection()
            case .price:
                section = self.createPriceSection()
            case .feature:
                section = self.createFeatureSection()
            case .image:
                section = self.createImageSection()
            }
            
            return section
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    private func createInforSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(330))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitem: item, count: 1)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: LabelCollectionReusableView.identifier,
            alignment: .top)
        header.contentInsets.leading = 10
        header.contentInsets.trailing = 10
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func createPriceSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(330),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(350),
            heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                     subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 10, bottom: 0, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: LabelCollectionReusableView.identifier,
            alignment: .top)
        header.contentInsets.leading = 10
        header.contentInsets.trailing = 10
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func createFeatureSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.48),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(40))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: LabelCollectionReusableView.identifier,
            alignment: .top)
        header.contentInsets.leading = 10
        header.contentInsets.trailing = 10
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func createImageSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.4),
            heightDimension: .fractionalWidth(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 10, bottom: 0, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: LabelCollectionReusableView.identifier,
            alignment: .top)
        header.contentInsets.leading = 10
        header.contentInsets.trailing = 10
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let viewFromXib = loadViewFromNib()
        addSubview(viewFromXib)
        viewFromXib.frame = bounds
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        fieldInputCollectionView.dataSource = self
        fieldInputCollectionView.delegate = self
        fieldInputCollectionView.collectionViewLayout = createLayout()
        
        fieldInputCollectionView.register(
            InforFieldCollectionViewCell.nib,
            forCellWithReuseIdentifier: InforFieldCollectionViewCell.identifier)
        fieldInputCollectionView.register(
            PriceFieldCollectionViewCell.nib,
            forCellWithReuseIdentifier: PriceFieldCollectionViewCell.identifier)
        fieldInputCollectionView.register(
            FeatureCollectionViewCell.nib,
            forCellWithReuseIdentifier: FeatureCollectionViewCell.identifier)
        fieldInputCollectionView.register(
            ImageFieldCollectionViewCell.nib,
            forCellWithReuseIdentifier: ImageFieldCollectionViewCell.identifier)
        
        fieldInputCollectionView.register(
            LabelCollectionReusableView.nib,
            forSupplementaryViewOfKind: LabelCollectionReusableView.identifier,
            withReuseIdentifier: LabelCollectionReusableView.identifier)
    }
}

extension FieldInput: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return prices.count
        case 2:
            return 5
        case 3:
            return 3
        default:
            fatalError("section not availble")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath.section)
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: InforFieldCollectionViewCell.identifier,
                for: indexPath) as! InforFieldCollectionViewCell
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PriceFieldCollectionViewCell.identifier,
                for: indexPath) as! PriceFieldCollectionViewCell
            cell.configure(price: prices[indexPath.row])
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FeatureCollectionViewCell.identifier,
                for: indexPath)
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ImageFieldCollectionViewCell.identifier,
                for: indexPath) as! ImageFieldCollectionViewCell
            return cell
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(
            ofKind: LabelCollectionReusableView.identifier,
            withReuseIdentifier: LabelCollectionReusableView.identifier,
            for: indexPath) as! LabelCollectionReusableView
        switch indexPath.section {
        case 0:
            cell.configure(title: "Thông tin")
        case 1:
            cell.configure(title: "Giá")
            cell.trailingBtn.isHidden = false
            cell.trailingBtn.setTitle("+ Thêm", for: .normal)
            cell.addBottomBorderWithColor(color: UIColor.gray, width: 1)
        case 2:
            cell.configure(title: "Dịch vụ có tại chỗ")
            cell.trailingBtn.isHidden = false
            cell.trailingBtn.setTitle("+ Thêm", for: .normal)
            cell.addBottomBorderWithColor(color: UIColor.gray, width: 1)
        case 3:
            cell.configure(title: "Ảnh")
            cell.trailingBtn.isHidden = false
            cell.trailingBtn.setTitle("+ Thêm", for: .normal)
            cell.addBottomBorderWithColor(color: UIColor.gray, width: 1)
        default:
            fatalError("section khong ton tai")
        }
        
        return cell
    }
}

extension FieldInput: UICollectionViewDelegate { }

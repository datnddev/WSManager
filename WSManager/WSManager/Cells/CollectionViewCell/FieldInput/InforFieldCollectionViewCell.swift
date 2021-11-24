//
//  InforFieldCollectionViewCell.swift
//  WSManager
//
//  Created by datNguyem on 22/11/2021.
//

import UIKit
import DropDown

final class InforFieldCollectionViewCell: UICollectionViewCell, ReusableView {
    //MARK: Properties
    @IBOutlet weak var fieldTypeCustomText: CustomTextField!
    @IBOutlet weak var fieldNameCustomText: CustomTextField!
    @IBOutlet weak var fieldAddressCustomText: CustomTextField!
    @IBOutlet weak var cityCustomText: CustomTextField!
    @IBOutlet weak var districtCustomText: CustomTextField!
    @IBOutlet weak var startTimeCustomText: CustomTextField!
    @IBOutlet weak var closeTimeCustomText: CustomTextField!
    @IBOutlet weak var timePerRentalCustomTextField: CustomTextField!
    private let fieldTypeDropDown = DropDown()
    private let cityDropDown = DropDown()
    private let districtDropDown = DropDown()
    private let timePicker = UIDatePicker()
    
    //MARK: Data
    private var fieldTypes: [FieldType]? = {
        return FieldType.dummyData()
    }()
    private var citys: [City]? = {
        guard let path = Bundle.main.path(forResource: "city", ofType: "json") else { return nil}
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path),
                                options: .mappedIfSafe)
            return try JSONDecoder().decode([City].self, from: data)
        } catch {
            print(String(describing: error))
            return nil
        }
    }()
    private var districts: [District]? {
        guard let city = city, let path = Bundle.main.path(forResource: "\(city.code)",
                                          ofType: "json") else { return nil}
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path),
                                options: .mappedIfSafe)
            return try JSONDecoder().decode([District].self, from: data)
        } catch {
            print(String(describing: error))
        }
       return nil
    }
    private var city: City? {
        didSet {
            cityCustomText.textField.text = city?.name
            districtDropDownSetup()
        }
    }
    private var district: District? = nil {
        didSet {
            districtCustomText.textField.text = district?.name
        }
    }
    private var fieldType: FieldType? = nil {
        didSet {
            fieldTypeCustomText.textField.text = fieldType?.type
        }
    }
    private var startTime: String? = nil {
        didSet {
            startTimeCustomText.textField.text = startTime
        }
    }
    private var closedTime: String? = nil {
        didSet {
            closeTimeCustomText.textField.text = closedTime
        }
    }
    private var timePerRental: Int? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        setupAction()
        fieldTypeDropDownSetup()
        cityDropDownSetup()
        createDatePicker()
    }
    
    private func createToolBar(_ selector: Selector) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: selector)
        toolbar.setItems([doneButton], animated: true)
        
        return toolbar
    }
    
    private func createDatePicker() {
        startTimeCustomText.textField.delegate = self
        closeTimeCustomText.textField.delegate = self
        
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.datePickerMode = .time
        timePicker.locale = Locale(identifier: "vi_VN")
        
        startTimeCustomText.textField.inputView = timePicker
        startTimeCustomText.textField.inputAccessoryView =
            createToolBar(#selector(startTimeDoneDidTapped))
        
        closeTimeCustomText.textField.inputView = timePicker
        closeTimeCustomText.textField.inputAccessoryView =
            createToolBar(#selector(closedTimeDoneDidTapped))
    }
    
    @objc
    private func startTimeDoneDidTapped() {
        startTime = timePicker.date.formatDate(format: "HH:mm")
        let dateFromString = Date.dateFrom(from: startTime!, format: "HH:mm")
        endEditing(true)
    }
    
    @objc
    private func closedTimeDoneDidTapped() {
        closedTime = timePicker.date.formatDate(format: "HH:mm")
        endEditing(true)
    }
    
    private func cityDropDownSetup() {
        guard let citys = citys else { return }
        
        cityDropDown.anchorView = cityCustomText
        cityDropDown.dataSource = citys.compactMap { $0.name }
        cityDropDown.direction = .bottom
        cityDropDown.bottomOffset = CGPoint(x: 0,
                                            y: cityCustomText.bounds.height)
        cityDropDown.offsetFromWindowBottom = 400
        
        city = citys[0]
        cityCustomText.textField.text = city?.name
        cityDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            city = citys[index]
        }
    }
    
    private func districtDropDownSetup() {
        guard let districts = districts else { return }
        
        districtDropDown.anchorView = districtCustomText
        districtDropDown.dataSource = districts.compactMap { $0.name }
        districtDropDown.direction = .bottom
        districtDropDown.bottomOffset = CGPoint(x: 0,
                                            y: cityCustomText.bounds.height)
        districtDropDown.offsetFromWindowBottom = 400
        
        district = districts[0]
        districtDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            district = districts[index]
        }
    }
    
    private func fieldTypeDropDownSetup() {
        guard let fieldTypes = fieldTypes else { return }
        
        fieldType = fieldTypes[0]
        fieldTypeDropDown.anchorView = fieldTypeCustomText
        fieldTypeDropDown.dataSource = fieldTypes.compactMap { $0.type }
        fieldTypeDropDown.direction = .bottom
        fieldTypeDropDown.bottomOffset = CGPoint(x: 0, y: fieldTypeCustomText.bounds.height)
        fieldTypeDropDown.cellNib = FieldTypeTableViewCell.nib
        fieldTypeDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let _ = cell as? FieldTypeTableViewCell else { return }
//            cell.sportImageView.image =
        }
        
        fieldTypeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            fieldType = fieldTypes[index]
        }
    }
    
    private func setupAction() {
        fieldTypeCustomText.textField.isUserInteractionEnabled = false
        fieldTypeCustomText.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(fieldTypeDidTapped))
        )
        
        cityCustomText.textField.isUserInteractionEnabled = false
        cityCustomText.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(cityDidTapped))
        )
        
        districtCustomText.textField.isUserInteractionEnabled = false
        districtCustomText.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(districtDidTapped))
        )
    }
    
    @objc
    private func fieldTypeDidTapped() {
        fieldTypeDropDown.show()
    }
    
    @objc
    private func cityDidTapped() {
        cityDropDown.show()
    }
    
    @objc
    private func districtDidTapped() {
        districtDropDown.show()
    }
}

extension InforFieldCollectionViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

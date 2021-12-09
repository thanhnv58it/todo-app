//
//  AddItemViewController.swift
//  Todo App
//
//  Created by Thành Ngô Văn on 09/12/2021.
//

import UIKit
import RxSwift

class AddItemViewController: UIViewController {
    
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var lbTitleError: UILabel!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var addButton: UIButton!
    
    private let viewModel = AddItemViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindRxData()
    }
    
    private func setupView() {
        navigationItem.title = "screen_add".localized()
        
        let buttonBar = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .plain, target: self, action: #selector(rightBarButtonAction))
        buttonBar.tintColor = .white
        navigationItem.rightBarButtonItem = buttonBar
        
        view.backgroundColor = UIColor.secondarySystemBackground
        addButton.layer.cornerRadius = 8
        tvDescription.layer.cornerRadius = 6
        tvDescription.backgroundColor = .black
        tfTitle.delegate = self
        tfTitle.becomeFirstResponder()
        lbTitleError.isHidden = true
        
        let doneAction = createDoneToolBar(selector: #selector(doneButtonAction))
        tfTitle.inputAccessoryView = doneAction
        tvDescription.inputAccessoryView = doneAction
    }
    
    private func createDoneToolBar(selector: Selector) -> UIToolbar {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "button_done".localized(), style: .done, target: self, action: selector)
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        return doneToolbar
    }
    
    @objc func rightBarButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        guard let title = tfTitle.text?.trimmingCharacters(in: .whitespacesAndNewlines), !title.isEmpty else {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) {
                self.lbTitleError.isHidden = false
            }
            return
        }
        view.endEditing(true)
        viewModel.addNewItem(title: title, description: tvDescription.text)
    }
    
    @objc func doneButtonAction() {
        view.endEditing(true)
    }
    
}

extension AddItemViewController {
    fileprivate func bindRxData() {
        viewModel.errorObservable.bind { [weak self] (message) in
            guard let message = message else {
                return
            }
            self?.showErrorAlert(message: message)
        }.disposed(by: disposeBag)
        
        viewModel.savingStatusObservable.bind { [weak self] (status) in
            guard let self = self, status else {
                return
            }
            self.rightBarButtonAction()
        }.disposed(by: disposeBag)
    }
}

extension AddItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tvDescription.becomeFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard !lbTitleError.isHidden else {
            return
        }
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) {
            self.lbTitleError.isHidden = true
        }
    }
}

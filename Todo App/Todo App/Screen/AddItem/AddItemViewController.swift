//
//  AddItemViewController.swift
//  Todo App
//
//  Created by Thành Ngô Văn on 09/12/2021.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var lbTitleError: UILabel!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var addButton: UIButton!
    
    var viewModel: AddItemViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        navigationItem.title = "Add New Item"
        
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
    
    func createDoneToolBar(selector: Selector) -> UIToolbar
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: selector)
        
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
        rightBarButtonAction()
    }
    
    @objc func doneButtonAction() {
        view.endEditing(true)
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

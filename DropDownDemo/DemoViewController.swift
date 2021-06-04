//
//  DemoViewController.swift
//  DropDownDemo
//
//  Created by dhruv upadhyay on 6/3/21.
//

import UIKit

class DemoViewController: UIViewController {

    @IBOutlet weak var btnType: UIButton!
    @IBOutlet weak var btnProvider: UIButton!
    
    @IBOutlet weak var txtCertiType: PaddedTextField!
    @IBOutlet weak var txtProvider: PaddedTextField!
    let transparentView = UIView()
    let tableView = UITableView()
    var dataSource = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = ["A","B"]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = #colorLiteral(red: 0.137254902, green: 0.2352941176, blue: 0.5254901961, alpha: 1)

        // Do any additional setup after loading the view.
    }

    @IBAction func btnTappedProvider(_ sender: Any) {
        addTransparentView(frames: txtProvider.frame)
        txtProvider.layer.borderWidth = 1
        txtProvider.layer.cornerRadius = 4
        txtProvider.layer.borderColor = #colorLiteral(red: 0.137254902, green: 0.2352941176, blue: 0.5254901961, alpha: 1)
        txtProvider.backgroundColor = UIColor.white
    }
    @IBAction func btnTappedType(_ sender: Any) {
    }
    
    // Method for Adding transperantView while open tableView
    func addTransparentView(frames: CGRect) {
        btnProvider.setImage(UIImage(named: "group321"), for: .normal)
        let xFrame = frames.origin.x
        var yFrame = frames.origin.y
        yFrame += 137
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        tableView.frame = CGRect(x: frames.origin.x, y: yFrame + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layoutIfNeeded()
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 5
        transparentView.backgroundColor = UIColor.clear
        tableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            var tblViewHeight: CGFloat = CGFloat(self.dataSource.count * 50)
            if tblViewHeight > self.view.frame.height / 2 {
                tblViewHeight =  self.view.frame.height / 2
            }
            let frameValue = CGRect(x: xFrame, y: yFrame + frames.height, width: frames.width, height: tblViewHeight)
            self.tableView.frame = frameValue
        }, completion: nil)
    }
    
    // MARK: Method for removing transperant tableview
    @objc func removeTransparentView() {
        let frames = txtProvider.frame
        btnProvider.setImage(UIImage(named: "Group 32"), for: .normal)
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            var yFrame = frames.origin.y
            yFrame += 137
            self.tableView.frame = CGRect(x: frames.origin.x, y: yFrame + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    
}

extension DemoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        txtProvider.text = dataSource[indexPath.row]
        txtProvider.layer.borderWidth = 0
        txtProvider.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9568627451, blue: 0.9882352941, alpha: 1)
        removeTransparentView()
    }
}
class CellClass: UITableViewCell {
    
}

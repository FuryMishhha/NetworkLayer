//
//  ViewController.swift
//  Prrroj
//
//  Created by student on 27.03.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private var tableView = UITableView()
    
    private var models: [String]?{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        grabData { [weak self] model in
            self?.models = model?.map({ $0.firstName + " " +  $0.lastName })
        }
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.reuseId)
        tableView.dataSource = self
        tableView.delegate = self
    }


}


extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.reuseId , for: indexPath) as? PersonTableViewCell else {
            return UITableViewCell()
        }
        cell.name = models?[indexPath.row] ?? ""
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

//Mark: - Network layer
extension ViewController{
    func grabData(onGrabbed: @escaping ((Model?) -> ())){
        //OPTION I
//        if let path = Bundle.main.path(forResource: "MOCK_DATA", ofType: "json") {
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                guard let model = try? JSONDecoder().decode(Model.self, from: data)
//                else {
//                    return
//                }
//                onGrabbed(model)
//              } catch {
//                return
//              }
//        }
//        return
        
        //OPTION II
        let stringURL = "https://api.mocki.io/v1/3903c349"
        guard let url = URL(string: stringURL)else{
            return
        }
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            guard error == nil else { return }
            
            guard let data = data else { return }
            
            guard let model = try? JSONDecoder().decode(Model.self, from: data)
            else {
                return
            }
            onGrabbed(model)
        }
        task.resume()
    }
}



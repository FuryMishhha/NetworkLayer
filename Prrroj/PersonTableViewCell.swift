//
//  PersonTableViewCell.swift
//  Prrroj
//
//  Created by student on 27.03.2021.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    static var reuseId = "personCell"
    var name = "Jonny"{
        didSet{
            label.text = name
        }
    }
    
    private var label: UILabel = {
        var label = UILabel()
        label.textColor = .blue
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        
        label.text = name
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    required init?(coder: NSCoder){
        fatalError("init(coder: ) has not bean implement")
    }

}

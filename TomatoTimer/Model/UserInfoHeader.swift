//
//  UserInfoHeader.swift
//  TomatoTimer
//
//  Created by Ziyao Wang on 2021-04-02.
//

// We finally decide not using it, but we still kept this file

import UIKit

class UserInfoHeader: UIView {
    //=====================================================================================================
    // MARK: - Properties
    //---------------------------------------------------------------------------------------
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "icon.JPG")
        return iv
    }()
    //---------------------------------------------------------------------------------------
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Toffy"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //---------------------------------------------------------------------------------------
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "tonFFY@gmail.com"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //=====================================================================================================
    // MARK: - Init
    override init(frame: CGRect) {
        //---------------------------------------------------------------------------------------
        //Initial the frame
        super.init(frame: frame)
        let profileImageDimension: CGFloat = 60
        //---------------------------------------------------------------------------------------
        // Add the Profile image to the view
        addSubview(profileImageView)
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profileImageView.layer.cornerRadius = profileImageDimension / 2
        //---------------------------------------------------------------------------------------'
        //Add the Name Label to the view
        addSubview(usernameLabel)
        usernameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -10).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        //---------------------------------------------------------------------------------------
        //Add the email address Label to the view
        addSubview(emailLabel)
        emailLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 10).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

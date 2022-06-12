//
//  ChatTableViewCell.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Setup cell to match mockup
     *
     * 2) Include user's avatar image
     **/
    
    // MARK: - Outlets
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = HexColor("F9F9F9")
        
        header.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        header.textColor = HexColor("1B1E1F")
        
        body.layer.masksToBounds = true
        body.layer.cornerRadius = 8
        body.layer.borderColor = HexColor("EFEFEF")?.cgColor
        body.layer.borderWidth = 1
        body.backgroundColor = .white
        body.font = UIFont.systemFont(ofSize: 15)
        body.textColor = HexColor("1B1E1F")
        body.numberOfLines = 0
        
        profilePic.contentMode = .scaleAspectFill
        profilePic.asCircle()
    }
    
    // MARK: - Public
    func setCellData(message: Message) {
        header.text = message.username
        body.text = message.text
        body.sizeToFit()
                
        let client = ChatClient()
        client.fetchProfilePic(avatarURL: message.avatarURL) { profilePic in
            DispatchQueue.main.async {
                self.profilePic.image = profilePic
            }
        } error: { error in print(error!) }
    }
}


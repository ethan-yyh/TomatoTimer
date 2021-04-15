//
//  SettingsCell.swift
//  TomatoTimer
//
//  Created by Ziyao Wang on 2021-04-02.
//

import UIKit

class SettingsCell: UITableViewCell {
    //=====================================================================================================
    // MARK: - Properties
    //---------------------------------------------------------------------------------------
    var sectionType: SectionType?{
        didSet{
            guard let sectionType = sectionType else{return}
            textLabel?.text = sectionType.description
            switchControl_sound.isHidden = !sectionType.containSwitch_sound
        }
    }
    //---------------------------------------------------------------------------------------
    //Use Lazy Property to create sound control feature
    lazy var switchControl_sound: UISwitch = {
        let switchControl_sound = UISwitch()
        let sound_switch = UserDefaults.standard.integer(forKey: "Sound_isOn")
        if (sound_switch == 0){
            switchControl_sound.setOn(false, animated: true)
        }else{switchControl_sound.setOn(true, animated: true)}
        switchControl_sound.onTintColor = .systemGreen
        switchControl_sound.translatesAutoresizingMaskIntoConstraints = false
        switchControl_sound.addTarget(self, action: #selector(handleSoundSwitchAction), for: .valueChanged)
        return switchControl_sound
    }()
    //---------------------------------------------------------------------------------------
    //Helper Function used to handle Sound Switch
    @objc func handleSoundSwitchAction(sender: UISwitch!){
        if sender.isOn{
            UserDefaults.standard.set(true,forKey: "Sound_isOn")
            let curr=UserDefaults.standard.integer(forKey: "Sound_isOn")
            print(curr)
        }else{
            UserDefaults.standard.set(false,forKey: "Sound_isOn")
            let curr=UserDefaults.standard.integer(forKey: "Sound_isOn")
            print(curr)
        }
    }
    //---------------------------------------------------------------------------------------
    
    //=====================================================================================================
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Add and enable the sound control switch
        addSubview(switchControl_sound)
        switchControl_sound.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchControl_sound.rightAnchor.constraint(equalTo: rightAnchor,constant: -12).isActive = true
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  SettingsCell.swift
//  SettingsTemplate
//  Used to create the table cell item
//

import UIKit

class SettingsCell: UITableViewCell {
    
    // MARK: - Properties
    
    var sectionType: SectionType?{
        didSet{
            guard let sectionType = sectionType else{return}
            textLabel?.text = sectionType.description
            switchControl_sound.isHidden = !sectionType.containSwitch_sound
        }
    }
    lazy var switchControl_reset: UISwitch = {
        let switchControl_reset = UISwitch()
        let sound_switch = UserDefaults.standard.integer(forKey: "Reset_isOn")
        if (sound_switch == 1){
            switchControl_reset.setOn(true, animated: true)}else{
                switchControl_reset.setOn(false, animated: true)
            }
        switchControl_reset.onTintColor = .systemGreen
        switchControl_reset.translatesAutoresizingMaskIntoConstraints = false
        switchControl_reset.addTarget(self, action: #selector(handleResetSwitchAction), for: .valueChanged)
        return switchControl_reset
    }()
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
    @objc func handleResetSwitchAction(sender: UISwitch!){
        if sender.isOn{
            UserDefaults.standard.set(true,forKey: "Reset_isOn")
            let curr=UserDefaults.standard.integer(forKey: "Reset_isOn")
            print(curr)
        }else{
            UserDefaults.standard.set(false,forKey: "Reset_isOn")
            let curr=UserDefaults.standard.integer(forKey: "Reset_isOn")
            print(curr)
        }
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(switchControl_sound)
        switchControl_sound.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchControl_sound.rightAnchor.constraint(equalTo: rightAnchor,constant: -12).isActive = true
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

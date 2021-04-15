//
//  SettingSection.swift
//  TomatoTimer
//
//  Created by Ziyao Wang on 2021-04-02.
//

protocol SectionType: CustomStringConvertible{
    var containSwitch_sound: Bool {get}

}
enum SettingSection: Int, CaseIterable,CustomStringConvertible{
    case general
    case period
    //case contact
    
    var containSwitch_sound: Bool {return false}

    var description: String {
        switch self{
        
        case .general:
            return "General Setting"
        case .period:
            return "Time Period Setting"
//        case .contact:
//            return "Contact Us"
        }
    }
    
}

enum generalOption: Int, CaseIterable,SectionType{
    
    case sound
    
    var containSwitch_sound: Bool {
        switch self{
        case .sound:
            return true
        }
    }
    
    var description: String {
        switch self{
        case .sound:
            return "Sound"
        }
    }
    
}

enum timeOption: Int, CaseIterable,SectionType{
    case TPeriod
    case SBreak
    case LBreak
    var containSwitch_reset: Bool {return false}
    var containSwitch_sound: Bool {return false}

    var description: String {
        switch self{
        
        case .TPeriod:
            return "Minutes per Tomato Session"
        case .SBreak:
            return "Minutes per Short Break"
        case .LBreak:
            return "Minutes per Long Break"
        }
    }
    
}

enum confirmOption: Int, CaseIterable,SectionType{
    case confirm

    var containSwitch_reset: Bool {return false}
    var containSwitch_sound: Bool {return false}
    var description: String {
        switch self{
            
        case .confirm:
            return "Confirm Changes"
        }
    }
    
}

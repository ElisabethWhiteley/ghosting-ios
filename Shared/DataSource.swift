//
//  FileHelper.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 06/09/2020.
//

import Foundation

class FileHelper {
    
    private static var sharedInstance: FileHelper?
    
    public static var shared: FileHelper {
        if sharedInstance == nil {
            sharedInstance = FileHelper()
        }
        return sharedInstance!
    }
    
    private var hiddenSystemMessages: [Int] = [] {
        didSet {
            NotificationCenter.default.post(name: "wad",
                                            object: nil,
                                            userInfo: nil)
        }
    }
    
    private init() {
        // create new file
    }
    

    
    func hideSystemMessage(_ messageId: Int) {
        if hiddenSystemMessages.filter({ $0 == messageId }).isEmpty {
            hiddenSystemMessages.append(messageId)
        }
    }
    
    func systemMessageShouldBeShown(_ messageId: Int) -> Bool {
        if hiddenSystemMessages.filter({ $0 == messageId }).isEmpty {
            return true
        }
        return false
    }
    
    public static func resetSingleton() {
        FileHelper.sharedInstance = nil
    }
}

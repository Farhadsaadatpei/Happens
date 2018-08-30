//
//  DataManager.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/25/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    //Store All Posts
    static var PostData: NSMutableArray!
    
    /*===================================
    * FIND OBJECT
    ====================================*/
    
    static func FindObject(id: Int, inArray: NSMutableArray) -> NSMutableDictionary{
        
        //Find Object in Array
        let FindObject = inArray.indexOfObjectPassingTest { (resultFind, ind, bool) -> Bool in
            return resultFind["id"] as? Int == id
        }
        
        //If no Object found with ID Return Error
        if FindObject == NSNotFound {
            
            //Notify user Object Wasnt Find
            let ObjectAlert: UIAlertView = UIAlertView(title: "Fail", message: "Fail to find the Object, please reload your data.", delegate: self, cancelButtonTitle: "OK")
            
            //Show Object Not Found
            ObjectAlert.show()
        }
        
        //Get Data for Single Object
        let Object = inArray[FindObject] as! NSMutableDictionary
        
        //Return The Object
        return Object
    }
    
    
    //aamir@sellyx.com
    
    
    /*===================================
    * DELETE OBJECT
    ====================================*/
    
    static func DeleteObject(id: Int, inArray: NSMutableArray) -> Bool{
        
        //Find Item to Delete in Array
        let FindObject = inArray.indexOfObjectPassingTest{ (resultFind, ind, bool) in
            return resultFind["id"] as? Int == id
        }
        
        //If Item Not Find Show error
        if FindObject == NSNotFound {
            //Notify user Object Wasnt Find
            let ObjectAlert: UIAlertView = UIAlertView(title: "Fail", message: "Fail to find the Object, please reload your data.", delegate: self, cancelButtonTitle: "OK")
            
            //Show Object Not Found
            ObjectAlert.show()
            
            //Return False cause Object wasn't found.
            return false
            
        } else {
            
            //Remove Object
            inArray.removeObjectAtIndex(FindObject)
            
            //Removed Return True
            return true
        }
    }

}

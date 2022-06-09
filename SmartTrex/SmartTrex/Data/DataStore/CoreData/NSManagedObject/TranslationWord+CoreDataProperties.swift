//
//  TranslationWord+CoreDataProperties.swift
//  
//
//  Created by Yegor Gorskikh on 08.06.2022.
//
//

import Foundation
import CoreData


extension TranslationWord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TranslationWord> {
        return NSFetchRequest<TranslationWord>(entityName: "TranslationWord")
    }

    @NSManaged public var original: String?
    @NSManaged public var translation: String?
    @NSManaged public var uuid: UUID?

}

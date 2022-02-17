//
//  TranslationWord+CoreDataProperties.swift
//  Smart Trex
//
//  Created by Yegor Gorskikh on 30.01.2022.
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

}

extension TranslationWord : Identifiable {

}

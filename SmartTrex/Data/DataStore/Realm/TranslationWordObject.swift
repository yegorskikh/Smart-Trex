//
//  TranslationWordObject.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 07.02.2023.
//

import RealmSwift

final class TranslationWordObject: Object {
    @Persisted var uuid: UUID?
    @Persisted var original: String?
    @Persisted var translation: String?
}

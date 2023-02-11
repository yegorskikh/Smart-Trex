//
//  RealmStorage.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 07.02.2023.
//

import RealmSwift

final class StorageService {
    private let storage: Realm?
    
    init(
        _ configuration: Realm.Configuration = Realm.Configuration(inMemoryIdentifier: "inMemory")
    ) {
        self.storage = try? Realm(configuration: configuration)
    }
    
    func saveOrUpdateObject(object: Object) throws {
        guard let storage else { return }
        storage.writeAsync {
            storage.add(object, update: .all)
        }
    }
    
    func fetch<T: Object>(by type: T.Type) -> [T] {
        guard let storage else { return [] }
        return storage.objects(T.self).toArray()
    }
    
    func delete(object: Object) throws {
        guard let storage else { return }
        try storage.write {
            storage.delete(object)
        }
    }
}

extension Results {
    func toArray() -> [Element] {
        .init(self)
    }
}

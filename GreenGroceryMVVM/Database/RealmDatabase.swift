import Foundation
import RealmSwift

class RealmDatabase {
    static let shared: RealmDatabase = RealmDatabase()
    var notificationToken: NotificationToken?
    private init() { }
    deinit {
        notificationToken?.invalidate()
    }
}

extension RealmDatabase: CartDB {
    
    func delete(usingSkuId skuId: String) -> Bool {
        let realm = try! Realm()
        do {
            try realm.write {
                if let realmObject = realm.objects(RealmCartItem.self)
                    .first(where: { $0.skuId == skuId }) {
                    realm.delete(realmObject)
                }
            }
            
        } catch  {
            print("Smth went wrong with \(error)")
            return false
        }
        return true
    }
    
    func updateCart(using cartItem: CartItem) -> Bool {
        let realm = try! Realm()
        do {
            try realm.write {
                realm.add(RealmCartItem(cartItem: cartItem), update: .all)
            }
            
        } catch  {
            print("Smth went wrong with \(error)")
            return false
        }
        return true
    }
    
    func getCount(closure: @escaping CartCountClosure) {
        let realm = try! Realm()
        let results = realm.objects(RealmCartItem.self)
        notificationToken = results.observe({ _ in
            closure(results.count)
        })
    }
    
//    func getCount() async -> Int {
//        let realm = try! await Realm()
//        let results = realm.objects(RealmCartItem.self)
//        notificationToken = await results.
//    }
}

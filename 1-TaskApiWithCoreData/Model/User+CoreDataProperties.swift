//
//  User+CoreDataProperties.swift
//  
//
//  Created by Mobile Team on 15/03/2022.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var login: String?
    @NSManaged public var id: Int64
    @NSManaged public var node_id: String?
    @NSManaged public var avatar_url: URL?
    @NSManaged public var html_url: URL?
    @NSManaged public var followers_url: URL?
    @NSManaged public var following_url: URL?
    @NSManaged public var gists_url: URL?
    @NSManaged public var starred_url: URL?
    @NSManaged public var subscriptions_url: URL?
    @NSManaged public var organizations_url: URL?
    @NSManaged public var repos_url: URL?
    @NSManaged public var events_url: URL?
    @NSManaged public var received_events_url: URL?
    @NSManaged public var type: String?
    @NSManaged public var site_admin: Bool
    @NSManaged public var gravatar_id: String?
    @NSManaged public var url: URL?

}

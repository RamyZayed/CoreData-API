//
//  Screen1ViewModel.swift
//  1-TaskApiWithCoreData
//
//  Created by Mobile Team on 15/03/2022.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData
class viewModel{
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    lazy var d2array : [[User]] = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    []
    ]
    let titles : [String] = [
        "A",
        "B",
        "C",
        "D",
        "E",
        "F",
        "G",
        "H",
        "I",
        "J",
        "K",
        "L",
        "M",
        "N",
        "O",
        "P",
        "Q",
        "R",
        "S",
        "T",
        "U",
        "V",
        "W",
        "X",
        "Y",
        "Z"
    ]
    func fetchData()  {
//        var array : [User] = []
        let request = AF.request("https://api.github.com/users?since=0").response{ response in
            switch response.result{
            case.success(let value):
                let data = JSON(response.value)

                for k in data {
                    let p = self.map(json: k.1)
                    try! self.context.save()
                    
//                   array.append(p)
                }
                
            case.failure(let error):
                print(error)
            }
        }
        
//        return array
    }
    
    
    func deleteEverything(){
        let fetchreq :NSFetchRequest<NSFetchRequestResult> = User.fetchRequest()
        let deletereq = NSBatchDeleteRequest(fetchRequest: fetchreq)
        
        let pers = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        
        try! pers.viewContext.execute(deletereq)
    }
    
    func getItems(_ completionHandler : @escaping () -> ()  ) {
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            let request = User.fetchRequest()
            let sort = NSSortDescriptor(key: "login", ascending: true , selector: #selector(NSString.caseInsensitiveCompare))
            request.sortDescriptors = [sort]
            let items = try! self?.context.fetch(request)
            for item in items! {
                let s : Character = Character(Array(item.login!)[0].uppercased())
                var asc : Int = Int(s.asciiValue!)
                asc = asc - 65
                self?.d2array[asc].append(item)
            }
        }
        
        
        DispatchQueue.main.async {
            completionHandler()
        }
        
    }
    
    private func map(json : JSON) -> User {
        let p = User(context: self.context)
        p.id                = json["id"].int64Value
        p.login             = json["login"].stringValue
        p.node_id           = json["node_id"].stringValue
        p.avatar_url        = json["avatar_url"].url
        p.gravatar_id       = json["gravatar_id"].stringValue
        p.url               = json["url"].url
        p.html_url          = json["html_url"].url
        p.followers_url     = json["followers_url"].url
        p.following_url     = json["following_url"].url
        p.gists_url         = json["gists_url"].url
        p.starred_url       = json["starred_url"].url
        p.subscriptions_url = json["subscriptions_url"].url
        p.organizations_url = json["organizations_url"].url
        p.repos_url         = json["repos_url"].url
        p.events_url        = json["events_url"].url
        p.received_events_url = json["received_events_url"].url
        p.type              = json["type"].stringValue
        p.site_admin        = json["site_admin"].boolValue
        return p
    }
}

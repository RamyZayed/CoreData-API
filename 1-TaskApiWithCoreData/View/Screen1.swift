//
//  ViewController.swift
//  1-TaskApiWithCoreData
//
//  Created by Mobile Team on 15/03/2022.
//

import UIKit

class Screen1: UIViewController {

    
    
    let vm  = viewModel()
    
    let mytable = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        setupTable()
    }
    
    func fetchData(){
        
        
        vm.getItems {
            self.mytable.reloadData()
        }
        

    }
    
    func setupTable(){
        mytable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mytable)
        mytable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mytable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mytable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mytable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mytable.sectionHeaderTopPadding = 0
        mytable.delegate = self
        mytable.dataSource = self
        mytable.register(myCell.self, forCellReuseIdentifier: "cell")
    }

}



extension Screen1 : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if vm.d2array[section].count == 0{
            return 0
        }
        return vm.d2array[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mytable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! myCell
//        let current = items[indexPath.row] as User
        let current = vm.d2array[indexPath.section][indexPath.row]
//        print(current)
        DispatchQueue.global(qos: .background).async {
            cell.setup(u: current)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mytable.deselectRow(at: indexPath, animated: true)
        let ss2vm = s2vm(user: vm.d2array[indexPath.section][indexPath.row])
        let s2 = Screen2(vm: ss2vm)
        s2.modalPresentationStyle = .formSheet
        present(s2, animated: true, completion: nil)
    }
    
    
}


extension Screen1 : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (vm.d2array[indexPath.section].count == 0){
            return 0
        }
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(vm.d2array[section].count == 0){
            return nil
        }
            
        let label = UILabel()
        let u = UnicodeScalar(section + 65)
        let char = Character(u!)
        label.text = String(char)
        label.textColor  = .gray
        return label
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return vm.d2array.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if vm.d2array[section].count == 0 {
            return 0
        }
        return 20
    }
    
}


// for indexes
extension Screen1 {
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return vm.titles
    }
    
    
    // custom mapping between title and indexes
//    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
//        if (title == "Z"){
//            return 1;
//        }
//        return 25;
//    }
}

//
//  Screen2.swift
//  1-TaskApiWithCoreData
//
//  Created by Mobile Team on 16/03/2022.
//

import UIKit

class Screen2: UIViewController {
    var img = UIImageView()
    var vm : s2vm?
    
    let topside = UIView()
    let middleView = UIView()
    var idLabel = UILabel()
    var loginLabel = UILabel()
    convenience init(vm :s2vm) {
        self.init(nibName:nil, bundle:nil)
        self.vm = vm
    }
    
    deinit {
        print("DINITIZJSDA")
    }
    
    // This extends the superclass.
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    // This is also necessary when extending the superclass.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented") // or see Roman Sausarnes's answer
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupImage()
        setupLabels()
    }
    
    override func viewDidLayoutSubviews() {
        let x : CGFloat = middleView.frame.size.height
        idLabel.topAnchor.constraint(equalTo: middleView.topAnchor,constant: x/8).isActive = true
        loginLabel.topAnchor.constraint(equalTo: middleView.topAnchor,constant: (2*x)/8).isActive = true
    }
    
    func setupLabels(){
        view.addSubview(middleView)
        middleView.translatesAutoresizingMaskIntoConstraints = false
        middleView.topAnchor.constraint(equalTo: topside.bottomAnchor).isActive = true
        middleView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5).isActive = true
        middleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        middleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        
        middleView.addSubview(idLabel)
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.leadingAnchor.constraint(equalTo: middleView.leadingAnchor ,constant: 5).isActive = true
        
        idLabel.text = "ID : \(vm!.user.id)"
        idLabel.textColor = .white
        idLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        middleView.addSubview(loginLabel)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.leadingAnchor.constraint(equalTo: middleView.leadingAnchor ,constant: 5).isActive = true
        loginLabel.text = "Login : \(vm!.user.login!)"
        loginLabel.textColor = .white
        loginLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        
        
        middleView.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        middleView.layer.borderWidth = 3
        middleView.layer.cornerRadius = 10
        
    }
    
   
    func setupImage(){
        view.addSubview(topside)
        topside.translatesAutoresizingMaskIntoConstraints = false
        topside.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topside.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        topside.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topside.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        
        img.translatesAutoresizingMaskIntoConstraints = false
        topside.addSubview(img)
        
        let height : CGFloat = 150
        img.centerXAnchor.constraint(equalTo: topside.centerXAnchor).isActive = true
        img.centerYAnchor.constraint(equalTo: topside.centerYAnchor).isActive = true
        img.heightAnchor.constraint(equalToConstant: height).isActive = true
        img.widthAnchor.constraint(equalTo: img.heightAnchor).isActive = true
        if let vm = vm {
            if let url = vm.user.avatar_url{
                
                if let data = try? Data(contentsOf: url){
                    if let image = UIImage(data: data){
                        img.image = image
                    }
                }
            }
        }
        
        
        img.clipsToBounds = true
        img.layer.cornerRadius = height/2
    }
}

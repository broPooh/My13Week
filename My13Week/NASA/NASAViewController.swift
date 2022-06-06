//
//  NASAViewController.swift
//  My13Week
//
//  Created by bro on 2022/06/05.
//

import UIKit

class NASAViewController: BaseViewController {
    
    let imageView = UIImageView()
    let label = UILabel()
    
    var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            label.text = "\(result * 100)/100"
        }
    }
    
    
    var session: URLSession!
    
    var total: Double = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(buffer)
        buffer = Data()
        print(buffer)
        request()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //session.finishTasksAndInvalidate() //찾아서 비교해보기
        //session.invalidateAndCancel() //리소스를 정리 -> 그냥 모두 정리.. 실행중인 태스크가 있더라도 모두정리
    }
    
    override func configure() {
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        label.textAlignment = .center
        label.backgroundColor = .white
        label.textColor = .black
    }
    
    override func setupConstraints() {
        view.addSubview(imageView)
        view.addSubview(label)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(100)
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
    
    func request() {
        //let url = URL(string: "https://apod.nasa.gov/apod/image/2206/3c75_chandraNRAO_960.jpg")!
        let url = URL(string: "https://api.nasa.gov/EPIC/archive/natural/2019/05/30/png/epic_1b_20190530011359.png?api_key=DEMO_KEY")!
        print("request test")
        
        //let configuration = URLSessionConfiguration.default
        //configuration.allowsCellularAccess = false
        //URLSession(configuration: configuration).dataTask(with: url).resume()
        
        
        //URLSession의 shared를 사용하면 딜리게이트를 사용할 수없다. completionHandler만 처리하도록 되어있음..
        //URLSession.shared.dataTask(with: url).resume()
        // URLSession(configuration: .default, delegate: self, delegateQueue: .main).dataTask(with: url).resume()
        
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        session.dataTask(with: url).resume()
        
        
    }
    
}


extension NASAViewController: URLSessionDataDelegate {
    
    //서버에서 최초로 응답을 받은 경우 호출(상태코드에 대한 분기처리를 이곳에서 많이 작성, Header에 관련된 일을 여기서.!)
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        print(response)
        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
            
            total = Double(response.value(forHTTPHeaderField: "Content-Length")!)!
            //label.text = response.value(forHTTPHeaderField: "Content-Length")
            //print(response.value(forHTTPHeaderField: "Content-Length"))
            return .allow
        } else {
            return .cancel
        }
    }
    
    //서버에서 데이터를 받을 때마다 반복적으로 호출됨.!
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        //print(data)
        buffer?.append(data) //받아오는 데이터를 하나로 합쳐주기 위함
    }
    
    //네트워크 통신이 끝나고 응답이 완료가 되었을 때, 문제가 있으면 nil
    //에러가 있을때가 호출이 아니라 응답이 완료가 되었을때이기 때문에 이곳에서 바로 얼럿을 띄우면 항상 얼럿이 뜬다
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print("에러가 발생했습니다", error)
        } else {
            print("성공!") //completionHandler에서 해결하던 것을 이곳에서 작성한다고 생각하면 된다.
            
            //데이터를 다 받아왔다면 Data를 image로 변경한다
            guard let buffer = buffer else {
                print("buffer Error")
                return
            }
            
            let image = UIImage(data: buffer)
            imageView.image = image
            
        }
    }
    
}

//
//  ViewController.swift
//  Map
//
//  Created by 이충현 on 2021/01/27.
//

import UIKit
//맵뷰 아웃렛을 쓰기 위해 MKMapView가 정의 된 MapKit import
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var myMap: MKMapView!
    @IBOutlet var lblLocationInfo1: UILabel!
    @IBOutlet var lblLocationInfo2: UILabel!
    
    //지도를 보여주기 위해 변수 locationManager와 델리게이트 CLLocationManagerDelegate 선언
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //앱을 실행하면 지도가 나오도록 viewDidLoad 함수에 코드 추가
        
        // 위치 정보를 표시할 레이블에는 아직 표시할 필요가 없으므로 공백
        lblLocationInfo1.text = ""
        lblLocationInfo2.text = ""
        // 상수 locationManager의 델리게이트 self로 설정 -> self 로 설정하게되면 어떻게 되나??
        // -> self란 클래스나 구조체 자신을 가르킬때 사용
        locationManager.delegate = self
        //정확도를 최고로 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 위치 데이터를 추적하기 위해 사용자에게 승인요구
        locationManager.requestWhenInUseAuthorization()
        // 위치 업데이트
        locationManager.startUpdatingLocation()
        // 위치보기 값을 true로 설정
        myMap.showsUserLocation = true
    }
    
    //위도 경도로 원하는 위치 표시하기
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span :Double) -> CLLocationCoordinate2D{
        //지도를 나타내기 위해 4가지 함수를 호출해야함
        //1. CLLocationCoordinate2DMake, 2. MKCoordinateSpan, 3.MKCoordinateRegion, 4. 맵뷰의 setRegion
        
        // 위도값과 경도값을 매개변수로 하여 CLLocationCoordinate2DMake 함수를 호출하고 리턴값을 pLocation으로 받는다
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        // 범위 값을 매개변수로 하여 MKCoordinateSpanMake 함수를 호출하고, 리턴값을 spanValue로 받는다
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        // pLocation과 spanValue 값을 매개변수로 하여 MKCoordinateRegionMake 함수를 호출하고, 리턴값을 pRegion으로 받는다
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        // pResion값을 매개변수로 하여 myMap.setRegion함수를 호출한다.
        myMap.setRegion(pRegion, animated: true)
        
        //리턴타입을 CLLocationCoordinate2D로 하고 리턴 pLocation해준다
        return pLocation
    }
    
    // 원하는곳에 핀 설치하기 위해 입력 파라메터는 위도, 경도, 범위, 타이틀, 서브타이틀로 한다.
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue : CLLocationDegrees, delta span : Double, title strTitle: String, subtitle strSubtitle:String){
        //핀을 설치하기 위해 MKPointAnnotation함수를 호출하여 리턴값을 annotation으로 받는다
        let annotation = MKPointAnnotation()
        //annotation의 coordinate값을 goLocation 함수로부터 CLLocationCoordinate2D형태로 받아야하는데,
        //이를 위해서는 goLocation 함수를 수정해야한다.
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation)
    }
    
    //위치가 업데이트 되었을 때 지도에 위치를 나타내기 위한 함수
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        //위치가 업데이트되면 마지막 위치 값을 찾아낸다
        let pLocation = locations.last
        //마지막 위치의 위ㅡ도와 경도 값을 가지고 앞에서 만든 goLocation함수 호출.
        //이때 delta값은 지도의 크기를 정하는데, 값이 작을수록 확대되는 효과가 있음
        // delta를 0.01로 하였으니 1의 값보다 지도를 100배로 확대해서 보여줌.
        //반환값을 가지는 함수로 되었기때문에 아래와 같이 수정
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
        
        //위도와 경도 값을 가지고 역으로 위치의 정보, 주소찾기
        // reverse Geocode Location 함수에서 내부 파라미터인 핸들러를 익명함수로 처리
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in
            //placemarks값의 첫 부분만 pm 상수로 대입
            let pm = placemarks!.first
            //pm상수에서 나라 값을 country 상수에 대입
            let country = pm!.country
            //문자열address에 county 상수의 값을 대입
            var address:String = country!
            //pm상수에서 지역 값이 존재하면 address문자열에 추가
            if pm!.locality != nil {
                address += ""
                address += pm!.locality!
            }
            //pm 상수에도 도로 값이 존재하면 address문자열에 추가
            if pm!.thoroughfare != nil {
                address += ""
                address += pm!.thoroughfare!
            }
            //레이블에 현재위치 텍스트를 표시
            self.lblLocationInfo1.text = "현재위치"
            // 레이블에 address문자열의 값을 표시
            self.lblLocationInfo2.text = address
        })
        //마지막으로 위치가 업데이트되는 것을 멈추게 한다.
        locationManager.stopUpdatingLocation()
    }
    
    // 세그먼트 컨트롤 액션함수
    // UISegmentedControl 타입은 세그먼트 컨트롤에 액션을 추가하기 위해서
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            //현재 위치
            self.lblLocationInfo1.text = ""
            self.lblLocationInfo2.text = ""
            locationManager.startUpdatingLocation()
        } else if sender.selectedSegmentIndex == 1 {
            //세그먼트 폴리텍대학 표시
            setAnnotation(latitudeValue: 37.751853, longitudeValue: 128.87605740000004, delta: 1, title: "한국폴리텍대학 강릉캠퍼스", subtitle: "강원로 강릉시 남산초교121")
                          self.lblLocationInfo1.text = "보고 계신 위치"
                          self.lblLocationInfo2.text = "한국폴리텍대학 강릉 캠퍼스"
        } else if sender.selectedSegmentIndex == 2 {
            //이지스 퍼블리싱 표시
            setAnnotation(latitudeValue: 37.556876, longitudeValue: 126.914066, delta: 0.1, title: "이지스퍼블리싱", subtitle: "서울시 마포구 잔다리로 109 이지스빌딩")
                          self.lblLocationInfo1.text = "보고 계신 위치"
                          self.lblLocationInfo2.text = "이지스퍼블리싱 출판사"
        }
    }
    
}


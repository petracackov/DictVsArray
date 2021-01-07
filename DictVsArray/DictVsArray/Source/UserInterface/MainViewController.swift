//
//  MainViewController.swift
//  DictVsArray
//
//  Created by Petra Čačkov on 05/01/2021.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet private var scrollView: UIScrollView?
    @IBOutlet private var arrayButton: UIButton?
    @IBOutlet private var dictButton: UIButton?
    @IBOutlet private var setButton: UIButton?
    @IBOutlet private var arrayTableView: UITableView?
    @IBOutlet private var dictTableView: UITableView?
    @IBOutlet private var setTableView: UITableView?
    @IBOutlet private var runButton: UIButton?
    @IBOutlet private var slider: UISlider?
    @IBOutlet private var sliderValueLabel: UILabel?
    @IBOutlet private var activityIndicator: UIActivityIndicatorView?
    
    private var numberOfItems: Int = 100 {
        didSet { sliderValueLabel?.text = "\(numberOfItems)"}
    }
    
    private var arrayTimes: ArrayTimes = ArrayTimes()
    private var dictTimes: DictTimes = DictTimes()
    private var setTimes: SetTimes = SetTimes()
    
    private let timeFormatter: NumberFormatter = {
      var formatter = NumberFormatter()
      formatter.numberStyle = NumberFormatter.Style.decimal
      formatter.minimumFractionDigits = 6
      formatter.maximumFractionDigits = 6
      return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        slider?.value = 2
        sliderValueLabel?.text = "100"
    }

    @IBAction private func runTest(_ sender: Any) {
        self.arrayTableView?.isHidden = true
        self.setTableView?.isHidden = true
        self.dictTableView?.isHidden = true
        activityIndicator?.startAnimating()
        DispatchQueue.global(qos: .background).async {
            self.b_generateData()
            self.b_run()
            DispatchQueue.main.async {
                self.arrayTableView?.isHidden = false
                self.setTableView?.isHidden = false
                self.dictTableView?.isHidden = false
                self.arrayTableView?.reloadData()
                self.setTableView?.reloadData()
                self.dictTableView?.reloadData()
                self.activityIndicator?.stopAnimating()
            }
        }
    }
    
    @IBAction func arrayButtonPressed(_ sender: Any) {
        if let frame = arrayTableView?.frame {
            scrollView?.scrollRectToVisible(frame, animated: true)
        }
    }
    @IBAction func dictButtonPressed(_ sender: Any) {
        if let frame = dictTableView?.frame {
            scrollView?.scrollRectToVisible(frame, animated: true)
        }
    }
    @IBAction func setButtonPressed(_ sender: Any) {
        if let frame = setTableView?.frame {
            scrollView?.scrollRectToVisible(frame, animated: true)
        }
    }
    @IBAction private func sliderValueChanged(_ sender: UISlider) {
        let value = sender.value.rounded()
        sender.setValue(value, animated: false)
        numberOfItems =  Int(pow(10, value))
    }
    
    /// has to be called on background thread
    private func b_generateData() {
        arrayTimes.create(numberOfItems: numberOfItems)
        dictTimes.create(numberOfItems: numberOfItems)
        setTimes.create(numberOfItems: numberOfItems)
        
    }
    /// has to be called on background thread
    private func b_run() {
        arrayTimes.insertItemAtTheBeginning()
        arrayTimes.insertItemAtTheEnd()
        arrayTimes.insertItemAtTheMiddle()
        arrayTimes.removeItemAtTheBeginning()
        arrayTimes.removeItemAtTheEnd()
        arrayTimes.removeItemAtTheMiddle()
        arrayTimes.remove1Object()
        arrayTimes.remove5Objects()
        arrayTimes.remove10Objects()
        arrayTimes.add1Object()
        arrayTimes.add5Objects()
        arrayTimes.add10Objects()
        arrayTimes.lookup1Object()
        arrayTimes.lookup10Objects()
        
        setTimes.remove1Object()
        setTimes.remove5Objects()
        setTimes.remove10Objects()
        setTimes.add1Object()
        setTimes.add5Objects()
        setTimes.add10Objects()
        setTimes.lookup1Object()
        setTimes.lookup10Objects()

        dictTimes.remove1Object()
        dictTimes.remove5Objects()
        dictTimes.remove10Objects()
        dictTimes.add1Object()
        dictTimes.add5Objects()
        dictTimes.add10Objects()
        dictTimes.lookup1Object()
        dictTimes.lookup10Objects()

    }

    private func generateStringFor(timeInterval: TimeInterval?) -> String {
        guard let timeInterval = timeInterval else { return "NAN" }
        guard let timeString = timeFormatter.string(from: NSNumber(value: timeInterval)) else { return "NAN" }
        return timeString
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == arrayTableView {
            return arrayTimes.getAllData().count
        } else if tableView == setTableView  {
            return setTimes.getAllData().count
        } else if tableView == dictTableView {
            return dictTimes.getAllData().count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        if tableView == arrayTableView {
            let data = arrayTimes.getAllData()[indexPath.row]
            cell.title = data.title
            cell.value = generateStringFor(timeInterval: data.timeInterval)
        } else if tableView == dictTableView {
            let data = dictTimes.getAllData()[indexPath.row]
            cell.title = data.title
            cell.value = generateStringFor(timeInterval: data.timeInterval)
        } else if tableView == setTableView {
            let data = setTimes.getAllData()[indexPath.row]
            cell.title = data.title
            cell.value = generateStringFor(timeInterval: data.timeInterval)
        }
        
        return cell
    }
}


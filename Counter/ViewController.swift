//
//  ViewController.swift
//  Counter
//
//  Created by Vadzim on 17.12.24.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    // Аутлеты
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var counterButtonPlus: UIButton!
    @IBOutlet weak var counterButtonMinus: UIButton!
    @IBOutlet weak var counterButtonReset: UIButton!
    @IBOutlet weak var counterTextViewLog: UITextView!
    
    // Переменне
    private var counter:Int = 0
    private var log:String = ""
    
    
    // Устанавливаем значение счетчика 0, когда приложение загрузилось
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        counterLabel.text = "Значение счетчика: 0"
        log = "История изменений: \n"
        counterTextViewLog.text = log
    }

    // Обрабатываем нажатие на кнопку увеличивающую значение счетчика на 1.
    @IBAction func counterButtonPlus(_ sender: Any) {
        counter = counter + 1
        counterLabel.text = "Значение счетчика: \(counter)"
        counterLog(param: "значение изменено на -1/+1 \n")
    }
    
    // Обрабатываем нажатие на кнопку уменьшающую значение счетчика на 1, но не ниже 0.
    // TODO сделать общую функцию на кнопки counterButtonPlus и counterButtonMinus
    @IBAction func counterButtonMinus(_ sender: Any) {
        if counter > 0 {
            counter = counter - 1
            counterLabel.text = "Значение счетчика: \(counter)"
            counterLog(param: "значение изменено на -1/+1 \n")
        } else {
            counterLog(param: "попытка уменьшить значение счётчика ниже 0 \n")
        }
    }
    
    // Обрабатываем нажатие на кнопку сброса значения счетчика и лога
    @IBAction func counterButtonReset(_ sender: Any) {
        counter = 0
        counterLabel.text = "Значение счетчика: \(counter)"
        counterLog(param: "значение сброшено \n")
        
        //log = "История изменений: \n"
        //counterTextViewLog.text = log
    }
    
    private func counterLog(param: String) {
        
        // Определяем дату и время, форматируем и переводим в String
        let date = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
        let formattedDate:String = dateFormatter.string(from: date) + ": "
        
        // Собираем строку для лога
        log = log + formattedDate + param
        
        // Обновляем лог
        counterTextViewLog.text = log
      
    }
}


//
//  ViewController.swift
//  Counter
//
//  Created by Vadzim on 17.12.24.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var counterButtonPlus: UIButton!
    @IBOutlet weak var counterButtonMinus: UIButton!
    @IBOutlet weak var counterButtonReset: UIButton!
    @IBOutlet weak var counterTextViewLog: UITextView!
 
    // MARK: - Private Properties
    private var counter:Int = 0
    private var log:String = ""
    
    // MARK: - Overrides Methods
    override func viewDidLoad() {
       
        super.viewDidLoad()

        // Если данных в UserDefaults нет, записываем начальные значения.
        if UserDefaults.standard.string(forKey: "counterLabel") == nil {
            counterLabel.text = "Значение счетчика: 0"
            UserDefaults.standard.set(counterLabel.text, forKey: "counterLabel")
        } else {
            counterLabel.text = UserDefaults.standard.string(forKey: "counterLabel")
        }
        
        if UserDefaults.standard.string(forKey: "counterLog") == nil {
            log = "История изменений: \n"
            UserDefaults.standard.set(log, forKey: "counterLabel")
            counterTextViewLog.text = log
        } else {
            counterTextViewLog.text = UserDefaults.standard.string(forKey: "counterLog")
        }
        
        counterUpdate()
        updateResetButton()

    }
    
    // MARK: - IB Actions
    // Обрабатываем нажатие на кнопку увеличивающую значение счетчика на 1.
    @IBAction func counterButtonPlus(_ sender: Any) {
        counter = counter + 1
        counterLabel.text = "Значение счетчика: \(counter)"
        counterLog(param: "значение изменено на -1/+1 \n")
        counterUpdate()
        updateResetButton()
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
        counterUpdate()
        updateResetButton()
    }
    
    // Обрабатываем нажатие на кнопку сброса значения счетчика и лога
    @IBAction func counterButtonReset(_ sender: Any) {
        counter = 0
        counterLabel.text = "Значение счетчика: \(counter)"
        counterLog(param: "значение сброшено \n")   
    }
    
    // MARK: - Private Methods
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
      
        // сохраняем
        saveData()
    }
    
    private func saveData() {

        let counterLabel = self.counterLabel.text
        let counterLog = self.log
        
        UserDefaults.standard.set(counterLabel, forKey: "counterLabel")
        UserDefaults.standard.set(counterLog, forKey: "counterLog")
    }
    
    private func updateResetButton() {
        if counter == 0 {
            counterButtonReset.isEnabled = false
        } else {
            counterButtonReset.isEnabled = true
        }
    }
    
    private func counterUpdate() {
        if counter > 10 || counter < -10 {
            counter = 0
            counterLabel.text = "Значение счетчика: \(counter)"
            counterLog(param: "значение сброшено \n")
        }
    }
}

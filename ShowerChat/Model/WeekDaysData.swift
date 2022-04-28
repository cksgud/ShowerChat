//
//  WeekDaysData.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/10/20.
//

import Foundation

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
    
    func getDayDate() -> [String] {
        if dayOfWeek() == "Monday" {
            SharedRepo.sharedVariables.dayOfToday = "월"
            for i in 0...6 {
                SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) + i))
            }
        }
        else if dayOfWeek() == "Tuesday" {
            SharedRepo.sharedVariables.dayOfToday = "화"
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) - 1))
            for i in 0...5 {
                SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) + i))
            }
        }
        else if dayOfWeek() == "Wednesday" {
            SharedRepo.sharedVariables.dayOfToday = "수"
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) - 2))
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) - 1))
            for i in 0...4 {
                SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) + i))
            }
        }
        else if dayOfWeek() == "Thursday" {
            SharedRepo.sharedVariables.dayOfToday = "목"
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) - 3))
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) - 2))
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) - 1))
            for i in 0...3 {
                SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) + i))
            }
        }
        else if dayOfWeek() == "Friday" {
            SharedRepo.sharedVariables.dayOfToday = "금"
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) - 4))
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) - 3))
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) - 2))
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) - 1))
            for i in 0...2 {
                SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) + i))
            }
        }
        else if dayOfWeek() == "Saturday" {
            SharedRepo.sharedVariables.dayOfToday = "토"
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) - 5))
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) - 4))
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) - 3))
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) - 2))
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) - 1))
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date()))))
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) + 1))
        }
        else if dayOfWeek() == "Sunday" {
            SharedRepo.sharedVariables.dayOfToday = "일"
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) - 6))
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) - 5))
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) - 4))
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) - 3))
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) - 2))
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date())) - 1))
            SharedRepo.sharedVariables.dayDatesData.append(String(Int(Calendar.current.component(.day, from: Date()))))
        }
        
        SharedRepo.sharedVariables.dayOfTheWeek.append("월")
        SharedRepo.sharedVariables.dayOfTheWeek.append("화")
        SharedRepo.sharedVariables.dayOfTheWeek.append("수")
        SharedRepo.sharedVariables.dayOfTheWeek.append("목")
        SharedRepo.sharedVariables.dayOfTheWeek.append("금")
        SharedRepo.sharedVariables.dayOfTheWeek.append("토")
        SharedRepo.sharedVariables.dayOfTheWeek.append("일")
        
        
        return SharedRepo.sharedVariables.dayDatesData
    }
}

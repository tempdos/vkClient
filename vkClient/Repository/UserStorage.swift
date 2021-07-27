//
//  UserStorage.swift
//  vkClient
//
//  Created by Василий Слепцов on 22.07.2021.
//

import Foundation

class UserStorage {
    let users: [User]
    
    init() {
        users = [
            User(name: "Иванов Иван Иванович", avatar: "ivanov", photos: [
                Photo(image: "ivanov01", date: "03 май 2018", description: "Первые шашлыки"),
                Photo(image: "ivanov02", date: "09 июнь 2019", description: "Купалка"),
                Photo(image: "ivanov03", date: "01 сентября 2020", description: "Школа здравствуй")
            ]),
            User(name: "Петров Петр Петрович", avatar: "petrov", photos: [
                Photo(image: "petrov01", date: "12 сентября 2020", description: "С друзьями"),
                Photo(image: "petrov02", date: "31 декабря 2020", description: "Новый год 2021"),
            ]),
            User(name: "Сидоров Сидор Сидорович", avatar: "sidorov", photos: [
                Photo(image: "sidorov01", date: "01 января 2021", description: "Утро нового года")
            ]),
            User(name: "Алексеев Алексей Алексеевич", avatar: "alekseev", photos: [
                Photo(image: "alekseev01", date: "08 сентября 2020", description: "День города"),
                Photo(image: "alekseev02", date: "08 сентября 2020", description: "День города"),
                Photo(image: "alekseev03", date: "08 сентября 2020", description: "День города"),
                Photo(image: "alekseev04", date: "08 сентября 2020", description: "День города"),
                Photo(image: "alekseev05", date: "08 сентября 2020", description: "День города"),
                Photo(image: "alekseev06", date: "08 сентября 2020", description: "День города"),
                Photo(image: "alekseev07", date: "08 сентября 2020", description: "День города"),
                Photo(image: "alekseev08", date: "08 сентября 2020", description: "День города")
            ]),
            User(name: "Васильев Василий Васильевич", avatar: "vasiliev", photos: [
                Photo(image: "vasiliev01", date: "06 августа 2020", description: "День рождение"),
                Photo(image: "vasiliev01", date: "09 мая 2020", description: "День победы"),
                Photo(image: "vasiliev01", date: "21 августа 2020", description: "Отдых в Турции"),
            ]),
            User(name: "Александров Александр Александрович", avatar: "aleksandrov", photos: [
                    Photo(image: "aleksandrov01", date: "01 мая 2020", description: "Мир труд май")
            ]), 
            User(name: "Евгеньев Евгений Евгеньевич", avatar: "evgeniev", photos: [
                    Photo(image: "evgeniev01", date: "30 сентября 2020", description: "Птицы")
            ]),
            User(name: "Марков Марк Маркович", avatar: "markov", photos: [
                    Photo(image: "markov01", date: "10 октября 2020", description: "Я")
            ]),
            User(name: "Леонидов Леонид Леонидович", avatar: "leonidov", photos: [
                    Photo(image: "leonidov01", date: "24 июня 2020", description: "В магазине")
            ]),
            User(name: "Михайлов Михаил Михайлович", avatar: "mihailov", photos: [
                    Photo(image: "mihailov01", date: "01 марта 2020", description: "Первый день весны")
            ]),
        
        ]
    }
}

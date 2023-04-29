//
//  ListModel.swift
//  DrugsApp
//
//  Created by MacBook Air on 28.04.2023.
//

import Foundation

// MARK: - ListElement
struct ListElement: Codable {
    let id: Int
    let image: String
    let categories: Categories
    let name, description: String
    let documentation: String?
    let fields: [Field]
}

// MARK: - Categories
struct Categories: Codable {
    let id: Int
    let icon, image, name: String
}

// MARK: - Field
struct Field: Codable {
    let typesID: Int
    let type: TypeEnum
    let name: Name
    let value: String
    let image: Image?
    let flags: Flags
    let show, group: Int

    enum CodingKeys: String, CodingKey {
        case typesID = "types_id"
        case type, name, value, image, flags, show, group
    }
}

// MARK: - Flags
struct Flags: Codable {
    let html, noValue, noName, noImage: Int
    let noWrap, noWrapName, system: Int

    enum CodingKeys: String, CodingKey {
        case html
        case noValue = "no_value"
        case noName = "no_name"
        case noImage = "no_image"
        case noWrap = "no_wrap"
        case noWrapName = "no_wrap_name"
        case system
    }
}

enum Image: String, Codable {
    case uploadContentTypes202206MaskGroup1_9F3Ed884PNG = "/upload/content/types/2022-06/Mask group (1)_9f3ed884.png"
    case uploadContentTypes202206MaskGroup2_42C7A4FdPNG = "/upload/content/types/2022-06/Mask group (2)_42c7a4fd.png"
    case uploadContentTypes202206MaskGroup3_0087Cdd2PNG = "/upload/content/types/2022-06/Mask group (3)_0087cdd2.png"
    case uploadContentTypes202206MaskGroup4879D2FcPNG = "/upload/content/types/2022-06/Mask group_4879d2fc.png"
}

enum Name: String, Codable {
    case гарантийныйСрокХранения = "Гарантийный срок хранения"
    case действующееВещество = "Действующее вещество"
    case классОпасности = "Класс опасности"
    case культуры = "Культуры"
    case механизмДействия = "Механизм действия"
    case нормыИСрокиПрименения = "Нормы и сроки применения"
    case ограничениеПоСевообороту = "Ограничение по севообороту"
    case периодЗащитногоДеиСтвия = "Период защитного действия"
    case периодЗащитногоДействия = "Период защитного действия"
    case подавляемыеОбъекты = "Подавляемые объекты"
    case преимуществаПрепарата = "Преимущества препарата"
    case препаративнаяФорма = "Препаративная форма"
    case регламентПрименения = "Регламент применения"
    case скоростьВоздействия = "Скорость воздействия"
    case совместимостьСДругимиПрепаратами = "Совместимость с другими препаратами"
    case срокОжидания = "Срок ожидания"
    case технологияПрименения = "Технология применения"
    case упаковка = "Упаковка"
    case факторыВлияющиеНаЭффективность = "Факторы, влияющие на эффективность"
    case фитотоксичность = "Фитотоксичность"
}

enum TypeEnum: String, Codable {
    case image = "image"
    case list = "list"
    case text = "text"
}

typealias List = [ListElement]


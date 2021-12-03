//
//  CartModel.swift
//  iOS-JSON-Parser
//
//  Created by Mindstix on 03/12/21.
//

import Foundation

// MARK: - Welcome
struct Cart: Codable {
    let type: String
    let account: Account
    let allCartsTotalPrice: AllCartsTotalPrice
    let allCartsTotalQty: Int
    let appliedCoupons, appliedOrderPromotions, appliedProductPromotions, appliedVouchers: [Double]
    let code: String
    let couponDiscounts: AllCartsTotalPrice
    let deliveryAddress: Address
    let deliveryCost: AllCartsTotalPrice
    let deliveryMode: DeliveryMode
    let entries: [Entry]
    let grandTotalPrice, grandTotalPriceWithTax, grandTotalTax: AllCartsTotalPrice
    let guid: String
    let orderDiscounts: AllCartsTotalPrice
    let preOrder, preOrderRedeem: Bool
    let promotionDiscounts: AllCartsTotalPrice
    let subCarts: [Double]
    let subTotal, totalDiscounts: AllCartsTotalPrice
    let totalItems: Int
    let totalPrice: AllCartsTotalPrice
    let totalPriceWithTax: TotalPriceWithTax
    let totalTax: AllCartsTotalPrice
    let totalWeight: Int
    let user: User
    let appliedAccountReceivableBalance: Int
    let coupons: [Double]
    let currency: Currency
    let customer: Customer
    let grandTotalPV: Double
    let modifications, potentialOrderPromotions, potentialProductPromotions: [Double]
    let processingAllowCoupons, processingAllowMplus, processingAllowPromotions, processingDamageGoods: Bool
    let processingExternal, processingFreeShipment, processingInternal, processingInvoice: Bool
    let processingPersonalOrder, starterKitsAdded: Bool
    let visibleAppliedOrderPromotions: [Double]

    enum CodingKeys: String, CodingKey {
        case type, account, allCartsTotalPrice, allCartsTotalQty, appliedCoupons, appliedOrderPromotions, appliedProductPromotions, appliedVouchers, code, couponDiscounts, deliveryAddress, deliveryCost, deliveryMode, entries, grandTotalPrice, grandTotalPriceWithTax, grandTotalTax, guid, orderDiscounts, preOrder, preOrderRedeem, promotionDiscounts, subCarts, subTotal, totalDiscounts, totalItems, totalPrice, totalPriceWithTax, totalTax, totalWeight, user, appliedAccountReceivableBalance, coupons, currency, customer
        case grandTotalPV = "grandTotalPv"
        case modifications, potentialOrderPromotions, potentialProductPromotions, processingAllowCoupons, processingAllowMplus, processingAllowPromotions, processingDamageGoods, processingExternal, processingFreeShipment, processingInternal, processingInvoice, processingPersonalOrder, starterKitsAdded, visibleAppliedOrderPromotions
    }
}

// MARK: - Account
struct Account: Codable {
    let accountReceivableBalance: AllCartsTotalPrice
    let accountSubtype, accountType, affiliateNumber, country: String
    let name: String
    let primaryParty: PrimaryParty
    let renewalInfo: RenewalInfo
    let status, uid: String
}

// MARK: - AllCartsTotalPrice
struct AllCartsTotalPrice: Codable {
    let currencyISO: CurrencyISO
    let formattedValue: String
    let priceType: PriceType
    let value: Int
    let amwayValue: AmwayValue?

    enum CodingKeys: String, CodingKey {
        case currencyISO = "currencyIso"
        case formattedValue, priceType, value, amwayValue
    }
}

// MARK: - AmwayValue
struct AmwayValue: Codable {
    let businessVolume: Int
    let formattedPointValue: String
    let pointValue: Double
    let volumeabo: Int
    let businessVolumePerItem: Int?
    let formattedPointValuePerItem: String?
    let pointValuePerItem: Int?
}

enum CurrencyISO: String, Codable {
    case inr = "INR"
}

enum PriceType: String, Codable {
    case buy = "BUY"
}

// MARK: - PrimaryParty
struct PrimaryParty: Codable {
    let name, uid: String
    let currency: Currency
    let defaultAddress: DefaultAddress
    let displayUid, firstName: String
    let language: Currency
    let lastName, customerID: String
}

// MARK: - Currency
struct Currency: Codable {
    let active: Bool
    let isocode, name: String
    let symbol, nativeName: String?
}

// MARK: - DefaultAddress
struct DefaultAddress: Codable {
    let country: Country
    let defaultAddress: Bool
    let dropCode, firstName, formattedAddress, id: String
    let landmark, lastName, line1, line2: String
    let line3, lynxMdmsID, phone, postalCode: String
    let region: PurpleRegion
    let shippingAddress: Bool
    let town: String
    let visibleInAddressBook: Bool

    enum CodingKeys: String, CodingKey {
        case country, defaultAddress, dropCode, firstName, formattedAddress, id, landmark, lastName, line1, line2, line3
        case lynxMdmsID = "lynxMdmsId"
        case phone, postalCode, region, shippingAddress, town, visibleInAddressBook
    }
}

// MARK: - Country
struct Country: Codable {
    let isocode, name: String
}

// MARK: - PurpleRegion
struct PurpleRegion: Codable {
    let countryISO, isocode, name: String

    enum CodingKeys: String, CodingKey {
        case countryISO = "countryIso"
        case isocode, name
    }
}

// MARK: - RenewalInfo
struct RenewalInfo: Codable {
    let code: String
}

// MARK: - Customer
struct Customer: Codable {
    let name, uid: String
    let currency: Currency
    let defaultAddress: Address
    let displayUid, firstName: String
    let language: Currency
    let lastName: String
    let userGroups: [String]
    let customerID: String
}

// MARK: - Address
struct Address: Codable {
    let country: Country
    let defaultAddress: Bool
    let firstName, id, lastName, line1: String
    let line2, lynxMdmsID, phone, postalCode: String
    let region: DeliveryAddressRegion
    let town: String

    enum CodingKeys: String, CodingKey {
        case country, defaultAddress, firstName, id, lastName, line1, line2
        case lynxMdmsID = "lynxMdmsId"
        case phone, postalCode, region, town
    }
}

// MARK: - DeliveryAddressRegion
struct DeliveryAddressRegion: Codable {
    let isocode: String
}

// MARK: - DeliveryMode
struct DeliveryMode: Codable {
    let code, deliveryModeDescription, name: String
    let valueAddedServices: [RenewalInfo]

    enum CodingKeys: String, CodingKey {
        case code
        case deliveryModeDescription = "description"
        case name, valueAddedServices
    }
}

// MARK: - Entry
struct Entry: Codable {
    let aboBasePrice: Int
    let basePointValue: Double
    let bundleNo: String
    let businessVolume: Int
    let discountValues: [Double]
    let isRoc, isWarranty: Bool
    let pointValue: Double
    let price: AllCartsTotalPrice
    let proRatedPrice: Int
    let product: Product
    let quantity: Int
    let removeable: Bool
    let retailBasePrice, returnableQty: Int
    let rocCodes: [Double]
    let sample: Bool
    let serialNumbers: [Double]
    let shippable: Bool
    let taxValues: [Double]
    let totalPriceAfterDiscount: AllCartsTotalPrice
    let unitReturnPrice: Int
    let updateable: Bool
    let value: Value
    let warrantyCodes: [Double]
}

// MARK: - Product
struct Product: Codable {
    let pvPoints: Int
    let alias: String
    let amwayGallery: [AmwayGallery]
    let amwayLabels: [String]
    let amwaySize: String
    let availableForPickup: Bool
    let baseOptions: [Double]
    let brand, businessCategory, businessClass, businessLine: String
    let categories: [Category]
    let code: String
    let dangerous: Bool
    let dimensions: Dimensions
    let durable, futureStockEnabled: Bool
    let hsnCode: String
    let isAbo, isBundle, isPreBookAvailable, isPreOrderServiceProduct: Bool
    let minStockThresholdFlag: Bool
    let name: String
    let needSerialNumber: Bool
    let price: AllCartsTotalPrice
    let purchasable: Bool
    let quantityMultiplier: Int
    let retailPrice: AllCartsTotalPrice
    let stock: Stock
    let type, url: String

    enum CodingKeys: String, CodingKey {
        case pvPoints = "PVPoints"
        case alias, amwayGallery, amwayLabels, amwaySize, availableForPickup, baseOptions, brand, businessCategory, businessClass, businessLine, categories, code, dangerous, dimensions, durable, futureStockEnabled, hsnCode, isAbo, isBundle, isPreBookAvailable, isPreOrderServiceProduct, minStockThresholdFlag, name, needSerialNumber, price, purchasable, quantityMultiplier, retailPrice, stock, type, url
    }
}

// MARK: - AmwayGallery
struct AmwayGallery: Codable {
    let fileSize: String
    let renditions: [Rendition]
    let type: TypeEnum
    let lynxBusinessNaturesVisibility, videoID: String?

    enum CodingKeys: String, CodingKey {
        case fileSize, renditions, type, lynxBusinessNaturesVisibility
        case videoID = "videoId"
    }
}

// MARK: - Rendition
struct Rendition: Codable {
    let assetFormat: AssetFormat
    let renditionType: RenditionType
    let url: String
}

// MARK: - AssetFormat
struct AssetFormat: Codable {
    let height: Int
    let mimeType: MIMEType
    let width: Int
}

enum MIMEType: String, Codable {
    case jpeg = "jpeg"
}

enum RenditionType: String, Codable {
    case imageProductImage180_180 = "IMAGE_product-image_180_180"
    case imageProductImage330_330 = "IMAGE_product-image_330_330"
    case imageProductImage515_515 = "IMAGE_product-image_515_515"
    case imageProductImage600_600 = "IMAGE_product-image_600_600"
    case imageProductImage800_800 = "IMAGE_product-image_800_800"
    case imageProductImage90_90 = "IMAGE_product-image_90_90"
}

enum TypeEnum: String, Codable {
    case image = "IMAGE"
    case video = "VIDEO"
}

// MARK: - Category
struct Category: Codable {
    let code, name: String
}

// MARK: - Dimensions
struct Dimensions: Codable {
    let count, height, length, volume: Count
    let weight, width: Count
}

// MARK: - Count
struct Count: Codable {
    let unit: Unit
    let value: Double
}

// MARK: - Unit
struct Unit: Codable {
    let symbol: String
}

// MARK: - Stock
struct Stock: Codable {
    let isValueRounded: Bool
    let stockLevel: Int
    let stockLevelStatus: String
}

// MARK: - Value
struct Value: Codable {
    let businessVolume: Int
    let formattedPointValue: String
    let pointValue: Double
    let volumeabo: Int
}

// MARK: - TotalPriceWithTax
struct TotalPriceWithTax: Codable {
    let currencyISO: CurrencyISO
    let value: Int

    enum CodingKeys: String, CodingKey {
        case currencyISO = "currencyIso"
        case value
    }
}

// MARK: - User
struct User: Codable {
    let name, uid: String
}

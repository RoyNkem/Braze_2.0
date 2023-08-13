//
//  MarketDataModel.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import Foundation
/*
 
 URL: https://api.coingecko.com/api/v3/global
 
 JSON DATA:
 {
 "data": {
 "active_cryptocurrencies": 13199,
 "upcoming_icos": 0,
 "ongoing_icos": 49,
 "ended_icos": 3376,
 "markets": 590,
 "total_market_cap": {
 "btc": 50540864.68495759,
 "eth": 745666811.1187781,
 "ltc": 18546630228.512997,
 "bch": 8435976095.650357,
 "bnb": 3522397810.285502,
 "eos": 885576588741.5134,
 "xrp": 1882472151813.9849,
 "xlm": 7777669404292.459,
 "link": 132050715803.80519,
 "dot": 155261184542.5724,
 "yfi": 122034905.77893609,
 "usd": 975649552617.9951,
 "aed": 3583585198004.7095,
 "ars": 145557156755078.62,
 "aud": 1531872240813.278,
 "bdt": 101631807001403.52,
 "bhd": 368283314874.4773,
 "bmd": 975649552617.9951,
 "brl": 5077673458593.748,
 "cad": 1339932704326.7363,
 "chf": 970551783705.5641,
 "clp": 915481244708042.5,
 "cny": 6942722216429.656,
 "czk": 24524219849471.668,
 "dkk": 7450938068388.373,
 "eur": 1001179374461.3496,
 "gbp": 880033945162.3279,
 "hkd": 7658580684424.3,
 "huf": 425332471164709.5,
 "idr": 14918364614215972,
 "ils": 3453599408109.4116,
 "inr": 80807783935764.52,
 "jpy": 141825297216314.66,
 "krw": 1390115239065644.8,
 "kwd": 302508924635.18256,
 "lkr": 358151926983353.3,
 "mmk": 2047650700761221.8,
 "mxn": 19551919469509.34,
 "myr": 4524574800265.947,
 "ngn": 423891342137486.1,
 "nok": 10456719210093.883,
 "nzd": 1740680758064.5813,
 "php": 57612105106442.77,
 "pkr": 217569850233812.78,
 "pln": 4869271787205.886,
 "rub": 60831850097635.945,
 "sar": 3668134012585.029,
 "sek": 10931080022576.758,
 "sgd": 1398008243946.3262,
 "thb": 36664042834931.914,
 "try": 18129617551702.855,
 "twd": 30952969881582.17,
 "uah": 36013181164483.15,
 "vef": 97691789703.63966,
 "vnd": 23304662077649744,
 "zar": 17689210319300.617,
 "xdr": 694445887263.3289,
 "xag": 48467547711.81014,
 "xau": 575711288.0088266,
 "bits": 50540864684957.59,
 "sats": 5054086468495759
 },
 "total_volume": {
 "btc": 1672854.7594081624,
 "eth": 24680865.309453536,
 "ltc": 613875897.1012506,
 "bch": 279222819.98595035,
 "bnb": 116588031.84700471,
 "eos": 29311746455.687466,
 "xrp": 62308045543.83916,
 "xlm": 257433491911.4731,
 "link": 4370753642.475706,
 "dot": 5138998177.660663,
 "yfi": 4039239.815518625,
 "usd": 32293076261.85555,
 "aed": 118613276436.7019,
 "ars": 4817804047506.228,
 "aud": 50703520504.12074,
 "bdt": 3363916567500.8936,
 "bhd": 12189828961.94391,
 "bmd": 32293076261.85555,
 "brl": 168066182976.4297,
 "cad": 44350503611.12577,
 "chf": 32124344938.387287,
 "clp": 30301562248786.887,
 "cny": 229797530679.3642,
 "czk": 811728452840.8783,
 "dkk": 246618994104.16486,
 "eur": 33138089188.399506,
 "gbp": 29128290202.041233,
 "hkd": 253491768059.59433,
 "huf": 14078102010203.395,
 "idr": 493783741197154.44,
 "ils": 114310869886.33482,
 "inr": 2674661124157.685,
 "jpy": 4694283030804.625,
 "krw": 46011497988654.375,
 "kwd": 10012758932.674658,
 "lkr": 11854489617064.81,
 "mmk": 67775299091655.086,
 "mxn": 647150018979.9583,
 "myr": 149759141164.35492,
 "ngn": 14030402004136.236,
 "nok": 346107503451.68915,
 "nzd": 57614884685.68306,
 "php": 1906906120969.4846,
 "pkr": 7201356006393.783,
 "pln": 161168285007.66852,
 "rub": 2013476631113.5496,
 "sar": 121411762132.47794,
 "sek": 361808397130.2035,
 "sgd": 46272748975.61285,
 "thb": 1213545097375.7327,
 "try": 600073172405.4263,
 "twd": 1024513990945.4972,
 "uah": 1192002192442.9915,
 "vef": 3233505726.09959,
 "vnd": 771362245501874.8,
 "zar": 585496110073.9,
 "xdr": 22985501235.510937,
 "xag": 1604229931.0062115,
 "xau": 19055498.440595724,
 "bits": 1672854759408.1624,
 "sats": 167285475940816.25
 },
 "market_cap_percentage": {
 "btc": 37.93671342885947,
 "eth": 16.210174776253712,
 "usdt": 7.010852597429078,
 "usdc": 4.727037639806316,
 "bnb": 4.635255056418791,
 "xrp": 2.6470776495964112,
 "busd": 2.2333292441182313,
 "ada": 1.4597466720014622,
 "sol": 1.1886707513247576,
 "doge": 0.8587379689002382
 },
 "market_cap_change_percentage_24h_usd": 0,
 "updated_at": 1665267838
 }
 }
 */

struct GlobalData: Codable {
    let data: MarketDataModel
}

//The structure of the JSON Schema has a data dictionary first. Hence we set it as MarketDataModel
struct MarketDataModel: Codable {
    let markets: Int
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    let updatedAt: Int
    
    enum CodingKeys: String, CodingKey {
        case markets
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        case updatedAt = "updated_at"
    }
    
    ///A  string that returns the value of the total market cap in usd
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    ///A  string that returns the value of the total crypto volume in usd
    var volume: String {
        if let item = totalVolume.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    /// A  string that returns the percentage amount of BTC in the total market cap
    var btcDominant: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc"}) {
            return item.value.asPercentageString()
        }
        return ""
    }
    
}


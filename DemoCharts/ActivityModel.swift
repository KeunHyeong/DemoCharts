//
//  ActivityModel.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import Foundation

struct ChartData: Identifiable, Hashable {
    let id = UUID()
    let date: String
    let value: Double
    let category: String
}

var weekIncomeData: [ChartData] = [
    ChartData(date: "2025.01.01", value: 10, category: "Income"),
    ChartData(date: "2025.01.02", value: 15, category: "Income"),
    ChartData(date: "2025.01.03", value: 35, category: "Income"),
    ChartData(date: "2025.01.04", value: 18, category: "Income"),
    ChartData(date: "2025.01.05", value: 15, category: "Income")
]
var monthIncomeData: [ChartData] = [
    ChartData(date: "2025.05.01", value: 22, category: "Income"),
    ChartData(date: "2025.05.02", value: 28, category: "Income"),
    ChartData(date: "2025.05.03", value: 43, category: "Income"),
    ChartData(date: "2025.05.04", value: 11, category: "Income"),
    ChartData(date: "2025.05.05", value: 28, category: "Income")
]

var weekExpenseData: [ChartData] = [
    ChartData(date: "2025.01.01", value: 10, category: "Expense"),
    ChartData(date: "2025.01.02", value: 20, category: "Expense"),
    ChartData(date: "2025.01.03", value: 30, category: "Expense"),
    ChartData(date: "2025.01.04", value: 40, category: "Expense"),
    ChartData(date: "2025.01.05", value: 50, category: "Expense")
]

var monthExpenseData: [ChartData] = [
    ChartData(date: "2025.05.01", value: 20, category: "Expense"),
    ChartData(date: "2025.05.02", value: 30, category: "Expense"),
    ChartData(date: "2025.05.03", value: 10, category: "Expense"),
    ChartData(date: "2025.05.04", value: 40, category: "Expense"),
    ChartData(date: "2025.05.05", value: 50, category: "Expense")
]



final class ActivityModel: ObservableObject, ActivityModelStateProtocol {
    @Published var jsonLoader: JSONLoader = JSONLoader()
    @Published var transactions: [Transaction] = []
    @Published var selectedRecentTrans: RecentTransMenu = .all
    @Published var selectedTabMenuView: TabMenu = .week
    @Published var incomeData:[ChartData] = []
    @Published var expenseData:[ChartData] = []
    
    init() {
        incomeData = weekIncomeData
        expenseData = weekExpenseData
    }
}

extension ActivityModel: ActivityModelActionProtocol {
    func updateJSONData() async {
        guard let transactions = await self.updateTransactions(fileName: "home-mockdata") else {
            return
        }
        self.transactions = transactions
    }
    
    func updateTransactions(fileName: String) async -> [Transaction]?  {
        guard let transactions = jsonLoader.loadJSONFile(fileName: fileName) else {
            print("No transactions loaded from file.")
            return []
        }
        
        var copys: [Transaction] = []
        var trans: [Transaction] = []
        for transaction in transactions.prefix(selectedRecentTrans.prefix) {
            let dummy: Transaction = Transaction(transaction.amount,
                                                 transaction.name,
                                                 transaction.timestamp,
                                                 transaction.type)
            copys.append(dummy)
        }
        
        // 정렬 코드 추가
        copys.sort { lhs, rhs in
            guard let lhsDate = Utils.parseDate(from: lhs.timestamp),
                  let rhsDate = Utils.parseDate(from: rhs.timestamp) else {
                print("Sorting failed for lhs: \(lhs.timestamp), rhs: \(rhs.timestamp)")
                return false
            }
            return lhsDate > rhsDate
        }
        
        for copy in copys {
            if let formattedDate = Utils.formatDate(from: copy.timestamp),
               let dollarStr = self.addDollarChar(from: copy.amount) {
                let dummy: Transaction = Transaction(dollarStr,
                                                     copy.name,
                                                     formattedDate,
                                                     copy.type)
                trans.append(dummy)
            }
        }
        
        print("전체 transaction 갯수: \(trans.count)")
        return trans
    }
    
    func addDollarChar(from amount: String) -> String? {
        var dollarAmount : String = ""
        if amount.prefix(1) == "-" {
            dollarAmount = "-$" + amount.dropFirst()
        }else {
            dollarAmount = "$" + amount
        }
        return dollarAmount
    }
    
    func updateChartData() {
        incomeData = selectedTabMenuView == .week ? weekIncomeData : monthIncomeData
        expenseData = selectedTabMenuView == .week ? weekExpenseData : monthExpenseData
    }
}

extension ActivityModel: ActivityModelRouterProtocol {}

protocol ActivityModelStateProtocol {
    var transactions: [Transaction] { get }
    var selectedRecentTrans: RecentTransMenu { get set }
    var selectedTabMenuView: TabMenu { get set }
    var incomeData: [ChartData] { get set }
    var expenseData: [ChartData] { get set }
}

protocol ActivityModelActionProtocol {
    func updateJSONData() async
    func updateChartData()
}

protocol ActivityModelRouterProtocol {}

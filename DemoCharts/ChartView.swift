//
//  ChartView.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/10/25.
//

import SwiftUI
import Charts

struct ChartView: View {
    @Binding var selectecdTab: TabMenu
    @Binding var incomeData: [ChartData]
    @Binding var expenseData: [ChartData]
    
    @State private var selectedIncomeData: ChartData? = nil
    @State private var selectedExpenseData: ChartData? = nil
    @State private var displayedIncomeData: [ChartData] = []
    @State private var displayedExpenseData: [ChartData] = []
    @State private var incomeMinYValue: Int = 0
    @State private var incomeMaxYValue: Int = 0
    @State private var expenseMinYValue: Int = 0
    @State private var expenseMaxYValue: Int = 0
    @State private var isButtonDisabled: Bool = false
    @State private var chartOpacity: Double = 0.0 // 애니메이션용 opacity 상태 추가
    
    var selectTab: () -> Void
    
    var body: some View {
        VStack {
            TabMenuView(selectedTabMenu: $selectecdTab)
                .disabled(isButtonDisabled)
            // Income Chart
            Chart {
                ForEach(displayedIncomeData, id: \.id) { item in
                    LineMark(
                        x: .value("Date", item.date),
                        y: .value("Income", item.value),
                        series: .value("category", "Income")
                    )
                    .foregroundStyle(Color.deepBlue)
                    .interpolationMethod(.catmullRom)
                }
                
                //차트의 그림자 효과
                ForEach(displayedIncomeData, id: \.id) { item in
                    AreaMark(
                        x: .value("Date", item.date),
                        yStart: .value("Zero", 0),
                        yEnd: .value("Income", item.value)
                    )
                    .foregroundStyle(
                        Color.deepBlue.opacity(0.01)
                    )
                    .interpolationMethod(.catmullRom)
                }
                
                if let selected = selectedIncomeData {
                    PointMark(
                        x: .value("Date", selected.date),
                        y: .value("Value", selected.value)
                    )
                    .symbol {
                        customSymbol(for: selected, color: .deepBlue)
                    }
                }
            }
            .opacity(chartOpacity)
            .chartOverlay { proxy in
                GeometryReader { geometry in
                    Rectangle()
                        .fill(Color.clear)
                        .contentShape(Rectangle())
                        .gesture(chartOverlayGesture(proxy: proxy, data: incomeData, selectedData: $selectedIncomeData))
                }
            }
            .chartYScale(domain: incomeMinYValue...incomeMaxYValue)
            .frame(height: 150)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            
            // Expense Chart
            Chart {
                ForEach(displayedExpenseData, id: \.id) { item in
                    LineMark(
                        x: .value("Date", item.date),
                        y: .value("Expense", item.value),
                        series: .value("category", "Expense")
                    )
                    .foregroundStyle(Color.cyon)
                    .interpolationMethod(.catmullRom)
                }
                
                //차트의 그림자 효과
                ForEach(displayedExpenseData, id: \.id) { item in
                    AreaMark(
                        x: .value("Date", item.date),
                        yStart: .value("Zero", 0),
                        yEnd: .value("Income", item.value)
                    )
                    .foregroundStyle(
                        Color.cyon.opacity(0.1)
                    )
                    .interpolationMethod(.catmullRom)
                }
                
                if let selected = selectedExpenseData {
                    PointMark(
                        x: .value("Date", selected.date),
                        y: .value("Value", selected.value)
                    )
                    .symbol {
                        customSymbol(for: selected, color: .cyon)
                    }
                }
            }
            .opacity(chartOpacity)
            .chartOverlay { proxy in
                GeometryReader { geometry in
                    Rectangle()
                        .fill(Color.clear)
                        .contentShape(Rectangle())
                        .gesture(chartOverlayGesture(proxy: proxy, data: expenseData, selectedData: $selectedExpenseData))
                }
            }
            .chartYScale(domain: expenseMinYValue...expenseMaxYValue)
            .frame(height: 100)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
        }
        .onAppear {
            calculateYScale()
            Task {
                await startAnimation()
                withAnimation(.easeIn(duration: 1.0)) {
                    chartOpacity = 1.0
                }
            }
        }
        .onChange(of: selectecdTab) { _,_ in
            if !isButtonDisabled {
                isButtonDisabled = true
                selectTab()
                calculateYScale()
                Task {
                    await startAnimation()
                    withAnimation(.easeIn(duration: 1.0)) {
                        chartOpacity = 1.0
                    }
                    // 1초 후 week, month 버튼 활성화
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        isButtonDisabled = false
                    }
                }
            }
        }
        
        HStack {
            Text(incomeData.first?.date ?? "")
                .font(.caption)
                .foregroundStyle(Color.lightGray)
            
            Spacer()
            
            Text(incomeData.last?.date ?? "")
                .font(.caption)
                .foregroundStyle(Color.lightGray)
            
        }
    }
    
    // MARK: - Custom Symbol
    func customSymbol(for data: ChartData, color: Color) -> some View {
        VStack {
            VStack {
                Text("\(data.value)")
                    .bold()
                    .font(.caption)
                    .foregroundStyle(.white)
                    .frame(width: 77, height: 18)
                
                Text(data.date)
                    .font(.caption)
                    .foregroundStyle(.white)
                    .frame(width: 77, height: 18)
            }
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Circle()
                .frame(width: 10, height: 10)
                .foregroundStyle(color)
        }
        .background(.clear)
        .padding(.bottom, 50)
        .frame(width: 94, height: 61)
    }
    
    // MARK: - Chart Overlay Gesture
    func chartOverlayGesture(proxy: ChartProxy, data: [ChartData], selectedData: Binding<ChartData?>) -> some Gesture {
        DragGesture()
            .onChanged { value in
                if let date: String = proxy.value(atX: value.location.x) {
                    selectedData.wrappedValue = data.first { $0.date == date }
                }
            }
            .onEnded { _ in
                selectedData.wrappedValue = nil
            }
    }
    
    // MARK: - Calculate Y Scale
    func calculateYScale() {
        incomeMinYValue = max(0, (incomeData.map { Int($0.value) }.min() ?? 0) - 10)
        incomeMaxYValue = (incomeData.map { Int($0.value) }.max() ?? 0) + 50
        expenseMinYValue = max(0, (expenseData.map { Int($0.value) }.min() ?? 0) - 10)
        expenseMaxYValue = (expenseData.map { Int($0.value) }.max() ?? 0) + 50
    }
    
    // MARK: - Start Animation
    func startAnimation() async {
        displayedIncomeData = []
        displayedExpenseData = []
        
        for (index, data) in incomeData.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.05) {
                withAnimation(.smooth) {
                    displayedIncomeData.append(data)
                }
            }
        }
        
        for (index, data) in expenseData.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.05) {
                withAnimation(.smooth) {
                    displayedExpenseData.append(data)
                }
            }
        }
    }
}



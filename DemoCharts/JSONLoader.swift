//
//  JSONLoader.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import Foundation

class JSONLoader: ObservableObject {
    func loadJSONFile(fileName: String) -> [Transaction]? {
        // 프로젝트 내 JSON 파일의 URL 가져오기
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("JSON 파일을 찾을 수 없습니다.")
            return nil
        }
        
        do {
            // 파일 데이터 읽기
            let data = try Data(contentsOf: url)
            
            // JSON 디코딩
            let decoder = JSONDecoder()
            let transactions = try decoder.decode([Transaction].self, from: data)
            return transactions
        } catch {
            print("JSON 디코딩 오류: \(error)")
            return nil
        }
    }
    

}

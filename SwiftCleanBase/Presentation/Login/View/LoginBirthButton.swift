//
//  LoginView.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation
import SwiftUI

struct LoginBirthButton: View {
    @State private var showingPicker = false
    @Binding var birth: String
    
    let onYearMonthSelected: (Int, Int) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Birthday")
                .font(.body)
            Button(action: {
                showingPicker = true
            }) {
                HStack {
                    Text(birth.isEmpty ? "Select your birthday" : birth)
                        .foregroundColor(birth.isEmpty ? .gray : .black)
                    Spacer()
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
            .sheet(isPresented: $showingPicker) {
                YearMonthPickerView(onYearMonthSelected: { year, month in
                    birth = "\(year)-\(String(format: "%02d", month))"
                    onYearMonthSelected(year, month)
                    showingPicker = false
                })
            }
            Text("Select your birth month and year.")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
    }
}

struct YearMonthPickerView: View {
    @Environment(\.presentationMode) var presentationMode
    let onYearMonthSelected: (Int, Int) -> Void
    
    @State private var selectedYear = Calendar.current.component(.year, from: Date())
    @State private var selectedMonth = Calendar.current.component(.month, from: Date())
    
    var body: some View {
        VStack {
            Picker("Year", selection: $selectedYear) {
                ForEach((selectedYear-100...selectedYear).reversed(), id: \.self) { year in
                    Text("\(year)").tag(year)
                }
            }
            Picker("Month", selection: $selectedMonth) {
                ForEach(1..<13, id: \.self) { month in
                    Text("\(month)").tag(month)
                }
            }
            HStack {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Button("OK") {
                    onYearMonthSelected(selectedYear, selectedMonth)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding()
        }
        .pickerStyle(WheelPickerStyle())
        .padding()
    }
}

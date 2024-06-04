//
//  StudentListView.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation
import SwiftUI


struct StudentListView: View {
    var isRegistered: Bool
    var students: [StudentDto]
    var onClick: (String) -> Void
    
    var body: some View {
        List(students) { student in
            StudentCard(isRegistered: isRegistered, student: student, onClick: onClick)
        }
    }
}

struct StudentCard: View {
    var isRegistered: Bool
    var student: StudentDto
    var onClick: (String) -> Void
    
    var body: some View {
        CardView {
            HStack {
                Text("\(student.name ?? String()) (\(student.birth ?? String()))")
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button(action: { onClick(student.id ?? String()) }) {
                    Text(isRegistered ? "Remove Student" : "Register Course")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isRegistered ? Color.red : Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(4)
            }
            .padding(8)
        }
        .padding(.vertical, 8)
    }
}

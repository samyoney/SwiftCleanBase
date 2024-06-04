//
//  SamEvent.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation
import SwiftUI

struct SamView: View {
    @State private var listCourse: [CourseDto] = []
    @State private var listStudent: [StudentDto] = []
    @State private var listStudentByCode: [StudentDto] = []

    @State private var isCourseScreen = false
    
    var body: some View {
        NavigationView {
            VStack {
                if isCourseScreen {
                    CourseListView(courses: listCourse) { id in
                    }
                } else {
                    Spacer(minLength: 30)
                    VStack {
                        Text("Total Students")
                            .font(.title)
                        Spacer(minLength: 20)
                        StudentListView(isRegistered: false, students: listStudent) { id in
                        }
                    }
                    Spacer(minLength: 30)
                    VStack {
                        Text("Enrolled Students")
                            .font(.title)
                        Spacer(minLength: 20)
                        StudentListView(isRegistered: true, students: listStudentByCode) { id in
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
            .navigationTitle(isCourseScreen ? "Courses" : "Students")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                    }) {
                        Image(systemName: "chevron.left")
                    }
                }
            }
            .onAppear {
            }
        }
    }
}

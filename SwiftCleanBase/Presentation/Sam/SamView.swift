//
//  SamEvent.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation
import SwiftUI

struct SamView: View {
    @StateObject var viewModel: SamViewModel = .init()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.state.isCourseScreen {
                    CourseListView(courses: viewModel.state.listCourse) { id in
                        viewModel.onTriggerEvent(.selectCourse(id))
                    }
                } else {
                    Spacer(minLength: 30)
                    VStack {
                        Text("Total Students")
                            .font(.title)
                        Spacer(minLength: 20)
                        StudentListView(isRegistered: false, students: viewModel.state.listStudent) { id in
                            viewModel.onTriggerEvent(.registerStudent(id))
                        }
                    }
                    Spacer(minLength: 30)
                    VStack {
                        Text("Enrolled Students")
                            .font(.title)
                        Spacer(minLength: 20)
                        StudentListView(isRegistered: true, students: viewModel.state.listStudentByCode) { id in
                            viewModel.onTriggerEvent(.removeStudent(id))
                        }
                    }
                }
            }
            .navigationTitle(viewModel.state.isCourseScreen ? "Courses" : "Students")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        viewModel.onTriggerEvent(.back)
                    }) {
                        Image(systemName: "chevron.left")
                    }
                }
            }
            .onAppear {
                viewModel.onTriggerEvent(.initData)
            }
        }
    }
}

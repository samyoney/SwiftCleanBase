//
//  SamEvent.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation
import SwiftUI

struct SamView: View {
    @EnvironmentObject var router: AppRouter
    
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
                        Text(R.string.textFile.totalStudentsTitle())
                            .font(.title)
                        Spacer(minLength: 20)
                        StudentListView(isRegistered: false, students: viewModel.state.listStudent) { id in
                            viewModel.onTriggerEvent(.registerStudent(id))
                        }
                    }
                    Spacer(minLength: 30)
                    VStack {
                        Text(R.string.textFile.enrolledStudent())
                            .font(.title)
                        Spacer(minLength: 20)
                        StudentListView(isRegistered: true, students: viewModel.state.listStudentByCode) { id in
                            viewModel.onTriggerEvent(.removeStudent(id))
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(R.color.statusBarColor), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(viewModel.state.isCourseScreen ? R.string.textFile.courseNavTab() : R.string.textFile.studentNavTab())
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(R.color.orangeBgColor))
                }
                ToolbarItem(placement: .topBarLeading) {
                    if !viewModel.state.isCourseScreen {
                        Button {
                            viewModel.onTriggerEvent(.back)
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color(R.color.orangeBgColor))
                        }
                    }
                }
            }
            .onAppear {
                viewModel.onTriggerEvent(.initData)
            }
        }
    }
}

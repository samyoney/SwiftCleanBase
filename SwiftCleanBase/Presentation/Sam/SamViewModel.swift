//
//  SamViewModel.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/10.
//

import Foundation
import Resolver

@MainActor
class SamViewModel: ViewModel {
    @Injected private var getCoursesUseCase: GetCoursesUseCase
    @Injected private var getStudentsUseCase: GetStudentsUseCase
    @Injected private var getStudentsByCourseIdUseCase: GetStudentsByCourseIdUseCase
    @Injected private var addStudentIntoCourseUseCase: AddStudentIntoCourseUseCase
    @Injected private var removeStudentFromCourseUseCase: RemoveStudentFromCourseUseCase
    
    @Published var state: SamState = .init()
    
    private var currentCourseId = String()
    
    func onTriggerEvent(_ eventType: SamEvent) {
        switch eventType {
        case .initData:
            onInitData()
        case .back:
            onBack()
        case .registerStudent(let id) :
            onRegisterStudent(id)
        case .removeStudent(let id):
            onRemoveStudent(id)
        case .selectCourse(let id):
            onSelectCourse(id)
        }
    }
    
    private func onInitData() {
        if let listCourse = getCoursesUseCase(), let listStudent = getStudentsUseCase() {
            state.listCourse = listCourse
            state.listStudent = listStudent
        }
    }
    
    private func onBack() {
        state.isCourseScreen = true
    }
    
    private func onRegisterStudent(_ id: String) {
        addStudentIntoCourseUseCase(id: id, courseId: currentCourseId)
        onSelectCourse(currentCourseId)
    }
    
    private func onRemoveStudent(_ id: String) {
        removeStudentFromCourseUseCase(id: id)
        onSelectCourse(currentCourseId)
    }
    
    private func onSelectCourse(_ courseId: String) {
        if let listStudentByCode = getStudentsByCourseIdUseCase(courseId: courseId) {
            currentCourseId = courseId
            state.listStudentByCode = listStudentByCode
            state.isCourseScreen = false
        }
    }
}

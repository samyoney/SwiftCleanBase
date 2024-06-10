//
//  CourseListView.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation
import SwiftUI

struct CourseListView: View {
    var courses: [CourseDto]
    var onClickItem: (String) -> Void
    
    var body: some View {
        List(courses) { course in
            CourseCard(course: course) { _ in
                if let id = course.id {
                    onClickItem(id)
                }
            }
        }
    }
}

struct CourseCard: View {
    var course: CourseDto
    var onClickItem: (String) -> Void
    
    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: 8) {
                Text(course.name ?? String())
                    .font(.headline)
                Text("Instructor: \(course.instructor ?? String())")
                Text("Topics:")
                ForEach(course.topics?.split(separator: ";") ?? [], id: \.self) { topic in
                    Text("- \(topic)")
                }
            }
            .padding(16)
            .onTapGesture {
                if let id = course.id {
                    onClickItem(id)
                }
            }
        }
        .padding(8)
    }
}

struct CardView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .background(.transparent)
            .cornerRadius(8)
            .shadow(radius: 4)
    }
}

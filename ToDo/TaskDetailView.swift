//
// TaskDetailView.swift
// ToDo
//
// タスク詳細情報を表示・編集するための画面
// このファイルはタスクの詳細情報を表示および編集するためのUIを提供します。
//

import SwiftUI

struct TaskDetailView: View {
    // 編集対象のタスク
    @Binding var todoItem: TodoItem
    
    // 親ビューに戻るための環境変数
    @Environment(\.dismiss) private var dismiss
    
    // 編集中のタスク情報を一時的に保持
    @State private var editedTitle: String
    @State private var editedDetails: String
    @State private var editedIsCompleted: Bool
    
    // 初期化処理
    init(todoItem: Binding<TodoItem>) {
        self._todoItem = todoItem
        self._editedTitle = State(initialValue: todoItem.wrappedValue.title)
        self._editedDetails = State(initialValue: todoItem.wrappedValue.details)
        self._editedIsCompleted = State(initialValue: todoItem.wrappedValue.isCompleted)
    }
    
    var body: some View {
        Form {
            Section(header: Text("タスク情報")) {
                // タスクタイトル入力フィールド
                TextField("タイトル", text: $editedTitle)
                
                // タスク詳細入力エリア（複数行対応）
                ZStack(alignment: .topLeading) {
                    if editedDetails.isEmpty {
                        Text("詳細情報を入力してください")
                            .foregroundColor(Color(.placeholderText))
                            .padding(.top, 8)
                            .padding(.leading, 4)
                    }
                    TextEditor(text: $editedDetails)
                        .frame(minHeight: 100)
                }
                
                // タスク完了状態の切り替えトグル
                Toggle("完了", isOn: $editedIsCompleted)
            }
            
            Section {
                // 変更を保存するボタン
                Button("保存") {
                    saveChanges()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.blue)
            }
        }
        .navigationTitle("タスク詳細")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("完了") {
                    saveChanges()
                }
            }
        }
    }
    
    // 変更を保存するメソッド
    private func saveChanges() {
        // 編集内容をタスクに反映
        todoItem.title = editedTitle
        todoItem.details = editedDetails
        todoItem.isCompleted = editedIsCompleted
        
        // DataManagerを使って変更を保存（ContentViewで処理）
        
        // 詳細画面を閉じる
        dismiss()
    }
}

#Preview {
    NavigationStack {
        TaskDetailView(todoItem: .constant(TodoItem(title: "サンプルタスク", details: "これはサンプルタスクの詳細情報です。")))
    }
}

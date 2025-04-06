
//
// ContentView.swift
// ToDoApp
//
// メインのユーザーインターフェイスとタスク管理機能を実装します。
// このファイルはToDoアプリの中心的な役割を担い、UIの表示とタスクの操作ロジックを提供します。
// DataManagerと連携してタスクデータの永続化も行います。
//

import SwiftUI
// タスク詳細画面を使用するためのインポート

struct ContentView: View {
    // DataManagerからタスクデータを読み込んで初期化
    @State private var todoItems = DataManager.shared.loadTodoItems()
    
    // 新しいタスク入力用のテキスト状態変数
    @State private var newItemTitle = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                // 新しいタスク入力フィールド
                HStack {
                    // ユーザーがタスク名を入力するテキストフィールド
                    TextField("New Item here...", text: $newItemTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    // タスク追加ボタン
                    Button(action: addItem) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .font(.title)
                    }
                }
                .padding()
                
                // タスクのリスト表示部分
                List {
                    // 各タスクをループで表示
                    ForEach($todoItems) { $item in
                        NavigationLink(destination: TaskDetailView(todoItem: $item)) {
                            HStack {
                                // タスクの完了状態を示すアイコン(タップで切り替え可能)
                                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(item.isCompleted ? .green : .gray)
                                    .onTapGesture {
                                        toggleItemCompletion(item)
                                    }
                                
                                VStack(alignment: .leading) {
                                    // タスクのタイトル(完了時は取り消し線と色変更)
                                    Text(item.title)
                                        .strikethrough(item.isCompleted)
                                        .foregroundColor(item.isCompleted ? .gray : .primary)
                                    
                                    // 詳細情報があれば表示(プレビューとして)
                                    if !item.details.isEmpty {
                                        Text(item.details)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                            .lineLimit(1)
                                    }
                                }
                            }
                        }
                    }
                    // スワイプでタスク削除機能を有効化
                    .onDelete(perform: deleteItems)
                }
            }
            .navigationTitle("ToDo List") // 画面上部のタイトル
        }
    }
    
    // タスクを追加するメソッド
    private func addItem() {
        // 空のタスクは追加しない
        guard !newItemTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        
        // 新しいTodoItemを作成してリストに追加
        let newItem = TodoItem(title: newItemTitle)
        todoItems.append(newItem)
        
        // 入力フィールドをクリア
        newItemTitle = ""
        
        // 変更をDataManagerに保存
        DataManager.shared.saveTodoItems(todoItems)
    }
    
    // タスクの完了状態を切り替えるメソッド
    private func toggleItemCompletion(_ item: TodoItem) {
        // 指定されたアイテムのインデックスを探す
        if let index = todoItems.firstIndex(where: { $0.id == item.id }) {
            // 完了状態を反転(true→false、false→true)
            todoItems[index].isCompleted.toggle()
        }
        
        // 変更をDataManagerに保存
        DataManager.shared.saveTodoItems(todoItems)
    }
    
    // タスクを削除するメソッド
    private func deleteItems(at offsets: IndexSet) {
        // 指定されたインデックスのアイテムを削除
        todoItems.remove(atOffsets: offsets)
        
        // 変更をDataManagerに保存
        DataManager.shared.saveTodoItems(todoItems)
    }
}

// SwiftUIプレビュー用の設定
#Preview {
    ContentView()
}

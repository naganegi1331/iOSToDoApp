//
// TodoItem.swift
// ToDoApp
//
// タスク管理のためのデータモデル
// このファイルはToDoアプリのデータ構造を定義します。
// TodoItemはアプリケーション内のタスク項目を表現し、一意のID、タイトル、完了状態を持ちます。
// IdentifiableプロトコルはSwiftUIのListなどで個々のアイテムを識別するために使用され、
// Equatableプロトコルはタスクの比較を可能にします。
//

import Foundation

struct TodoItem: Identifiable, Equatable {
   // 各タスクを一意に識別するためのID
   var id = UUID()
   
   // タスクのタイトル
   var title: String
   
   // タスクの詳細情報
   var details: String = ""
   
   // タスクの完了状態（デフォルトは未完了）
   var isCompleted: Bool = false
   
   // 2つのTodoItemが同じかどうかを比較するメソッド
   // IDが同じであれば同一のタスクとみなす
   static func ==(lhs: TodoItem, rhs: TodoItem) -> Bool {
       return lhs.id == rhs.id
   }
}

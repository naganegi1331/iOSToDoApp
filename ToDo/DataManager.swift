/**
 * TodoItemの保存と読み込みを管理するデータマネージャークラス
 * UserDefaultsを使用してTodoアイテムを永続化する
 */
import Foundation

class DataManager {
    // シングルトンインスタンス
    static let shared = DataManager()
    
    // UserDefaultsのキー
    private let todoItemsKey = "todoItems"
    
    /**
     * TodoItemの配列をUserDefaultsに保存する
     * @param items 保存するTodoItem配列
     */
    func saveTodoItems(_ items: [TodoItem]) {
        // TodoItemをディクショナリ形式に変換
        let data = items.map { ["id": $0.id.uuidString, "title": $0.title, "isCompleted": $0.isCompleted] }
        // UserDefaultsに保存
        UserDefaults.standard.set(data, forKey: todoItemsKey)
    }
    
    /**
     * UserDefaultsからTodoItemの配列を読み込む
     * @return 読み込んだTodoItem配列
     */
    func loadTodoItems() -> [TodoItem] {
        // UserDefaultsからデータを取得し、ディクショナリ配列に変換
        guard let data = UserDefaults.standard.array(forKey: todoItemsKey) as? [[String: Any]] else {
            return []  // データがない場合は空配列を返す
        }
        
        // ディクショナリからTodoItemオブジェクトに変換
        return data.compactMap { dict in
            // 必要なプロパティが存在するか確認
            guard let idString = dict["id"] as? String,
                  let id = UUID(uuidString: idString),
                  let title = dict["title"] as? String,
                  let isCompleted = dict["isCompleted"] as? Bool else {
                return nil  // 必要なプロパティがない場合はnilを返す
            }
            
            // TodoItemオブジェクトを生成して返す
            return TodoItem(id: id, title: title, isCompleted: isCompleted)
        }
    }
}

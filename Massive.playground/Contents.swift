import Foundation

//1)       Дан массив целый чисел, необходимо реализовать функцию/метод, вручную его разворачивающий, не используя системные методы наподобие reverse (и не создавая расширений),  вспомогательные массивы и структуры данных.
//Т.е. необходимо реализовать собственное решение, без использования готовых системных методов.
//Например, на входе: [1, 2, 3, 4, 5], на выходе: [5, 4, 3, 2, 1]
//
//2)       Объявить переменную – матрицу целых чисел и проинициализировать ее рандомными (можно использовать системный генератор случайных чисел) значениями (т.е. не в ручную).
//Матрица - это  массив массивов целых чисел размера NxM (строк x колонок), пусть N = 4, M = 5.
//Желательно предусмотреть возможно задания N & M как константы и автоматически в цикле инициализировать матрицу.
//Поменять значения строк в четных позициях на значения строк в нечетных позициях.
//Как и в предыдущем задании необходимо использовать собственное ("ручное") решение.
//Работу с матрицами необходимо осуществлять не как оперирование векторами, а как оперирование двойным/вложенным сабскриптом.
//              При этом не требуется создавать новые классы или структуры, просто объявить переменную соответствующего типа и реализовать методы инициализации, печати и выполнения требуемого действия по задаче.
//              Например, на выходе:
//[0, 1, 2, 3]
//[4, 5, 6, 7]
//[8, 9, 0, 1]
//[2, 3, 4, 5]
//На выходе:
//[4, 5, 6, 7]
//[0, 1, 2, 3]
//[2, 3, 4, 5]
//[8, 9, 0, 1]




// MARK: - Задание 1
var lession1 = [1, 2, 3, 4, 5]

func reverb(_ inputMassive: inout [Int]) {

    let count = inputMassive.count - 1

    for x in 0...count / 2{
        let first = inputMassive[0 + x]
        inputMassive[0 + x] = inputMassive[count - x]
        inputMassive[count - x] = first
    }

}
reverb(&lession1)
print(lession1)

// MARK: - Задание 2
let n = 4 // Строк матрицы
let m = 5 // Колонок матрицы

// MARK: - Создание матрицы
func create(rows: Int, columns: Int) -> [[Int]]{
    
    var table = Array<Array<Int>>()
    
    for _ in 1...rows {
        var result: [Int] = []
        for _ in 1...columns {
            result.append(Int.random(in: 1...9))
        }
        table.append(result)
    }
    return table
}
// MARK: - Смена значений строк
func moving(_ input: [[Int]]) -> [[Int]] {  // Шаг между двумя соседними строками / построчно
    
    var table = input
    
    for numberOfLine in stride(from: 0, to: table.count, by: 2){ // переход между парами строк используя numberOfLine
        
        for numberInLine in 0...table[0].count - 1 { // смена значений между четными и нечетными строками построчно, для перехода между столбцами использую numberInLine
            
            let firstIndex = table[0 + numberOfLine][0 + numberInLine]
            table[0 + numberOfLine][0 + numberInLine] = table[1 + numberOfLine][0 + numberInLine]
            table[1 + numberOfLine][0 + numberInLine] = firstIndex
            
        }
        
    }
    return table
}

// MARK: - Вывод в консоль
func printMatrix(_ matrix: [[Int]]) {
    print("Ваша матрица -")
    for row in matrix{
        print(row)
    }
}


var table = create(rows: n, columns: m)
printMatrix(table)
table = moving(table)
printMatrix(table)

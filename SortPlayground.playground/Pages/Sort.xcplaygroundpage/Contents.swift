//: [Previous](@previous)

import Foundation

example("冒泡排序") {
    func bubbleSort(arr: Array<Int>) -> Array<Int> {
        var array = arr
        let len = arr.count
        
        for i in 0..<len - 1 {
            for j in 0..<len - 1 - i {
                if array[j] > array[j + 1] {
                    let temp = array[j + 1]
                    array[j + 1] = array[j]
                    array[j] = temp
                }
            }
        }
        
        return array
    }

    let sortArr = [9, 6, 4, 2, 1, 3, 7, 8, 5]
    print(bubbleSort(arr: sortArr))
}

example("选择排序") {
    func selectionSort(arr: Array<Int>) -> Array<Int> {
        var array = arr
        let len = arr.count
        var minIndex: Int, temp: Int
        
        for i in 0..<len - 1 {
            minIndex = i
            for j in (i + 1)..<len {
                if array[j] < array[minIndex] {
                    minIndex = j
                }
            }
            temp = array[i]
            array[i] = array[minIndex]
            array[minIndex] = temp
        }
        
        return array
    }

    let sortArr = [9, 6, 4, 2, 1, 3, 7, 8, 5]
    print(selectionSort(arr: sortArr))
}

example("插入排序") {
    func insertionSort(arr: Array<Int>) -> Array<Int> {
        var array = arr
        let len = array.count
        var preIndex: Int, current: Int
        
        for i in 1..<len {
            preIndex = i - 1
            current = array[i]
            while preIndex >= 0 && array[preIndex] > current {
                array[preIndex + 1] = array[preIndex]
                preIndex -= 1
            }
            array[preIndex + 1] = current
        }
        
        return array
    }
    
    let sortArr = [9, 6, 4, 2, 1, 3, 7, 8, 5]
    print(insertionSort(arr: sortArr))
}

example("归并排序") {
    func mergeSort(arr: Array<Int>) -> Array<Int> {
        let len = arr.count
        guard len > 1 else {
            return arr
        }
        
        let middle = len / 2
        let leftArr = Array(arr[0..<middle])
        let rightArr = Array(arr[middle..<len])
        
        return merge(left: mergeSort(arr: leftArr), right: mergeSort(arr: rightArr))
    }

    func merge(left: Array<Int>, right: Array<Int>) -> Array<Int> {
        var left = left, right = right
        var result = [Int]()
        
        while left.count > 0 && right.count > 0 {
            if left.first! <= right.first! {
                result.append(left.removeFirst())
            } else {
                result.append(right.removeFirst())
            }
        }
        
        while left.count > 0 {
            result.append(left.removeFirst())
        }
        
        while right.count > 0 {
            result.append(right.removeFirst())
        }
        
        return result
    }

    let sortArr = [9, 6, 4, 2, 1, 3, 7, 8, 5]
    print(mergeSort(arr: sortArr))
}

example("快速排序") {
    func quickSort(arr: inout Array<Int>, left: Int, right: Int) {
        guard left < right else { return }
        
        let partitionIndex  = partition(&arr, left, right)
        quickSort(arr: &arr, left: left, right: partitionIndex - 1)
        quickSort(arr: &arr, left: partitionIndex + 1, right: right)
    }

    func partition(_ arr: inout Array<Int>, _ left: Int, _ right: Int) -> Int {
        let pivot = left
        var index = pivot + 1
        
        for i in index...right {
            if arr[i] < arr[pivot] {
                swapArr(&arr, i, index)
                index += 1
            }
        }
        swapArr(&arr, pivot, index - 1)
        return index - 1
    }
    
    var sortArr = [9, 6, 4, 2, 1, 3, 7, 8, 5]
    quickSort(arr: &sortArr, left: 0, right: sortArr.count - 1)
    print(sortArr)
    
    //求数组中第i个大的值
    func selectIndex(_ arr: inout Array<Int>, _ left: Int, _ right: Int, _ index: Int) -> Int {
        if left == right {
            return arr[left]
        }
        
        let partitionIndex = partition(&arr, left, right)
        let k = partitionIndex - left + 1
        
        if index == k {
            return arr[partitionIndex]
        } else if index < k {
            return selectIndex(&arr, left, partitionIndex - 1, index)
        } else {
            return selectIndex(&arr, partitionIndex + 1, right, index - k)
        }
    }

    
    var selectArr = [9, 6, 4, 2, 1, 3, 7, 8, 5]
    let index = Int(arc4random_uniform(8))
    let value = selectIndex(&selectArr, 0, selectArr.count - 1, index)
    print("第\(index)个大的数为: \(value)")
}

example("堆排序") {
    var len = 0

    func buildMaxHeap(_ arr: inout Array<Int>) {
        len = arr.count

        var i = len / 2 - 1
        while i >= 0 {
            heapify(&arr, i)
            i -= 1
        }
    }

    func heapify(_ arr: inout Array<Int>, _ i: Int) {
        let left = 2 * i + 1
        let right = 2 * i + 2
        var largest = i
        
        if left < len && arr[left] > arr[largest] {
            largest = left
        }
        
        if right < len && arr[right] > arr[largest] {
            largest = right
        }
        
        if largest != i {
            swapArr(&arr, i, largest)
            heapify(&arr, largest)
        }
    }

    func heapSort(_ arr: inout Array<Int>) {
        buildMaxHeap(&arr)
        
        var i = arr.count - 1
        while i > 0 {
            swapArr(&arr, 0, i)
            len -= 1
            heapify(&arr, 0)
            i -= 1
        }
    }

    var heapArr = [9, 6, 4, 2, 1, 3, 7, 8, 5]
    heapSort(&heapArr)
    print(heapArr)
}

example("记数排序") {
    func countingSort(_ arr: inout Array<Int>, _ maxValue: Int) {
        var bucket = [Int](repeating: 0, count: maxValue + 1)
        var sortedIndex = 0
        
        for i in 0..<arr.count {
            bucket[arr[i]] += 1
        }
        
        for j in 0...maxValue {
            while bucket[j] > 0 {
                arr[sortedIndex] = j
                sortedIndex += 1
                bucket[j] -= 1
            }
        }
    }

    var countingArr = [9, 6, 4, 2, 1, 3, 7, 8, 5]
    countingSort(&countingArr, 9)
    print(countingArr)
}

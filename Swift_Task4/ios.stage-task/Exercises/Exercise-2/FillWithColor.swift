import Foundation

final class FillWithColor {
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        var resultImage = image
        let currentPointColor = image[row][column]
        
        if row - 1 >= 0 {
            let newPosition: (Int, Int) = (row - 1, column)
            let topPonintColor = image[newPosition.0][newPosition.1]
            if topPonintColor == currentPointColor {
                resultImage[newPosition.0][newPosition.1] = newColor
            }
        }
        
        if row + 1 <= image.count - 1 {
            let newPosition: (Int, Int) = (row + 1, column)
            let bottomPonintColor = image[newPosition.0][newPosition.1]
            if bottomPonintColor == currentPointColor {
                resultImage[newPosition.0][newPosition.1] = newColor
            }
        }
        
        if column - 1 >= 0 {
            let newPosition: (Int, Int) = (row, column - 1)
            let leftPonintColor = image[newPosition.0][newPosition.1]
            if leftPonintColor == currentPointColor {
                resultImage[newPosition.0][newPosition.1] = newColor
            }
        }
        
        if column + 1 <= image[row].count - 1 {
            let newPosition: (Int, Int) = (row, column + 1)
            let rightPonintColor = image[newPosition.0][newPosition.1]
            if rightPonintColor == currentPointColor {
                resultImage[newPosition.0][newPosition.1] = newColor
            }
        }
        
        resultImage[row][column] = newColor
        return resultImage
    }
}

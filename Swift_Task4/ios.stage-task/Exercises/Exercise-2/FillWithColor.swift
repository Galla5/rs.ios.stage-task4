import Foundation

final class FillWithColor {
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        var resultImage = image
        let currectColor = image[row][column]
        let allPoints = getAllPoints(image, row, column)
        for point in allPoints {
            resultImage = fillPointPixels(resultImage, point.0, point.1, newColor, currectColor)
        }
        
        return resultImage
    }
    
    private func getAllPoints(_ image: [[Int]], _ row: Int, _ column: Int) -> [(Int, Int)] {
        var allPoints = [(Int, Int)]()
        let startPoint = (row, column)
        allPoints.append(startPoint)
        let firstDirectionalyPoints = getDirectionallyPoints(image, point: (row, column))
        allPoints.append(contentsOf: firstDirectionalyPoints)
        for dicPoint in firstDirectionalyPoints {
            let secondPoints = getDirectionallyPoints(image, point: dicPoint)
            allPoints.append(contentsOf: secondPoints)
        }
        return allPoints
    }
    
    private func getDirectionallyPoints(_ image: [[Int]], point: (Int, Int)) -> [(Int, Int)] {
        var points = [(Int, Int)]()
        
        if point.0 - 1 >= 0 {
            points.append((point.0 - 1, point.1))
        }
        
        if point.0 + 1 <= image.count - 1 {
            points.append((point.0 + 1, point.1))
        }
        
        if point.1 - 1 >= 0 {
            points.append((point.0, point.1 - 1))
        }
        
        if point.1 + 1 <= image[point.0].count - 1 {
            points.append((point.0, point.1 + 1))
        }
        
        return points
    }
    
    private func fillPointPixels(
        _ image: [[Int]],
        _ row: Int,
        _ column: Int,
        _ newColor: Int,
        _ currentPointColor: Int
    ) -> [[Int]] {
        var resultImage = image
        let pointColor = resultImage[row][column]
        if pointColor == currentPointColor {
            resultImage[row][column] = newColor
        }
        return resultImage
    }
}


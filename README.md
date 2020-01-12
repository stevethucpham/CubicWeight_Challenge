# CubicWeight_Challenge
---
Language: Swift 

This project is a simple application using the given pagination APIs 
`http://wp8m3he1wt.s3-website-ap-southeast-2.amazonaws.com/api/products/1` to calculate the average cubic weight for **"Air Conditioners"** category.

It was built by using **Xcode 11.2**

The project also runs unit testing to test the functions that have used in the project, which can be found in `CubicWeight_ChallengeTests`

## Setup instructions
To install the appication 
* Open **CubicWeight_Challenge.xcodeproj** in the directory `/CubicWeight_Challenge`
* Run the application with Xcode to build the application.

## Solutions 

To calculate the average cubic weight for **"Air Conditioners"** products, the application starts by requesting the list of products from the API. Then the JSON response is decoded into a list of objects. And finally, the application filters the **"Air Conditioners"** products and calculates the average cubic weight based on the size in the JSON response following the given formular.
```
Cubic weight = H x W x L x 250
```

### Request and Deserialize JSON
The `ProductService.swift` has been implemented to call the request deserialize the JSON response into `ResponseObject` instance. To decode the JSON, I have used Swift `Decodable` protocol. The model looks like this
```
struct ResponseObject: Decodable {
    var products: [Product]?
    var next: String?
    
    enum CodingKeys: String, CodingKey {
        case products = "objects"
        case next = "next"
    }
}

struct Product: Decodable {
    var category: String?
    var title: String?
    var weight: Float?
    var size: Size?
}

struct Size: Decodable {
    var width: Float?
    var length: Float?
    var height: Float?
}

```

### Calculate cubic 
To calculate the cubic and the cubic weight, I have create `AirConditionCubicCalculation` class in `CubicCalculation.swift`. The class has two functions 
```
static func calculateCubic(size: Size) -> Float {
    guard let width = size.width, let height = size.height, let length = size.length else {
        return 0.0
    }
    return (width/100 * height/100 * length/100).roundToDecimal(3)
}

static func getCubicWeight(size: Size) -> Float {
       return calculateCubic(size: size) * AirConditionCubicCalculation.conversionFactor
   }
```

### Calculate average cubic weight for Air Conditioner
In the `ProductViewModel.swift`,  I have filtered products that have the category is **"Air Conditioners"** and then calculated the average cubic by using the Swift `Map, Filter ,Reduce` to reduce the complexity for the code. 

```
func calculateACAverageCubicWeight() -> Float {
    if let products = self.products {
        let filterProducts = products.filter { $0.category! == "Air Conditioners" }.map { return AirConditionCubicCalculation.getCubicWeight(size: $0.size!) }
        let average = filterProducts.reduce (Float(0.0)) { (value1, value2) in
            return value1 + value2/Float(filterProducts.count)
        }
        return average.roundToDecimal(3)
    }
    return 0.0
}
```





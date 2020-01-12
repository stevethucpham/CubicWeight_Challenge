# CubicWeight_Challenge
---
Language: Swift 

This project is a simple application using the given pagination APIs 
`http://wp8m3he1wt.s3-website-ap-southeast-2.amazonaws.com/api/products/1` to calculate the average cubic weight for **"Air Conditioners"** category.

It was built by using **Xcode 11.2**

## Setup instructions
To install the appication 
* Open **CubicWeight_Challenge.xcodeproj** in the directory `/CubicWeight_Challenge`
* Run the application with Xcode to build the application.

## Solutions 

To calculate the average cubic weight for **"Air Conditioners"** products, the application starts by requesting the list of products from the API. Then the JSON response is decoded into a list of objects. Next, the application filters the **"Air Conditioners"** products and calculate the cubic weight based on the size in the JSON response following the given formular  
```
Cubic weight = H x W x L x 250
```
Finally, 

### Deserialize


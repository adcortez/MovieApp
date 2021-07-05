//
//  ApiServiceUnitTest.swift
//  MovieAppTests
//
//  Created by Adrián Cortez Hernández on 05/07/21.
//

import XCTest
@testable import MovieApp

class ApiServiceUnitTest: XCTestCase {
    
    
    func test_getMoviesVideoData_with_movieID_ValidReturns_Result_OK() {
        
        let expectation = self.expectation(description: "movieID_ValidReturns_Result_OK")
        
        // ARRANGE
        let resource = ApiService()
        
        // ACT
        resource.getMoviesVideoData(movieId: 508943) { (result) in
            
            //guard let self = self else { return }
            
            switch result {
                case .success(let videos):
                    
                    XCTAssertEqual("YdAIBlPVe9s", videos.movieVideo[0].videoURL!)
                    expectation.fulfill()
                    
                case .failure(let error):
                    print("Error processing json data: \(error)")
            }
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    
    func test_getMoviesVideoData_with_movieID_InValidReturns_Result_Error() {
        
        let expectation = self.expectation(description: "movieID_InValidReturns_Result_Error")
        
        // ARRANGE
        let resource = ApiService()
        
        // ACT
        resource.getMoviesVideoData(movieId: 520763) { (result) in
            
            //guard let self = self else { return }
            
            switch result {
                case .success(let videos):
                    
                    XCTAssertNotEqual("YdAIBlPVe9s", videos.movieVideo[0].videoURL!)
                    expectation.fulfill()
                    
                case .failure(let error):
                    print("Error processing json data: \(error)")
            }
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
    }
}

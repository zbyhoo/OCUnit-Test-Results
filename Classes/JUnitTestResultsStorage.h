//
//  JUnitTestResultsStorage.h
//  OCUnitToJUnit
//
//  Created by Zbigniew Kominek on 8/23/11.
//  Copyright 2011 zbyhoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestResultsStorageDelegate.h"

@class GDataXMLElement;

@interface JUnitTestResultsStorage : NSObject <TestResultsStorageDelegate>
{
@private
    GDataXMLElement*    testSuitesElement;
    GDataXMLElement*    currentTestSuiteElement;
    GDataXMLElement*    currentTestCaseElement;
}

- (void) storeTestResults;

@end

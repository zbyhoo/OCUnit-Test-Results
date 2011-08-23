//
//  TestResultsStorageDelegate.h
//  OCUnitToJUnit
//
//  Created by Zbigniew Kominek on 8/23/11.
//  Copyright 2011 zbyhoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SenTest;

@protocol TestResultsStorageDelegate <NSObject>

@required

- (void) testSuiteStarted:(SenTest*)senTest;
- (void) testSuiteEnded:(SenTest*)senTest;
- (void) testCaseStarted:(SenTest*)senTest;
- (void) testCaseEnded:(SenTest*)senTest;
- (void) testCaseFailed:(SenTest*)senTest withException:(NSException*)exception;

@end

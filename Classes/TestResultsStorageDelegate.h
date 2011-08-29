//
//  TestResultsStorageDelegate.h
//  OCUnitToJUnit
//
//  Created by Zbigniew Kominek on 8/23/11.
//  Copyright 2011 zbyhoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DetailedSenTest;

@protocol TestResultsStorageDelegate <NSObject>

@required

- (void) testSuiteStarted:(DetailedSenTest*)senTest;
- (void) testSuiteEnded:(DetailedSenTest*)senTest;
- (void) testCaseStarted:(DetailedSenTest*)senTest;
- (void) testCaseEnded:(DetailedSenTest*)senTest;
- (void) testCaseFailed:(DetailedSenTest*)senTest withException:(NSException*)exception;

@end

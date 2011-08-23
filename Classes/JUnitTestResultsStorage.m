//
//  JUnitTestResultsStorage.m
//  OCUnitToJUnit
//
//  Created by Zbigniew Kominek on 8/23/11.
//  Copyright 2011 zbyhoo. All rights reserved.
//

#import "JUnitTestResultsStorage.h"
#import <SenTestingKit/SenTest.h>

@implementation JUnitTestResultsStorage

- (void) testSuiteStarted:(SenTest*)senTest
{
    NSLog(@"test suite %@ started", senTest.name);
}

- (void) testSuiteEnded:(SenTest*)senTest
{
    NSLog(@"test suite %@ ended", senTest.name);
}

- (void) testCaseStarted:(SenTest*)senTest
{
    NSLog(@"test case started");
}

- (void) testCaseEnded:(SenTest*)senTest
{
    NSLog(@"test case ended");
}

- (void) testCaseFailed:(SenTest*)senTest withException:(NSException*)exception
{
    NSLog(@"test case failed");
}

@end

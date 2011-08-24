//
//  JUnitTestResultsStorage.m
//  OCUnitToJUnit
//
//  Created by Zbigniew Kominek on 8/23/11.
//  Copyright 2011 zbyhoo. All rights reserved.
//

#import "JUnitTestResultsStorage.h"
#import "GDataXMLNode.h"

#import <SenTestingKit/SenTest.h>

NSString* const TAG_TEST_SUITES         = @"testsuites";
NSString* const TAG_TEST_SUITE          = @"testsuite";
NSString* const TAG_TEST_CASE           = @"testcase";
NSString* const TAG_TEST_CASE_FAILURE   = @"failed";

NSString* const DATA_FILE_NAME          = @"testresult.xml";

@implementation JUnitTestResultsStorage

- (id) init
{
    self = [super init];
    if (self)
    {
        testSuitesElement = [[GDataXMLNode elementWithName:TAG_TEST_SUITES] retain];
    }
    return self;
}

- (void) dealloc
{
    [self storeTestResults];
    [testSuitesElement release];
    [super dealloc];
}

- (void) testSuiteStarted:(SenTest*)senTest
{
    currentTestSuiteElement = [[GDataXMLNode elementWithName:TAG_TEST_SUITE] retain];
}

- (void) testSuiteEnded:(SenTest*)senTest
{
    [testSuitesElement addChild:currentTestSuiteElement];
    [currentTestSuiteElement release];
}

- (void) testCaseStarted:(SenTest*)senTest
{
    currentTestCaseElement = [[GDataXMLNode elementWithName:TAG_TEST_CASE] retain];
}

- (void) testCaseEnded:(SenTest*)senTest
{
    [currentTestSuiteElement addChild:currentTestCaseElement];
    [currentTestCaseElement release];
}

- (void) testCaseFailed:(SenTest*)senTest withException:(NSException*)exception
{
    GDataXMLNode* failureElement = [[GDataXMLNode elementWithName:TAG_TEST_CASE_FAILURE
                                                      stringValue:[exception description]] retain];
    [currentTestCaseElement addChild:failureElement];
    [failureElement release];
}

- (void) storeTestResults
{
    GDataXMLDocument* document = [[GDataXMLDocument alloc] initWithRootElement:testSuitesElement];
    [document.XMLData writeToFile:DATA_FILE_NAME atomically:YES];
    [document release];
}

@end

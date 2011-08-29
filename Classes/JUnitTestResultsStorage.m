//
//  JUnitTestResultsStorage.m
//  OCUnitToJUnit
//
//  Created by Zbigniew Kominek on 8/23/11.
//  Copyright 2011 zbyhoo. All rights reserved.
//

#import "JUnitTestResultsStorage.h"
#import "GDataXMLNode.h"
#import "DetailedSenTest.h"

NSString* const TAG_TEST_SUITES         = @"testsuite";
NSString* const TAG_TEST_SUITE          = @"testsuite";
NSString* const TAG_TEST_CASE           = @"testcase";
NSString* const TAG_TEST_CASE_FAILURE   = @"failed";

NSString* const DATA_FILE_NAME          = @"testresult.xml";

@interface JUnitTestResultsStorage (Private)

- (void) addAttribute:(NSString*)name withValue:(NSString*)value toElement:(GDataXMLElement*)element;

@end

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

- (void) addAttribute:(NSString*)name withValue:(NSString*)value toElement:(GDataXMLElement*)element
{
    id attribute = [[GDataXMLNode attributeWithName:name stringValue:value] retain];
    [element addAttribute:attribute];
    [attribute release];
}

- (void) testSuiteStarted:(DetailedSenTest*)senTest
{
    currentTestSuiteElement = [[GDataXMLNode elementWithName:TAG_TEST_SUITE] retain];
    [self addAttribute:@"name" withValue:senTest.name toElement:currentTestSuiteElement];
}

- (void) testSuiteEnded:(DetailedSenTest*)senTest
{
    if (currentTestSuiteElement)
    {
        [self addAttribute:@"time" withValue:[senTest durationInSec] toElement:currentTestSuiteElement];
        
        [testSuitesElement addChild:currentTestSuiteElement];
        [currentTestSuiteElement release];
        currentTestSuiteElement = nil;
    }
}

- (void) testCaseStarted:(DetailedSenTest*)senTest
{
    currentTestCaseElement = [[GDataXMLNode elementWithName:TAG_TEST_CASE] retain];
    [self addAttribute:@"name" withValue:senTest.name toElement:currentTestCaseElement];
}

- (void) testCaseEnded:(DetailedSenTest*)senTest
{
    [self addAttribute:@"time" withValue:[senTest durationInSec] toElement:currentTestCaseElement];
    [currentTestSuiteElement addChild:currentTestCaseElement];
    [currentTestCaseElement release];
}

- (void) testCaseFailed:(DetailedSenTest*)senTest withException:(NSException*)exception
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

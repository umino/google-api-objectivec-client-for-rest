/* Copyright (c) 2011 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <XCTest/XCTest.h>

#if SWIFT_PACKAGE
@import GoogleAPIClientForRESTCore;
#else
#import "GTLRFramework.h"
#endif

@interface GTLRFrameworkTest : XCTestCase
@end

@implementation GTLRFrameworkTest

- (void)testFrameworkVersion {
  NSUInteger major = NSUIntegerMax;
  NSUInteger minor = NSUIntegerMax;
  NSUInteger release = NSUIntegerMax;

  GTLRFrameworkVersion(&major, &minor, &release);

  XCTAssertTrue(major != NSUIntegerMax, @"version unset");
  XCTAssertTrue(minor != NSUIntegerMax, @"version unset");
  XCTAssertTrue(release != NSUIntegerMax, @"version unset");
// It is not currently possible to specify the bundle version from `Package.swift`
#if !SWIFT_PACKAGE
  // Check that the Framework bundle's Info.plist has the proper version,
  // matching the GTLRFrameworkVersion call
  NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
  NSDictionary *infoDict = [testBundle infoDictionary];
  XCTAssertNotNil(infoDict, @"Could not find GTLRFramework-Info.plist at %@", testBundle);

  if (infoDict) {
    NSString *binaryVersionStr = GTLRFrameworkVersionString();
    NSString *plistVersionStr = [infoDict valueForKey:@"CFBundleVersion"];

    XCTAssertEqualObjects(binaryVersionStr, plistVersionStr);
  }
#endif
}

@end

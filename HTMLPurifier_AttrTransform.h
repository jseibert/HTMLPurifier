//
//  HTMLPurifier_AttrTransform.h
//  HTMLPurifier
//
//  Created by Roman Priebe on 18.01.14.
//  Copyright (c) 2014 Mynigma. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTMLPurifier_Config, HTMLPurifier_Context;

@interface HTMLPurifier_AttrTransform : NSObject


- (NSDictionary*)transform:(NSDictionary*)attr sortedKeys:(NSMutableArray*)sortedKeys config:(HTMLPurifier_Config*)config context:(HTMLPurifier_Context*)context;

- (void)prependCSS:(NSMutableDictionary*)attr sortedKeys:(NSMutableArray*)sortedKeys css:(NSString*)css;

- (NSObject*)confiscateAttr:(NSMutableDictionary*)attr sortedKeys:(NSMutableArray*)sortedKeys key:(NSString*)key;

@end

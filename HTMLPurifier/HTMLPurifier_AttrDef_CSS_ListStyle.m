//
//  HTMLPurifier_AttrDef_CSS_ListStyle.m
//  HTMLPurifier
//
//  Created by Roman Priebe on 11.01.14.
//  Copyright (c) 2014 Mynigma. All rights reserved.
//

#import "HTMLPurifier_AttrDef_CSS_ListStyle.h"
#import "HTMLPurifier_CSSDefinition.h"
#import "BasicPHP.h"

@implementation HTMLPurifier_AttrDef_CSS_ListStyle

    /**
     * @param HTMLPurifier_Config $config
     */
- (id)initWithConfig:(HTMLPurifier_Config*)config
{
    self = [super init];
    if (self) {
        HTMLPurifier_CSSDefinition* def = [config getCSSDefinition];
        [self->info setObject:[[def info] objectForKey:@"list-style-type"] forKey:@"list-style-type"];
        [self->info setObject:[[def info] objectForKey:@"list-style-position"] forKey:@"list-style-position"];
        [self->info setObject:[[def info] objectForKey:@"list-style-image"] forKey:@"list-style-image"];
    }
    return self;
}

    /**
     * @param string $string
     * @param HTMLPurifier_Config $config
     * @param HTMLPurifier_Context $context
     * @return bool|string
     */
- (NSString*)validateWithString:(NSString *)string config:(HTMLPurifier_Config *)config context:(HTMLPurifier_Context *)context
    {
        // regular pre-processing
        string = [self parseCDATAWithString:string];
        if ([string isEqualTo:@""]) {
            return nil;
        }

        // assumes URI doesn't have spaces in it
        NSArray* bits = explode(@" ", [string lowercaseString]); // bits to process

        NSMutableDictionary* caught = [NSMutableDictionary new];
        [caught setObject:@NO forKey:@"type"];
        [caught setObject:@NO forKey:@"position"];
        [caught setObject:@NO forKey:@"image"];

        NSInteger i = 0; // number of catches
        BOOL none = NO;

        for(NSString* bit in bits)
        {
            if (i >= 3)
            {
                return [NSNull null];
            } // optimization bit
            if ([bit isEqualTo:@""]) {
                continue;
            }
            for(NSString* key in caught)
            {
                //pointless...
                if (![caught objectForKey:key])
                {
                    continue;
                }
                NSString* r = [[self->info objectForKey:[@"list-style-" stringByAppendingString:key]] validateWithString:bit config:config context:context];

                if (!r)
                {
                    continue;
                }
                if ([r isEqualTo:@"none"]) {
                    if (none) {
                        continue;
                    } else {
                        none = YES;
                    }
                    if ([key isEqualTo:@"image"]) {
                        continue;
                    }
                }
                [caught setObject:r forKey:key];
                i++;
                break;
            }
        }

        if (i==0)
        {
            return nil;
        }

        NSMutableArray* ret = [NSMutableArray new];

        // construct type
        if ([caught objectForKey:@"type"])
        {
            [ret addObject:[caught objectForKey:@"type"]];
        }

        // construct image
        if ([caught objectForKey:@"image"])
        {
            [ret addObject:[caught objectForKey:@"image"]];
        }

        // construct position
        if ([caught objectForKey:@"position"])
        {
            [ret addObject:[caught objectForKey:@"position"]];
        }

        if (ret.count==0) {
            return nil;
        }
        return implode(@" ", ret);
    }


@end

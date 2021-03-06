//
//   HTMLPurifier_HTMLModule_Image.m
//   HTMLPurifier
//
//  Created by Roman Priebe on 18.01.14.


#import "HTMLPurifier_HTMLModule_Image.h"
#import "../Config & Context/HTMLPurifier_Config.h"
#import "../ChildDef & ElementDef/HTMLPurifier_ElementDef.h"
#import "../Attributes/AttrDef/HTMLPurifier_AttrDef_URI.h"
#import "../Attributes/AttrTransform/HTMLPurifier_AttrTransform_ImgRequired.h"
#import "../Attributes/AttrTransform/HTMLPurifier_AttrTransform_ImgTrackingRemoval.h"

@implementation HTMLPurifier_HTMLModule_Image


- (id)initWithConfig:(HTMLPurifier_Config*)config
{
    self = [super initWithConfig:config];
    if (self) {
        self.name = @"Image";
        NSNumber* max = (NSNumber*)[config get:@"HTML.MaxImgLength"];
        HTMLPurifier_ElementDef* img = [self addElement:@"img" type:@"Inline" contents:@"Empty" attrIncludes:@"Common" attr:@{@"alt*":@"Text", @"height":[NSString stringWithFormat:@"Pixels#%@", max?max:@"1200"], @"width":[NSString stringWithFormat:@"Pixels#%@", max?max:@"1200"], @"longdesc":@"URI", @"src*":[[HTMLPurifier_AttrDef_URI alloc] initWithNumber:@YES]}];

        HTMLPurifier_AttrTransform_ImgRequired* transform = [HTMLPurifier_AttrTransform_ImgRequired new];
        NSString* newKey = [NSString stringWithFormat:@"%ld", (unsigned long)img.attr_transform_post.count];
        if (transform && newKey)
            [img.attr_transform_post setObject:transform forKey:newKey];
        newKey = [NSString stringWithFormat:@"%ld", (unsigned long)img.attr_transform_pre.count];
        if (transform && newKey)
            [img.attr_transform_pre setObject:transform forKey:newKey];
        
        HTMLPurifier_AttrTransform_ImgTrackingRemoval* imgTrackTransform = [HTMLPurifier_AttrTransform_ImgTrackingRemoval new];
        newKey = [NSString stringWithFormat:@"%ld", (unsigned long)img.attr_transform_post.count];
        if (transform && newKey)
            [img.attr_transform_post setObject:imgTrackTransform forKey:newKey];
    }
    return self;
}



@end

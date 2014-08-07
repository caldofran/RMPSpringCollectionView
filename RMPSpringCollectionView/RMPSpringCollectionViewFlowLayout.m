//
//  RMPSpringCollectionViewFlowLayout.m
//  RMPSpringCollectionView
//
//  Created by Ruben on 07/08/14.
//  Copyright (c) 2014 Caldofran. All rights reserved.
//

#import "RMPSpringCollectionViewFlowLayout.h"

@interface RMPSpringCollectionViewFlowLayout ()
@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@end

@implementation RMPSpringCollectionViewFlowLayout
- (id)init
{
    if (!(self = [super init])) return nil;
    
    self.minimumInteritemSpacing = 10;
    self.minimumLineSpacing = 10;
    self.itemSize = CGSizeMake(44, 44);
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
    
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    // Get all items. Very naïve approach
    CGSize contentSize = self.collectionView.contentSize;
    NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0.0f, 0.0f, contentSize.width, contentSize.height)];
    
    // Add to all of them a behaviour
    if (self.dynamicAnimator.behaviors.count == 0) {
        [items enumerateObjectsUsingBlock:^(id<UIDynamicItem> obj, NSUInteger idx, BOOL *stop) {
            UIAttachmentBehavior *behaviour = [[UIAttachmentBehavior alloc] initWithItem:obj attachedToAnchor:[obj center]];
            
            behaviour.length = 0.0f;
            behaviour.damping = 0.8f;
            behaviour.frequency = 1.0f;
            
            [self.dynamicAnimator addBehavior:behaviour];
        }];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [self.dynamicAnimator itemsInRect:rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
}

@end

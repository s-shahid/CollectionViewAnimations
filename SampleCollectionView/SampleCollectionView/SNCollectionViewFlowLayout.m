//
//  SNCollectionViewFlowLayout.m
//  SampleCollectionView
//
//  Created by shahid on 27/08/14.
//  Copyright (c) 2014 SourceN. All rights reserved.
//

#import "SNCollectionViewFlowLayout.h"

@implementation SNCollectionViewFlowLayout


// These layout attributes are applied to a cell that is "appearing" and will be eased into the nominal layout attributes for that cell
// Cells "appear" in several cases:
//  - Inserted explicitly or via a section insert
//  - Moved as a result of an insert at a lower index path
//  - Result of an animated bounds change repositioning cells
- (UICollectionViewLayoutAttributes*)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
    return attributes;
}

// These layout attributes are applied to a cell that is "disappearing" and will be eased to from the nominal layout attribues prior to disappearing
// Cells "disappear" in several cases:
//  - Removed explicitly or via a section removal
//  - Moved as a result of a removal at a lower index path
//  - Result of an animated bounds change repositioning cells
- (UICollectionViewLayoutAttributes*)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attributes = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];    
    CATransform3D transform = CATransform3DMakeTranslation(0, self.collectionView.bounds.size.height, 0);
    transform = CATransform3DRotate(transform, M_PI*0.2, 0, 0, 1);
    attributes.transform3D = transform;
    attributes.alpha = 0.0f;
    return attributes;
}


@end

#import "LineView.h"

@implementation LineView

- (void) reset {
    [pointPairs removeAllObjects];
}

- (void) drawRect:(CGRect)rect {
    // draw lines
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(c, [[UIColor lightGrayColor] CGColor]);
    CGContextSetLineWidth(c, 1.f);
    
    for(NSArray *pair in [pointPairs allValues]){
        CGPoint first, second;

        [(NSValue *)[pair objectAtIndex:0] getValue:&first];
        [(NSValue *)[pair objectAtIndex:1] getValue:&second];
        
        CGContextBeginPath(c);
        
        CGContextMoveToPoint(c, first.x, first.y);
        CGContextAddLineToPoint(c, second.x, second.y);
        
        CGContextStrokePath(c);
        
        CGContextAddEllipseInRect(c, CGRectMake(first.x-2, first.y-2, 4, 4));
        CGContextAddEllipseInRect(c, CGRectMake(second.x-2, second.y-2, 4, 4));
        
        CGContextSetFillColorWithColor(c, [UIColor lightGrayColor].CGColor);
        CGContextFillPath(c);
        
        
    }
}

- (void) addPointPair:(CGPoint)first second:(CGPoint)second forLabel:(UILabel*)label {
    if(pointPairs == nil)
        pointPairs = [[NSMutableDictionary alloc] init];
    
    NSValue *firstValue, *secondValue;
    
    firstValue  = [NSValue valueWithCGPoint:first];
    secondValue = [NSValue valueWithCGPoint:second];
    
    // Generate a key from the label
    NSValue *labelKey = [NSValue valueWithNonretainedObject:label];
    
    // If we already have a line for this label, update it.  Otherwise add a new line to the view
    NSMutableArray *existingPair = [pointPairs objectForKey:labelKey];
    if (!existingPair)  {
        NSMutableArray *pair = [NSMutableArray arrayWithObjects:firstValue, secondValue, nil];
        [pointPairs setObject:pair forKey:labelKey];
    }
    else    {
        [existingPair replaceObjectAtIndex:0 withObject:firstValue];
        [existingPair replaceObjectAtIndex:1 withObject:secondValue];
    }
    
    [self setNeedsDisplay];
}

@end
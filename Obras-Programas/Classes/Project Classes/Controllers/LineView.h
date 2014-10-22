@interface LineView : UIView {
    NSMutableDictionary *pointPairs;
}

- (void) addPointPair:(CGPoint)first second:(CGPoint)second forLabel:(UILabel*)label;
- (void) reset;

@end
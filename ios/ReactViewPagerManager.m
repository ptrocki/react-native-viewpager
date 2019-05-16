
#import "ReactViewPagerManager.h"

@implementation ReactViewPagerManager

#pragma mark - RTC

RCT_EXPORT_MODULE(RNCViewPager)

RCT_EXPORT_VIEW_PROPERTY(initialPage, NSInteger)
RCT_EXPORT_VIEW_PROPERTY(pageMargin, NSInteger)

RCT_EXPORT_VIEW_PROPERTY(transitionStyle, UIPageViewControllerTransitionStyle)
RCT_EXPORT_VIEW_PROPERTY(orientation, UIPageViewControllerNavigationOrientation)

RCT_CUSTOM_VIEW_PROPERTY(scrollEnabled, BOOL, ReactNativePageView){
    view.scrollEnabled = [RCTConvert BOOL:json];
}

- (UIView *)view {
    if(_reactNativePageView){
        return _reactNativePageView;
    }
    _reactNativePageView = [[ReactNativePageView alloc] init];
    _reactNativePageView.dataSource = self;
    return _reactNativePageView;
}



#pragma mark - Datasource After

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
        
    NSMutableArray<UIViewController *> *childrenViewControllers = [_reactNativePageView childrenViewControllers];
    NSUInteger index = [childrenViewControllers indexOfObject:viewController];
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [childrenViewControllers count]) {
        return nil;
    }

    return [childrenViewControllers objectAtIndex:index];
    
}

#pragma mark - Datasource Before

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSMutableArray<UIViewController *> *childrenViewControllers = [_reactNativePageView childrenViewControllers];
    NSUInteger index = [childrenViewControllers indexOfObject:viewController];
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    return [childrenViewControllers objectAtIndex:index];
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [[_reactNativePageView childrenViewControllers] count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
   return ((ReactNativePageView *)[self view]).initialPage;
}

@end

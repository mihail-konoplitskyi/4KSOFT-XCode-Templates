//
//  ___FILEHEADER___
//

import Foundation
import UIKit

enum CarouselFlowLayoutSpacingMode {
    case fixed(spacing: CGFloat)
    case overlap(visibleOffset: CGFloat)
}

enum CarouselFlowLayoutAnimation {
    case rotation(sideItemAngle: CGFloat, sideItemAlpha: CGFloat, sideItemShift: CGFloat)
    case scale(sideItemScale: CGFloat, sideItemAlpha: CGFloat, sideItemShift: CGFloat)
}

class CarouselFlowLayout: UICollectionViewFlowLayout {
    fileprivate struct LayoutState {
        var size: CGSize
        var direction: UICollectionView.ScrollDirection
        
        func isEqual(_ otherState: LayoutState) -> Bool {
            return self.size.equalTo(otherState.size) && self.direction == otherState.direction
        }
    }
    
    fileprivate var state = LayoutState(size: CGSize.zero, direction: .horizontal)
    var spacingMode = CarouselFlowLayoutSpacingMode.fixed(spacing: 0)
    var animationMode = CarouselFlowLayoutAnimation.scale(sideItemScale: 0.7, sideItemAlpha: 0.6, sideItemShift: 0.0)
    
    fileprivate var pageWidth: CGFloat {
        switch self.scrollDirection {
        case .horizontal:
            return self.itemSize.width + self.minimumLineSpacing
        case .vertical:
            return self.itemSize.height + self.minimumLineSpacing
        @unknown default:
            return 0
        }
    }
    
    /// Calculates the current centered page.
    var currentCenteredIndexPath: IndexPath? {
        guard let collectionView = self.collectionView else { return nil }
        let currentCenteredPoint = CGPoint(x: collectionView.contentOffset.x + collectionView.bounds.width/2, y: collectionView.contentOffset.y + collectionView.bounds.height/2)
        return collectionView.indexPathForItem(at: currentCenteredPoint)
    }
    
    var currentCenteredPage: Int? {
        return currentCenteredIndexPath?.row
    }
    
    override func prepare() {
        super.prepare()
        guard let collectionView = self.collectionView else { return }
        let currentState = LayoutState(size: collectionView.bounds.size, direction: self.scrollDirection)
        
        if !self.state.isEqual(currentState) {
            self.setupCollectionView()
            self.updateLayout()
            self.state = currentState
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
              let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes]
        else { return nil }
        return attributes.map({ self.transformLayoutAttributes($0) })
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView , !collectionView.isPagingEnabled,
              let layoutAttributes = self.layoutAttributesForElements(in: collectionView.bounds)
        else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset) }
        
        let isHorizontal = (self.scrollDirection == .horizontal)
        
        let midSide = (isHorizontal ? collectionView.bounds.size.width : collectionView.bounds.size.height) / 2
        let proposedCenterOffset = (isHorizontal ? proposedContentOffset.x : proposedContentOffset.y) + midSide
        
        var targetContentOffset: CGPoint
        if isHorizontal {
            let closest = layoutAttributes.sorted { abs($0.center.x - proposedCenterOffset) < abs($1.center.x - proposedCenterOffset) }.first ?? UICollectionViewLayoutAttributes()
            targetContentOffset = CGPoint(x: floor(closest.center.x - midSide), y: proposedContentOffset.y)
        }
        else {
            let closest = layoutAttributes.sorted { abs($0.center.y - proposedCenterOffset) < abs($1.center.y - proposedCenterOffset) }.first ?? UICollectionViewLayoutAttributes()
            targetContentOffset = CGPoint(x: proposedContentOffset.x, y: floor(closest.center.y - midSide))
        }
        
        return targetContentOffset
    }
    
    /// Programmatically scrolls to a page at a specified index.
    ///
    /// - Parameters:
    ///   - index: The index of the page to scroll to.
    ///   - animated: Whether the scroll should be performed animated.
    func scrollToPage(atIndex index: Int, animated: Bool = true) {
        guard let collectionView = self.collectionView else { return }
        
        let proposedContentOffset: CGPoint
        let shouldAnimate: Bool
        
        switch scrollDirection {
        case .horizontal:
            let pageOffset = CGFloat(index) * self.pageWidth - collectionView.contentInset.left
            proposedContentOffset = CGPoint(x: pageOffset, y: collectionView.contentOffset.y)
            shouldAnimate = abs(collectionView.contentOffset.x - pageOffset) > 1 ? animated : false
            break
        case .vertical:
            let pageOffset = CGFloat(index) * self.pageWidth - collectionView.contentInset.top
            proposedContentOffset = CGPoint(x: collectionView.contentOffset.x, y: pageOffset)
            shouldAnimate = abs(collectionView.contentOffset.y - pageOffset) > 1 ? animated : false
            break
        @unknown default:
            proposedContentOffset = .zero
            shouldAnimate = false
            break
        }
        
        collectionView.setContentOffset(proposedContentOffset, animated: shouldAnimate)
    }
}

// MARK: - Private Methods
private extension CarouselFlowLayout {
    func setupCollectionView() {
        guard let collectionView = self.collectionView else { return }
        if collectionView.decelerationRate != UIScrollView.DecelerationRate.fast {
            collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        }
    }
    func updateLayout() {
        guard let collectionView = self.collectionView else { return }
        
        let collectionSize = collectionView.bounds.size
        let isHorizontal = (self.scrollDirection == .horizontal)
        
        let yInset = (collectionSize.height - self.itemSize.height) / 2
        let xInset = (collectionSize.width - self.itemSize.width) / 2
        self.sectionInset = UIEdgeInsets.init(top: yInset, left: xInset, bottom: yInset, right: xInset)
        
        let side = isHorizontal ? self.itemSize.width : self.itemSize.height
        var scale: CGFloat = 1.0
        switch animationMode {
        case .scale(let sideItemScale, _, _):
            scale = sideItemScale
            break
        default:
            break
        }
        
        let scaledItemOffset =  (side - side * scale) / 2
        
        switch self.spacingMode {
        case .fixed(let spacing):
            self.minimumLineSpacing = spacing - scaledItemOffset
        case .overlap(let visibleOffset):
            let fullSizeSideItemOverlap = visibleOffset + scaledItemOffset
            let inset = isHorizontal ? xInset : yInset
            self.minimumLineSpacing = inset - fullSizeSideItemOverlap
        }
    }
    func transformLayoutAttributes(_ attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attributes }
        
        let isHorizontal = (self.scrollDirection == .horizontal)
        let collectionCenter: CGFloat = isHorizontal ? collectionView.frame.size.width/2 : collectionView.frame.size.height/2
        let offset = isHorizontal ? collectionView.contentOffset.x : collectionView.contentOffset.y
        let normalizedCenter = (isHorizontal ? attributes.center.x : attributes.center.y) - offset
        let maxDistance = (isHorizontal ? self.itemSize.width : self.itemSize.height) + self.minimumLineSpacing
        let distance = min(abs(collectionCenter - normalizedCenter), maxDistance)
        let ratio = (maxDistance - distance)/maxDistance
        var sideItemShift: CGFloat = 0.0
        
        switch animationMode {
        case .rotation(let sideItemAngle, let sideItemAlpha, let shift):
            sideItemShift = shift
            let alpha = ratio * (1 - sideItemAlpha) + sideItemAlpha
            attributes.alpha = alpha
            var offsetX =  (collectionCenter + offset) - (normalizedCenter + offset)
            if offsetX < 0 {
                offsetX *= -1
            }
            if offsetX > 0 {
                let offsetPercentage = offsetX / (collectionCenter * 2)
                let rotation = (1 - offsetPercentage) - sideItemAngle
                attributes.transform = CGAffineTransform(rotationAngle: rotation)
            }
            break
        case .scale(let sideItemScale, let sideItemAlpha, let shift):
            sideItemShift = shift
            
            let alpha = ratio * (1 - sideItemAlpha) + sideItemAlpha
            let scale = ratio * (1 - sideItemScale) + sideItemScale
            attributes.alpha = alpha
            attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
            
            // If side Item alpha 1 then manage zindex based on a scale
            if sideItemAlpha == 1 {
                attributes.zIndex = Int(scale * 10)
            }else {
                attributes.zIndex = Int(alpha * 10)
            }
            
            break
        }
        let shift = (1 - ratio) * sideItemShift
        
        if isHorizontal {
            attributes.center.y = attributes.center.y + shift
        } else {
            attributes.center.x = attributes.center.x + shift
        }
        
        return attributes
    }
}

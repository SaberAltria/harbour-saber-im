// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.0
import Sailfish.Silica 1.0

QtObject {
    // FIXME: need different scale ratio for landscape in case aspect ratio changes, now assuming 16:9
    property real scaleRatio: screen.width / 480

    property int keyboardWidthLandscape: screen.height
    property int keyboardWidthPortrait: screen.width

    property int keyWidthLandscape: 85*scaleRatio
    property int keyHeightLandscape: 58*scaleRatio
    property int keyWidthPortrait: 48*scaleRatio
    property int keyHeightPortrait: 80*scaleRatio
    property int keyRadius: 4*scaleRatio

    property int functionKeyWidthLandscape: 145*scaleRatio
    property int shiftKeyWidthLandscape: 110*scaleRatio
    property int shiftKeyWidthLandscapeNarrow: 98*scaleRatio
    property int spacebarKeyWidthLandscape: keyboardWidthLandscape - 2*functionKeyWidthLandscape - 2*punctuationKeyLandscape
    property int punctuationKeyLandscape: 120*scaleRatio
    property int punctuationKeyLandscapeNarrow: 80*scaleRatio
    property int symbolKeyWidthLandscapeNarrow: 145*scaleRatio

    property int functionKeyWidthPortrait: 116*scaleRatio
    property int shiftKeyWidthPortrait: 72*scaleRatio
    property int shiftKeyWidthPortraitNarrow: 60*scaleRatio
    property int spacebarKeyWidthPortrait: 136*scaleRatio
    property int punctuationKeyPortait: 56*scaleRatio
    property int punctuationKeyPortraitNarrow: 43*scaleRatio // 3*narrow + symbol narrow == 2*non-narrow + function key
    property int symbolKeyWidthPortraitNarrow: 99*scaleRatio

    property int popperHeight: 120*scaleRatio
    property int popperWidth: 80*scaleRatio
    property int popperRadius: 10*scaleRatio
    property int popperFontSize: 56*scaleRatio
    property int popperMargin: 2

    property int clearPasteMargin: 50*scaleRatio
    property int clearPasteTouchDelta: 20*scaleRatio

    property int accentPopperCellWidth: 47*scaleRatio
    property int accentPopperMargin: (popperWidth-accentPopperCellWidth) * .5 - 1

    property int languageSelectionTouchDelta: 35*scaleRatio
    property int languageSelectionInitialDeltaSquared: 20*20*scaleRatio
    property int languageSelectionMargin: 10*scaleRatio
    property int languageSelectionCellMargin: 15*scaleRatio
    property int languageSelectionPopupRowMargin: 120*scaleRatio

    property int hwrLineWidth: 7*scaleRatio
    property int hwrCanvasHeight: 300*scaleRatio
    property int hwrSampleThresholdSquared: 4*4*scaleRatio
    property int hwrSpacebarKeyWidthPortrait: 174*scaleRatio
    property int hwrPastePreviewWidth: 100*scaleRatio
}

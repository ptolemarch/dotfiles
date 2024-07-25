{-# OPTIONS_GHC -Wno-deprecations #-}

-- these two are taken from XMonad.Layout.CenteredIfSingle (in xmonad-contrib)
-- and used to try to make my own LeftIfSingle
-- no idea what they do. Cargo culting them right in here.
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeSynonymInstances  #-}

-- TODO:

-- https://github.com/bchurchill/xmonad-pulsevolume

-- xmobar
-- gutters between/around windows
-- keys:
--   Super-F: switch to a Firefox window. If none, open Firefox
--   : lock screen
--   : switch this app's audio output(/input)
--   : audio
--     : louder/quieter/mute globally
--     : louder/quieter/mute this app
--     : different input/output per-app
--   : screenshots
--     : whole screen
--     : single window
--     : single monitor
--     : selected region
--   : clipboard
--     : history
--     : input shortcuts
--   : refresh displays
--   : (toggle mirroring)
--   : xprop
-- all screens switch as one ?
-- show what I have on all spaces
-- urgency?
-- make float
--  : feh
--  : xmonad's error display
-- xcolor + display of result
--   - maybe in xmobar, even?

-- signal-desktop
-- signal-cli dbus

-- larger/smaller master gotta be different from mod-L and mod-H, respectively
-- different monitors put main in different places
--  in fact, different monitors just have different layouts

-- mod + mousewheel = raise/lower window (reorder if not floating)

import qualified Debug.Trace as D (trace)

import XMonad

-- these two cargo culted from CenteredIfSingle
import XMonad.Layout.LayoutModifier
import XMonad.Prelude (fi)

import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Layout.ThreeColumns
import XMonad.Layout.NoBorders

import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops

import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Util.Loggers

import XMonad.Layout.Renamed

import XMonad.Layout.Spacing
import XMonad.Layout.Reflect


-- for multiple xmobars, e.g. one per screen:
-- https://hackage.haskell.org/package/xmonad-contrib-0.18.0/docs/XMonad-Hooks-StatusBar.html#g:3

main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
--     . withEasySB (statusBarProp "xmobar -v -D 287 ~/.xmonad/xmobarrc" (pure myXmobarPP)) toggleStrutsKey
     . withEasySB (statusBarProp "xmobar -x 0 -v -D 287 ~/.xmonad/xmobar.hs" (pure myXmobarPP)) toggleStrutsKey
     $ myConfig

myManageHook :: ManageHook
myManageHook = composeAll
    [
      className =? "Gimp"    --> doFloat
    , className =? "Xdialog" --> doFloat
    , className =? "Alert"   --> doFloat
    , isDialog               --> doFloat
    , isNotification         --> doFloat
    ]

-- | A predicate to check whether a window is a dialog.
isNotification :: Query Bool
isNotification = isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_NOTIFICATION"

myConfig = def
    {
        terminal = "kitty",
        modMask = mod4Mask,  -- Super key
        layoutHook = myLayout,
        manageHook = myManageHook
    }
    `additionalKeysP`
    [
        ("M-S-z", spawn "xscreensaver-command -lock"),
        ("M-C-s", unGrab *> spawn "scrot -s"),
        ("M-\\", spawn "firefox"),
        ("M-p", spawn "gimp")
    ]

myLayout = (spacingWithEdge 16 $ lessBorders Screen $ 
        named "R3C" (reflectHoriz (leftIfSingle 0.5 1.0 $    ThreeCol nmain resize ratio))
    ||| named "T"   (leftIfSingle 0.5 1.0 $        Tall nmain resize ratio)
    ||| named "/T"  (leftIfSingle 0.5 1.0 $ Mirror(Tall nmain resize ratio)))
    ||| named "F"   (noBorders Full)
    where
        nmain  = 1      -- default number of windows in the main
        resize = 3/100  -- fraction of screen to increment when rezising
        ratio  = 1/2    -- default fraction of screen occupied by main

-- Xmobar

toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
toggleStrutsKey XConfig{ modMask = m } = (m, xK_b)

myXmobarPP :: PP
myXmobarPP = def
    {
        ppSep = xmobarColor "#b27fb2" "" $ xmobarFont 1 "  \xf135b  ",
        ppTitleSanitize = xmobarStrip,
        ppCurrent = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2,
        ppVisible = wrap " " "" . xmobarBorder "Top" "Bisque" 2,
        ppHidden = white . wrap " " "",
        ppHiddenNoWindows = lowWhite . wrap " " "",
        ppUrgent = red . wrap (yellow "!") (yellow "!"),
        ppOrder = \[ws, l, _, wins] -> [ws, l, wins],
        ppExtras = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused = wrap (white "[") (white "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue . ppWindow

    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""

-- -----------------------------------------------------------------------------
-- LeftIfSingle
--   modified from
--     https://hackage.haskell.org/package/xmonad-contrib-0.18.0/docs/XMonad-Layout-CenteredIfSingle.html
--     https://hackage.haskell.org/package/xmonad-contrib-0.18.0/docs/src/XMonad.Layout.CenteredIfSingle.html
--
data LeftIfSingle a = LeftIfSingle !Double !Double
    deriving (Show, Read)

instance LayoutModifier LeftIfSingle Window where
    pureModifier (LeftIfSingle ratioX ratioY) r _ [(onlyWindow, _)]
      = ([(onlyWindow, rectangleLeftPiece ratioX ratioY r)], Nothing)
    pureModifier _ _ _ winRects
      = (winRects, Nothing)

leftIfSingle :: Double -> Double -> l a -> ModifiedLayout LeftIfSingle l a
leftIfSingle ratioX ratioY
  = ModifiedLayout (LeftIfSingle ratioX ratioY)

rectangleLeftPiece :: Double -> Double -> Rectangle -> Rectangle
rectangleLeftPiece ratioX ratioY (Rectangle rx ry rw rh)
  = Rectangle startX startY width height
    where
        startX = rx
        startY = ry + top

        width = newWidth rw horizGap
        height = newHeight rh top

        horizGap = newHorizGap rw ratioX
        top = newVertGap rh ratioY

newHeight :: Dimension -> Position -> Dimension
newHeight dim pos = fi $ fi dim - pos * 2

newWidth :: Dimension -> Position -> Dimension
newWidth dim pos = fi $ fi dim - pos

newHorizGap :: Dimension -> Double -> Position
newHorizGap dim ratio = floor $ fi dim * (1.0 - ratio)

newVertGap :: Dimension -> Double -> Position
newVertGap dim ratio = floor $ fi dim * (1.0 - ratio) / 2

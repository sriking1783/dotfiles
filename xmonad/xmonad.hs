import XMonad hiding (Tall) -- use the one in HintedTile
import qualified XMonad.StackSet as W

import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP,removeKeysP,additionalMouseBindings)
import XMonad.Util.Themes
import XMonad.Util.Loggers

import XMonad.Layout.Circle
import XMonad.Layout.LayoutHints
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook

import XMonad.Actions.Volume

import System.Exit
import System.IO
import Data.Char (toLower)
import Data.Ratio ((%))

-- bound in xinitrc to alt_r
myModMask = mod3Mask

-- Main
main = do
    xmonadBar <- spawnPipe myXmonadBar
    statusBar <- spawnPipe myStatusBar
    xmonad $ withUrgencyHook NoUrgencyHook
           $ myConfig xmonadBar
        `additionalKeysP` myAdditionalKeys
        `removeKeysP` myRemovedKeys
        `additionalMouseBindings` myAdditionalMouseBindings

myConfig xmonadBar = defaultConfig
    { modMask            = myModMask
    , workspaces         = myWorkspaces
    , focusFollowsMouse  = False
    , terminal           = "urxvt"
    , borderWidth        = 1
    , normalBorderColor  = "#444"
    , focusedBorderColor = "steel blue"
    , logHook            = myLogHook xmonadBar
    , manageHook         = myManageHook
    , layoutHook         = myLayout
    }

-- Workspaces
myWorkspaces = ["web", "sauce", "irc", "misc"]

-- Layouts
myLayout = avoidStruts
           $ smartBorders
           $ Full ||| tiled ||| Circle
  where tiled    = named "tile" $ hinted (ResizableTall 1 (3/100) (3/5) [])
        hinted l = layoutHints l

myManageHook = composeAll
    [ title     =? "Downloads" --> doFloat
    , manageDocks ] <+> manageHook defaultConfig

-- Key bindings
spawnOnWs ws command = (windows $ W.greedyView ws) >> spawn command

myAdditionalKeys =
    [ -- run anything
      ("M-S-x", spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")

      -- predetermined locations
    , ("M-x e",   spawnOnWs "sauce" "emacsclient -s main -c")
    , ("M-x M-e", spawnOnWs "sauce" "emacsclient -s main -c")
    , ("M-x S-e", spawnOnWs "sauce" "emacs")
    , ("M-x w",   spawnOnWs "web"   "chromium-dev")
    , ("M-x M-w", spawnOnWs "web"   "chromium")
    , ("M-x i",   spawnOnWs "irc"   "emacsclient -s irc -c --eval '(irc)'")

      -- don't move
    , ("M-u M-x e", spawn "emacsclient -s main -c")
    , ("M-u M-x w", spawn "chromium-dev")
    , ("M-u M-x M-w", spawn "chromium")

      -- volume control
    , ("<XF86AudioMute>",        toggleMute >> return ())
    , ("<XF86AudioRaiseVolume>", raiseVolume 5 >> return ())
    , ("<XF86AudioLowerVolume>", lowerVolume 5 >> return ())

      -- window management
    , ("M-S-h", sendMessage MirrorShrink)
    , ("M-S-l", sendMessage MirrorExpand)

      -- gtfo
    , ("M-q", spawn "killall dzen2; killall conky" >> restart "xmonad" True)
    , ("M-S-<F12>", io (exitWith ExitSuccess))
    ]
myRemovedKeys = ["M-S-q", "M-p"]

-- mod3 (alt_r) is my mouse hand, so allow mod1 for resizing float windows
myAdditionalMouseBindings =
    [ ((mod1Mask, button1), (\w -> focus w >> mouseMoveWindow w
                                           >> windows W.shiftMaster))
    , ((mod1Mask, button3), (\w -> focus w >> mouseResizeWindow w
                                           >> windows W.shiftMaster))
    ]

-- Log hook
myLogHook h = dynamicLogWithPP $ defaultPP
   { ppOutput           = \s -> hPutStrLn h (" " ++ s)
   , ppCurrent          = dzenColor "#000" "steel blue" . wrap " " " "
   , ppHidden           = dzenColor "grey" "#000"
   , ppHiddenNoWindows  = dzenColor "#666" "#000"
   , ppUrgent = dzenColor "#000" "red" . wrap "*" "*"
   , ppLayout = map toLower
   , ppTitle  = shorten 80
   , ppExtras = [ logCmd "sh -c 'echo `whoami`@`uname -n`'" ]
   , ppWsSep  = " "
   , ppSep    = dzenColor "steel blue" "#000" " :: "
   , ppOrder  = \(ws:l:t:exs) -> exs++[ws,l,t]
   }

-- Bars
myDzenCommand = "dzen2 -bg black -fg grey -fn 'Droid Sans Mono-10'"
myXmonadBar   = myDzenCommand ++ " -ta l -w 850"
myStatusBar   = "conky | " ++ myDzenCommand ++ " -ta r -x 850"

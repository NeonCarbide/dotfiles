-- IMPORTS --------------------------------------------------------------- {{{1
-- base -------------------------------------------------------------- {{{2 ---
import XMonad hiding ( (|||) )
import XMonad.Core
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

-- actions ----------------------------------------------------------- {{{2 ---
import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleSelectedLayouts
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves
import XMonad.Actions.Sift
import XMonad.Actions.WithAll

-- data -------------------------------------------------------------- {{{2 ---
import Data.Char (toLower)
import Data.List (isInfixOf)
import Data.Monoid

-- hooks ------------------------------------------------------------- {{{2 ---
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks (avoidStruts, docks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.RefocusLast
import XMonad.Hooks.SetWMName
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

-- layouts ----------------------------------------------------------- {{{2 ---
import XMonad.Layout.Accordion
import XMonad.Layout.Grid
import XMonad.Layout.ResizableTile
import XMonad.Layout.ThreeColumns

-- layout modifiers -------------------------------------------------- {{{2 ---
import XMonad.Layout.CenteredMaster
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.LayoutModifier
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import qualified XMonad.Layout.MultiToggle as MT

-- utilities --------------------------------------------------------- {{{2 ---
import XMonad.Util.EZConfig (mkKeymap)
import XMonad.Util.Font
import XMonad.Util.Loggers
import XMonad.Util.NamedScratchpad

-- VARIABLES ------------------------------------------------------------- {{{1
-- settings ---------------------------------------------------------- {{{2 ---
myClickJustFocuses :: Bool
myClickJustFocuses = True

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

myBorderWidth :: Dimension
myBorderWidth = 2

myModMask :: KeyMask
myModMask = mod4Mask

myBorderFocusColor :: String
myBorderFocusColor = color15

myBorderNormColor :: String
myBorderNormColor = color0

myFont :: String
myFont = "Iosevka Term:size=10"

myFontDmenu :: String
myFontDmenu = "'" ++ myFont ++ "'"

myFontXft :: String
myFontXft = "xft:" ++ myFont

myWorkspaces :: [String]
--myWorkspaces = ["d", "b", "s", "o", "c", "m", "v", "g", "x"]
myWorkspaces = ["δ", "β", "σ", "ω", "χ", "μ", "φ", "γ", "ξ"]
--myWorkspaces = ["Δ", "Β", "Σ", "Ω", "Χ", "Μ", "Φ", "Γ", "Ξ"]

myWorkspaceKeys :: [String]
--myWorkspaceKeys = myWorkspaces
myWorkspaceKeys = ["d", "b", "s", "o", "c", "m", "v", "g", "x"]

-- normal colours ------------------------------------------------- {{{3 ------
color0, color1, color2, color3, color4, color5, color6, color7 :: String
color0      = "#1e2320"
color1      = "#705050"
color2      = "#60b48a"
color3      = "#dfaf8f"
color4      = "#506070"
color5      = "#dc8cc3"
color6      = "#8cd0d3"
color7      = "#dcdccc"

-- bright colours ------------------------------------------------- {{{3 ------
color8, color9, color10, color11, color12, color13, color14, color15 :: String
color8      = "#709080"
color9      = "#dca3a3"
color10     = "#c3bf9f"
color11     = "#f0dfaf"
color12     = "#94bff3"
color13     = "#ec93d3"
color14     = "#93e0e3"
color15     = "#ffffff"

-- xmobar colours ------------------------------------------------- {{{3 ------
xmcTagCopy  = xmobarColor color13   $ color0 ++ ":0"
xmcTagEmp   = xmobarColor color8    $ color0 ++ ":0"
xmcTagNorm  = xmobarColor color15   $ color0 ++ ":0"
xmcTagSel   = xmobarColor color0    $ color15 ++ ":0"
xmcTagUrg   = xmobarColor color9    $ color0 ++ ":0"
xmcTagUrgW  = xmobarColor color11   $ color0 ++ ":0"

-- apps -------------------------------------------------------------- {{{2 ---
myBrowserGemini :: String
myBrowserGemini = myTerminal ++ " -e amfora "

myBrowserWeb :: String
myBrowserWeb = "qutebrowser "

myEmacs :: String
myEmacs = "emacs "

myFileManager :: String
myFileManager = myTerminal ++ " -name ranger -e ranger "

myIRC :: String
myIRC = myTerminal ++ " -name weechat -e weechat "

myLockScreen :: String
myLockScreen = "slock"

myRunPrompt :: String
myRunPrompt = "dmenu_run -i -h 21 -fn " ++ myFontDmenu ++ " -nb '" ++ color0 ++ "' -nf '" ++ color15 ++ "' -sb '" ++ color15 ++ "' -sf '" ++ color0 ++ "'"

myScratchpadTerminal :: String
myScratchpadTerminal = myTerminal ++ " -geometry 144x34 "

mySpotify :: String
mySpotify = myTerminal ++ " -name ncspot -e ncspot "

myTerminal :: String
myTerminal = "urxvtc"

myVim :: String
myVim = myTerminal ++ " -b 0 -name vim -e vim "

-- LAYOUTS --------------------------------------------------------------- {{{1
accordion = renamed [Replace "accordion"]
    $ smartBorders
    $ Mirror Accordion

blinds    = renamed [Replace "blinds"]
    $ smartBorders
    $ Accordion

grid      = renamed [Replace "grid"]
    $ centerMaster
    $ smartBorders
    $ Grid

monocle   = renamed [Replace "monocle"]
    $ noBorders
    $ Full

tall      = renamed [Replace "tall"]
    $ smartBorders
    $ ResizableTall 1 (5/100) (6/10) []

threeCol  = renamed [Replace "threeCol"]
    $ smartBorders
    $ ThreeCol 1 (5/100) (4/10)

threeMid  = renamed [Replace "threeMid"]
    $ smartBorders
    $ ThreeColMid 1 (5/100) (4/10)

wide      = renamed [Replace "wide"]
    $ smartBorders
    $ Mirror tall

myLayoutHook = avoidStruts $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myLayouts
    where
        myLayouts =
            tall |||
            wide |||
            threeCol |||
            threeMid |||
            accordion |||
            blinds |||
            grid |||
            monocle

myLayoutPrinter :: String -> String
myLayoutPrinter "accordion" = "|ǁ|"
myLayoutPrinter "blinds"    = "|=|"
myLayoutPrinter "grid"      = "[+]"
myLayoutPrinter "monocle"   = "(o)"
myLayoutPrinter "tall"      = "[|]"
myLayoutPrinter "threeCol"  = "|]["
myLayoutPrinter "threeMid"  = "]|["
myLayoutPrinter "wide"      = "[-]"

-- SCRATCHPADS ----------------------------------------------------------- {{{1
myScratchpads :: [NamedScratchpad]
myScratchpads =
    [ NS "spclocka" spawnClockA findClockA manage
    , NS "spclockd" spawnClockD findClockD manage
    , NS "spfm" spawnFM findFM manage
    , NS "spirc" spawnIRC findIRC manage
    , NS "spproc" spawnProc findProc manage
    , NS "spspot" spawnSpot findSpot manage
    , NS "spterm" spawnTerm findTerm manage
    , NS "spvim" spawnVim findVim manage
    ]
    where
        findClockA  = resource =? "xclock"
        findClockD  = resource =? "spclock"
        findFM      = resource =? "spfm"
        findIRC     = resource =? "spirc"
        findProc    = resource =? "spproc"
        findSpot    = resource =? "spspot"
        findTerm    = resource =? "spterm"
        findVim     = resource =? "spvim"
        manage      = defaultFloating
        spawnClockA = "xclock"
        spawnClockD = myTerminal ++ " -name spclock -geometry 60x10 -e watch -t -n1 'date +%T | figlet -ckt -f big'"
        spawnFM     = myScratchpadTerminal ++ " -name spfm -e ranger"
        spawnIRC    = myScratchpadTerminal ++ " -name spirc -e weechat"
        spawnProc   = myScratchpadTerminal ++ " -name spproc -e btm"
        spawnSpot   = myScratchpadTerminal ++ " -name spspot -e ncspot"
        spawnTerm   = myScratchpadTerminal ++ " -name spterm "
        spawnVim    = myScratchpadTerminal ++ " -name spvim -e vim"

-- MANAGE HOOK ----------------------------------------------------------- {{{1
myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll . concat $
    -- force floating ------------------------------------------------ {{{2 ---
    [ [ className =? c                --> doFloat | c <- myFloatsC ]
    , [ isFullscreen                  --> doFullFloat ]

    -- ignore -------------------------------------------------------- {{{2 ---
    , [ resource  =? "desktop_window" --> doIgnore ]
    , [ resource  =? "kdesktop"       --> doIgnore ]

    -- scratchpads --------------------------------------------------- {{{2 ---
    , [ resource  =? r                --> doCenterFloat | r <- myCenterFloatsR ]

    -- spawn app on workspace n+1 ------------------------------------ {{{2 ---
    , [ className =? "discord"        --> doShift ( myWorkspaces !! 4 ) ]
    , [ className =? "mpv"            --> doShift ( myWorkspaces !! 6 ) ]
    , [ className =? "MultiMC"        --> doShift ( myWorkspaces !! 7 ) ]
    , [ className =? "qutebrowser"    --> doShift ( myWorkspaces !! 1 ) ]
    , [ resource  =? "ncspot"         --> doShift ( myWorkspaces !! 5 ) ]
    , [ resource  =? "weechat"        --> doShift ( myWorkspaces !! 4 ) ]
    , [ fmap ("craft" `isInfixOf`) className --> doShift ( myWorkspaces !! 7 ) ]
    ]
    -- list definitions ---------------------------------------------- {{{2 ---
    where
        myFloatsC =
            [ "Gimp"
            , "MPlayer"
            , "Xmessage"
            ]
        myCenterFloatsR =
            [ "spclock"
            , "spfm"
            , "spirc"
            , "spproc"
            , "spspot"
            , "spterm"
            , "spvim"
            , "xclock"
            ]

-- KEYBINDINGS ----------------------------------------------------------- {{{1
myKeys = \c -> mkKeymap c $
    -- xmonad -------------------------------------------------------- {{{2 ---
    [ ("M-c",                       kill1)
    , ("M-M1-<End>",                io exitSuccess)
    , ("M-M1-<Home>",               spawn "xmonad --recompile; xmonad --restart")
    , ("M-M1-c M-M1-o",             killOthers)
    , ("M-M1-c M-M1-a",             killAll)
    , ("M-M1-c M-M1-c",             kill)
    , ("M-M1-r M-M1-c",             spawn "xmonad --recompile")
    , ("M-M1-r M-M1-r",             spawn "xmonad --restart")

    -- run prompt ---------------------------------------------------- {{{2 ---
    , ("M-d",                       spawn myRunPrompt)

    -- layout control ------------------------------------------------ {{{2 ---
    , ("M-l M-<Space>",             sendMessage ToggleStruts)
    , ("M-l M-]",                   sendMessage NextLayout)
    , ("M-l M-n",                   refresh)
    , ("M-l M-r",                   setLayout $ XMonad.layoutHook c)
    , ("M-l M-s M-a",               cycleThroughLayouts ["accordion", "blinds"])
    , ("M-l M-s M-g",               sendMessage $ JumpToLayout "grid")
    , ("M-l M-s M-m",               sendMessage $ JumpToLayout "monocle")
    , ("M-l M-s M-t",               cycleThroughLayouts ["tall", "wide"])
    , ("M-l M-s M-3",               cycleThroughLayouts ["threeCol", "threeMid"])

    -- master pane controls ------------------------------------------ {{{2 ---
    , ("M-m M-f",                   windows W.focusMaster)
    , ("M-m M-s",                   windows W.swapMaster)
    , ("M-m M-p",                   promote)
    , ("M-C-m M-C-]",               sendMessage $ IncMasterN 1)
    , ("M-C-m M-C-[",               sendMessage $ IncMasterN (-1))

    -- window control ------------------------------------------------ {{{2 ---
    , ("M-<Delete>",                withFocused $ windows . W.sink)
    , ("M-j",                       windows W.focusDown)
    , ("M-k",                       windows W.focusUp)
    , ("M-M1-h",                    sendMessage Shrink)
    , ("M-M1-j",                    sendMessage MirrorShrink)
    , ("M-M1-k",                    sendMessage MirrorExpand)
    , ("M-M1-l",                    sendMessage Expand)
    , ("M-C-j",                     rotAllDown)
    , ("M-C-k",                     rotAllUp)
    , ("M-S-j",                     windows siftDown)
    , ("M-S-k",                     windows siftUp)
    , ("M-C-S-j",                   rotSlavesDown)
    , ("M-C-S-k",                   rotSlavesUp)

    -- app spawn ----------------------------------------------------- {{{2 ---
    , ("M-x M-<Return>",            spawn $ terminal c)
    , ("M-x M-e",                   spawn myEmacs)
    , ("M-x M-f",                   spawn myFileManager)
    , ("M-x M-s",                   spawn mySpotify)
    , ("M-x M-v",                   spawn myVim)
    , ("M-x M-w",                   spawn myBrowserWeb)
    , ("M-x M-g",                   spawn myBrowserGemini)

    -- spawn emacs with parameters ----------------------------------- {{{2 ---
    , ("M-x M-C-e M-C-b",           spawn $ myEmacs ++ "--eval '(ibuffer)'")
    , ("M-x M-C-e M-C-d",           spawn $ myEmacs ++ "--eval '(dired nil)'")
    , ("M-x M-C-e M-C-s",           spawn $ myEmacs ++ "--eval '(eshell)'")
    , ("M-x M-M1-e M-M1-d",         spawn $ myEmacs ++ "--with-profile doom")
    , ("M-x M-M1-e M-M1-s",         spawn $ myEmacs ++ "--with-profile space")

    -- audio control ------------------------------------------------- {{{2 ---
    , ("<XF86AudioNext>",           spawn "playerctl next")
    , ("<XF86AudioPlay>",           spawn "playerctl play-pause")
    , ("<XF86AudioPrev>",           spawn "playerctl previous")
    , ("<XF86AudioStop>",           spawn "playerctl stop")

    -- backlight control --------------------------------------------- {{{2 ---
    , ("M-<XF86MonBrightnessDown>", spawn "xbacklight -set 0 -steps 8")
    , ("M-<XF86MonBrightnessUp>",   spawn "xbacklight -set 100 -steps 8")
    , ("<XF86MonBrightnessDown>",   spawn "xbacklight -dec 5 -steps 4")
    , ("<XF86MonBrightnessUp>",     spawn "xbacklight -inc 5 -steps 4")

    -- screen lock --------------------------------------------------- {{{2 ---
    , ("<XF86ScreenSaver>",         spawn myLockScreen)

    -- touchpad lock ------------------------------------------------- {{{2 ---
    , ("<XF86TouchpadToggle>",      spawn "toggletouchpad.sh")

    -- volume control ------------------------------------------------ {{{2 ---
    , ("<XF86AudioMute>",           spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    ] ++

    [ (m ++ "<XF86Audio" ++ d ++ "Volume>", spawn $ "pactl set-sink-volume @DEFAULT_SINK@ " ++ a)
        | (d, s) <- [ ("Lower", "-"), ("Raise", "+") ]
        , (m, a) <- [ ("",   s ++ "5%")
                    , ("C-", s ++ "1%")
                    , ("S-", s ++ "10%")
                    , ("M-", if s == "-" then "0%" else "100%")
                    ]
    ] ++

    -- scratchpads --------------------------------------------------- {{{2 ---
    [ ("M-s M-" ++ k, namedScratchpadAction myScratchpads s)
        | (k, s) <- [ ("<Return>", "spterm")
                    , ("b",        "spproc")
                    , ("f",        "spfm")
                    , ("i",        "spirc")
                    , ("s",        "spspot")
                    , ("v",        "spvim")
                    , ("c",        "spclocka")
                    , ("M1-c",     "spclockd")
                    ]
    ] ++

    -- workspaces ---------------------------------------------------- {{{2 ---
    [ (m ++ "M-w M-" ++ m ++ k, windows $ a t)
        | (t, k) <- zip myWorkspaces myWorkspaceKeys
        , (m, a) <- [ ("",   W.greedyView)
                    , ("S-", W.shift)
                    , ("C-", copy)
                    ]
    ]

-- XMOBAR ---------------------------------------------------------------- {{{1
myXmobarPP :: PP
myXmobarPP = filterOutWsPP [scratchpadWorkspaceTag] $ def
    { ppSep             = ""
    , ppWsSep           = ""
    , ppCurrent         = xmcTagSel . wrap " " " "
    , ppHidden          = xmcTagNorm . wrap " " " "
    , ppHiddenNoWindows = xmcTagEmp . wrap " " " "
    , ppUrgent          = xmcTagUrg . wrap (xmcTagUrgW "!") " "
    , ppLayout          = wrap " " " " . myLayoutPrinter
    , ppTitle           = wrap " " " "
    , ppOrder           = \(t:l:w:_) -> [l, t, w]
    }

myOtherXmobarPP :: PP
myOtherXmobarPP = def
    { ppTitleSanitize   = xmobarStrip
    , ppOrder           = \(_:_:w:_) -> [w]
    }

myStatusBarTop    = statusBarPropTo "_XMONAD_LOG_0" "xmobar -x 0 ~/.xmonad/xmobarrc-t" (pure myXmobarPP)
myStatusBarBottom = statusBarPropTo "_XMONAD_LOG_1" "xmobar -x 0 ~/.xmonad/xmobarrc-b" (pure myOtherXmobarPP)

myStatusBar = statusBarProp "xmobar ~/.xmonad/xmobarrc" (copiesPP (xmcTagCopy . wrap " " " ") myXmobarPP)

myBarSpawner :: ScreenId -> IO StatusBarConfig
--myBarSpawner 0 = pure $ myStatusBarTop <> myStatusBarBottom
myBarSpawner 0 = pure $ myStatusBar
myBarSpawner _ = mempty

-- MAIN ------------------------------------------------------------------ {{{1
main :: IO ()
main = do
    xmonad $ docks . ewmhFullscreen . ewmh . dynamicSBs (myBarSpawner) $ def
        -- settings -------------------------------------------------- {{{2 ---
        { borderWidth           = myBorderWidth
        , clickJustFocuses      = myClickJustFocuses
        , focusFollowsMouse     = myFocusFollowsMouse
        , focusedBorderColor    = myBorderFocusColor
        , keys                  = myKeys
        , modMask               = myModMask
        , normalBorderColor     = myBorderNormColor
        , terminal              = myTerminal
        , workspaces            = myWorkspaces

        -- hooks ----------------------------------------------------- {{{2 ---
        , layoutHook            = myLayoutHook
        , logHook               = refocusLastLogHook >> nsHideOnFocusLoss myScratchpads
        , manageHook            = myManageHook <+> namedScratchpadManageHook myScratchpads
        }

-- vim:foldmethod=marker:foldlevel=1:

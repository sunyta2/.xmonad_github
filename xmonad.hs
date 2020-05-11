-- xmonad config used by Vic Fryzel
-- Author: Vic Fryzel
-- https://github.com/vicfryzel/xmonad-config
-- haskell_vicfryzel.hs을 기본틀로 사용함
-- .xmonad_vicfryzel/ 를 그대로 복사하고
--
-- haskell_vicfryzel.hs 파일의 링커를 생성하며 아래에 그 항목을 만들어 낸다.
-- battery.sh, memory.sh등의 파일을 링커로 연결함

-- (find-file-other-window "~/config_github/app/xmonad/github_list.org")

import System.IO
import System.Exit
import XMonad
import Graphics.X11.ExtraTypes.XF86
import XMonad.Actions.CycleWS
import XMonad.Actions.GridSelect
import XMonad.Actions.WindowGo
import XMonad.Actions.SpawnOn -- spawnOn "workspaceN" "programN"
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Layout.Drawer
import XMonad.Layout.Dwindle
import XMonad.Layout.AutoMaster -- 자동으로 크기를 조절하는 것으로 보임.
import XMonad.Layout.Grid
import XMonad.Layout.Fullscreen
-- import XMonad.Layout.Master
-- import XMonad.Layout.LimitWindows -- 총수를 제한함.
import XMonad.Layout.Reflect -- 반사의 방식을 추가함 놀라움
import XMonad.Layout.MagicFocus
import XMonad.Layout.MosaicAlt
import qualified Data.Map as M
import XMonad.Layout.MultiColumns
import XMonad.Layout.NoBorders
import XMonad.Layout.OneBig
import XMonad.Layout.Spacing -- 놀라운 기능확장성 전체layout에 전개함
import XMonad.Layout.Spiral
import XMonad.Layout.StackTile
import XMonad.Layout.Tabbed
import XMonad.Layout.TwoPane
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ZoomRow
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys) -- -- (29) "M-C-x" style keybindings
import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import qualified Data.Map        as M





------------------------------------------------------------------------
-- Terminal
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal = "/usr/bin/urxvt"
-- gnome-terminal

-- The command to lock the screen or show the screensaver.
myScreensaver = "/usr/bin/xscreensaver-command -l"

-- The command to take a selective screenshot, where you select
-- what you'd like to capture on the screen.
mySelectScreenshot = "select-screenshot"

-- The command to take a fullscreen screenshot.
myScreenshot = "screenshot"

-- The command to use as a launcher, to launch commands that don't have
-- preset keybindings.
-- myLauncher = "$(yeganesh -x -- -fn 'monospace-8' -nb '#000000' -nf '#FFFFFF' -sb '#7C7C7C' -sf '#CEFFAC')"
myLauncher = "rofi -show combi window,run -show combi"

-- Location of your xmobar.hs / xmobarrc
myXmobarrc = "~/.xmonad/xmobar-single.hs"


------------------------------------------------------------------------
-- Workspaces
-- The default number of workspaces (virtual screens) and their names.
--
myWorkspaces = ["1:web","2:media","3:urxvt","4:greek","5:latin"] ++ map show [6..9]


------------------------------------------------------------------------
-- Window rules
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "Chromium"       --> doShift "1:web"
    , className =? "Google-chrome"  --> doShift "1:web"
    , className =? "Brave"          --> doShift "1:web"    
    , resource  =? "desktop_window" --> doIgnore
    , className =? "Emacs"     --> doFloat -- 정확히 대문자 Emacs로 기록해야 인식됨!
    , resource =? "okular"     --> doFloat -- work well
    , resource =? "surf"     --> doFloat -- ?work well
    , resource =? "ranger"     --> doFloat -- not work well
    , className =? "Dolphin"     --> doFloat  -- not well
    , className =? "Thunar"     --> doFloat
    , className =? "Crow Translate"     --> doFloat
    , className =? "Gespeaker"     --> doFloat
    , resource =? "Gespeaker"     --> doFloat
    , className =? "xmessage"     --> doFloat
    , resource =? "xmessage"     --> doFloat
    , className =? "Galculator"     --> doFloat
    , className =? "Steam"          --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "gpicview"       --> doFloat
    , className =? "mpv"        --> doFloat
    , className =? "VirtualBox"     --> doShift "4:vm"
    , className =? "Xchat"          --> doShift "5:media"
    , className =? "stalonetray"    --> doIgnore
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)]


------------------------------------------------------------------------
-- Layouts
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--

myLayout = avoidStruts (
--    (reflectHoriz $ Mirror (multiCol [2] 4 0.01 (2/3))) |||
    spacing 2 $ OneBig 0.92 0.9 |||
    Mirror (multiCol [2] 4 0.01 (2/3)) |||
    Mirror (multiCol [2] 4 0.01 (2/3)) |||
    Mirror (Tall 1 (3/100) (2/3)) |||
    Grid |||
    autoMaster 2 0.03 Grid |||
--    (reflectVert $ (OneBig 0.92 0.9)) |||
--    Squeeze D 1.5 1.1 ||| -- 불필요함 크기줄인 것으 선형적인 크기줄인 나열임.
    MosaicAlt M.empty |||
--    (magicFocus Grid) |||
--    (Mirror (multimastered 2 (1/100) (2/3) $ Grid)) |||
--    multiCol [3] 4 0.01 0.5 |||
    multiCol [2] 4 0.01 (2/3) |||
--    zoomRow ||| Mirror zoomRow ||| -- 불필요한 널어놓기
    TwoPane (3/100) (3/5)  |||
    Mirror (TwoPane (3/100) (3/5))  |||
--    Mirror (multiCol [2] 2 0.01 (-0.25)) |||
    ThreeColMid 1 (3/100) (2/3) |||
    ThreeCol 1 (3/100) (2/3) |||
    Mirror (ThreeCol 1 (3/100) (2/3)) |||
    Full |||
--    simpleDrawer (Tall 1 (3/100) (2/3)) |||
    Tall 1 (3/100) (2/3)
--    tabbed shrinkText tabConfig |||
--    Full |||
--    spiral (6/7) |||
    ) 
    ||| noBorders (fullscreenFull Full)


------------------------------------------------------------------------
-- Colors and borders
-- Currently based on the ir_black theme.
--
myNormalBorderColor  = "#7c7c7c"
--myFocusedBorderColor = "#ffb6b0"
myFocusedBorderColor = "orange"

-- Colors for text and backgrounds of each tab when in "Tabbed" layout.
tabConfig = defaultTheme {
    activeBorderColor = "#7C7C7C",
    activeTextColor = "#CEFFAC",
    activeColor = "#000000",
    inactiveBorderColor = "#7C7C7C",
    inactiveTextColor = "#EEEEEE",
    inactiveColor = "#000000"
}

-- Color of current window title in xmobar.
-- xmobarTitleColor = "#FFB6B0"
xmobarTitleColor = "red"

-- Color of current workspace in xmobar.
-- xmobarCurrentWorkspaceColor = "#CEFFAC"
xmobarCurrentWorkspaceColor = "red"

-- Width of the window border in pixels.
myBorderWidth = 3


------------------------------------------------------------------------
-- Key bindings
--
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask = mod4Mask

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  ----------------------------------------------------------------------
  -- Custom key bindings
  --

  -- Start a terminal.  Terminal to start is specified by myTerminal variable.
  [ ((modMask .|. shiftMask, xK_Return),
     spawn $ XMonad.terminal conf)

  -- Lock the screen using command specified by myScreensaver.
  , ((modMask .|. controlMask, xK_l),
     spawn myScreensaver)

  -- Spawn the launcher using command specified by myLauncher.
  -- Use this to launch programs without a key binding.
  , ((modMask, xK_r),
     spawn myLauncher)

    -- Emacs raise
--  , ((myModMask .|. shiftMask, xK_e), raiseMaybe (safeSpawn "emacs" []) (className =? "emacs"))
--  , ((myModMask .|. shiftMask, xK_e), raiseMaybe "emacs" (className =? "Emacs"))
--  , ((myModMask, xK_e), raise (className =? "Emacs"))
--  , ((myModMask .|. shiftMask, xK_e), raise (className =? "Emacs"))
  , ((myModMask .|. shiftMask, xK_e), raiseNext (className =? "Emacs")) -- Emacs 잘 작동되는 것으로 확증됨
  , ((myModMask, xK_e), raise (className =? "Emacs")) -- study_xmonad.org -- xmonad WindowGo

  
  -- Take a selective screenshot using the command specified by mySelectScreenshot.
  , ((modMask .|. shiftMask, xK_p),
     spawn mySelectScreenshot)

  -- Take a full screenshot using the command specified by myScreenshot.
  , ((modMask .|. controlMask .|. shiftMask, xK_p),
     spawn myScreenshot)

  -- Mute volume.
  , ((0, xF86XK_AudioMute),
     spawn "amixer -q set Master toggle")

  -- Decrease volume.
  , ((0, xF86XK_AudioLowerVolume),
     spawn "amixer -q set Master 5%-")

  -- Increase volume.
  , ((0, xF86XK_AudioRaiseVolume),
     spawn "amixer -q set Master 5%+")

  -- Mute volume.
  , ((modMask .|. controlMask, xK_m),
     spawn "amixer -q set Master toggle")

  -- Decrease volume.
  , ((modMask .|. controlMask, xK_j),
     spawn "amixer -q set Master 5%-")

  -- Increase volume.
  , ((modMask .|. controlMask, xK_k),
     spawn "amixer -q set Master 5%+")

  -- Audio previous.
  , ((0, 0x1008FF16),
     spawn "")

  -- Play/pause.
  , ((0, 0x1008FF14),
     spawn "")

  -- Audio next.
  , ((0, 0x1008FF17),
     spawn "")

  -- Eject CD tray.
  , ((0, 0x1008FF2C),
     spawn "eject -T")

  --------------------------------------------------------------------
  -- "Standard" xmonad key bindings
  --
-- Run xmessage with a summary of the default keybindings (useful for beginners) 도움말기능 help
    , ((modMask .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    -- launch gmrun
    , ((modMask,               xK_p     ), spawn "gmrun") -- gmrun 으로 쉘명령을 실행하게 됨
    -- launch dmenu
    --, ((modMask .|. shiftMask, xK_p     ), spawn "dmeun_run")

  -- Close focused window.
  , ((modMask .|. shiftMask, xK_c),
     kill)

  -- Cycle through the available layout algorithms.
  , ((modMask, xK_space),
     sendMessage NextLayout)

  --  Reset the layouts on the current workspace to default.
  , ((modMask .|. shiftMask, xK_space),
     setLayout $ XMonad.layoutHook conf)

  -- Resize viewed windows to the correct size.
  , ((modMask, xK_n),
     refresh)

  -- Move focus to the next window.
  , ((modMask,               xK_Tab),
     goToSelected defaultGSConfig)
 --  (  windows W.focusDown)

    -- Bring Here selected window.
  , ((modMask .|. shiftMask, xK_Tab),
     bringSelected defaultGSConfig)
 --  (  windows W.focusDown)
  
  -- Move focus to the next window.
  , ((modMask, xK_j),
     (windows W.focusDown <+> windows W.swapMaster))
        -- add 리턴기능을 추가함 <+> 참고 다중명령실행 104 544
  
--  , ((modMask, xK_j),
--     windows W.focusDown)

  ---------------------------------
  -- 창의 이동과 동시에 
  -- , ((modMask, xK_j),         --
  --    (                        --
  --      (windows W.focusDown)  --
  --      (windows W.swapMaster) --
  --    ))                       --
  ---------------------------------

  
  -- Move focus to the previous window.
  , ((modMask, xK_k),
     windows W.focusUp  )

  -- Move focus to the master window.
  , ((modMask, xK_m),
     windows W.focusMaster  )

  -- Swap the focused window and the master window.
  , ((modMask, xK_Return),
     windows W.swapMaster)

  -- Swap the focused window with the next window.
  , ((modMask .|. shiftMask, xK_j),
     windows W.swapDown  )

  -- Swap the focused window with the previous window.
  , ((modMask .|. shiftMask, xK_k),
     windows W.swapUp    )

  -- Shrink the master area.
  , ((modMask, xK_h),
     sendMessage Shrink)

  -- Expand the master area.
  , ((modMask, xK_l),
     sendMessage Expand)

  -- Push window back into tiling.
  , ((modMask, xK_t),
     withFocused $ windows . W.sink)

  -- Increment the number of windows in the master area.
  , ((modMask, xK_comma),
     sendMessage (IncMasterN 1))

  -- Decrement the number of windows in the master area.
  , ((modMask, xK_period),
     sendMessage (IncMasterN (-1)))

  -- Toggle the status bar gap.
  -- TODO: update this binding with avoidStruts, ((modMask, xK_b),

  -- Quit xmonad.
  , ((modMask .|. shiftMask, xK_q),
     io (exitWith ExitSuccess))

  -- Restart xmonad.
  , ((modMask, xK_q),
     restart "xmonad" True)
  ]
  ++

  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  [((m .|. modMask, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
  ++

  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
  [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
--      | (key, sc) <- zip [xK_w, xK_e] [0..]
      | (key, sc) <- zip [xK_w] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings
--
-- Focus rules
-- True if your focus should follow your mouse cursor.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
  [
    -- mod-button1, Set the window to floating mode and move by dragging
    ((modMask, button1),
     (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2),
       (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3),
       (\w -> focus w >> mouseResizeWindow w))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
  ]


-------------------------------------------------------------------------------------
-- myNavigation = makeXEventhandler $ shadowWithKeymap navKeyMap navDefaultHandler --

myNavigation :: TwoD a (Maybe a)
myNavigation = makeXEventhandler $ shadowWithKeymap navKeyMap navDefaultHandler
 where navKeyMap = M.fromList [
          ((0,xK_Escape), cancel)
         ,((0,xK_g), cancel)
--         ,((controlMask, xK_[)  , cancel)
--         ,((ModMask, xK_g)  , cancel)
--         ,((controlMask, xK_g)  , cancel)
         ,((0,xK_Return), select)
--         ,((controlMask, xK_m), select)

         ,((0,xK_slash) , substringSearch myNavigation)
         ,((0,xK_Left)  , move (-1,0)  >> myNavigation)
--         ,((controlMask, xK_b)  , move (-1,0)  >> myNavigation)
         ,((0,xK_b)  , move (-1,0)  >> myNavigation)
--         ,((0,xK_h)     , move (-1,0)  >> myNavigation)
         ,((0,xK_Right) , move (1,0)   >> myNavigation)
--         ,((controlMask, xK_f)  , move (1,0)  >> myNavigation)
         ,((0, xK_f)  , move (1,0)  >> myNavigation)
         ,((0,xK_l)     , move (1,0)   >> myNavigation)
         ,((0,xK_Down)  , move (0,1)   >> myNavigation)
--         ,((controlMask, xK_n)  , move (0,1)  >> myNavigation)
         ,((0, xK_n)  , move (0,1)  >> myNavigation)
         ,((0,xK_j)     , move (0,1)   >> myNavigation)
         ,((0,xK_Up)    , move (0,-1)  >> myNavigation)
--         ,((controlMask, xK_p)  , move (0,-1)  >> myNavigation)
         ,((0, xK_p)  , move (0,-1)  >> myNavigation)
         ,((0,xK_y)     , move (-1,-1) >> myNavigation)
         ,((0,xK_i)     , move (1,-1)  >> myNavigation)
         ,((0,xK_n)     , move (-1,1)  >> myNavigation)
         ,((0,xK_m)     , move (1,-1)  >> myNavigation)
         ,((0,xK_space) , setPos (0,0) >> myNavigation)
         ]
       -- The navigation handler ignores unknown key symbols
       navDefaultHandler = const myNavigation



------------------------------------------------------------------------
-- Status bars and logging
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
-- To emulate dwm's status bar
--
-- > logHook = dynamicLogDzen
--


------------------------------------------------------------------------
-- Startup hook
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
-- myStartupHook = return () -- 아무것도 안하던 기본상태였음
myStartupHook = do
  spawn "bash ~/.xmonad/startup.sh"
  spawnOn "2:media" "dolphin"
  spawnOn "2:media" "dolphin"
--  spawn "bash ~/.xmonad/startup.sh"
--  spawnOn "workspace1" "program1"
  -- import XMonad.Actions.SpawnOn -- spawnOn "workspaceN" "programN"
--  spawnOn "workspaceN" "programN"

----------------------------------------------------------------------
--    -- 아래는 중요한 예문이다 --                                     --
--   myStartupHook = do                                             --
--     spawn "/usr/bin/feh  --bg-fill /home/abennett/wallpaper.jpg" --
--     -- and more stuff like                                       --
--     spawn myTerminal                                             --
--     spawn "xclock"                                               --
--    -- 위는 중요한 예문이다 --                                       --
----------------------------------------------------------------------

  --  spawn "bash -c 'espeak hi world'"
--  spawn "bash -c \"notify-send 'hello world'\""
-------------------------------------------
-- myStartupHook = do -- 실행의 예문이다    --
--   setWMName "LG3D"                    --
--   spawn "bash ~/.xmonad/startup.sh"   --
--   setDefaultCursor xC_left_ptr        --
-------------------------------------------


------------------------------------------------------------------------
-- Run xmonad with all the defaults we set up.
--
-------------------------------------------------------------------------
-- main = do                                                           --
--   xmproc <- spawnPipe ("xmobar " ++ myXmobarrc)                     --
--   xmonad $ ewmh                                                     --
--       $ defaults {                                                  --
--       logHook = dynamicLogWithPP $ xmobarPP {                       --
--             ppOutput = hPutStrLn xmproc                             --
--           , ppTitle = xmobarColor xmobarTitleColor "" . shorten 100 --
--           , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""  --
--           , ppSep = "   "                                           --
--       }                                                             --
--       , manageHook = manageDocks <+> myManageHook                   --
-- --      , startupHook = docksStartupHook <+> setWMName "LG3D"       --
--       , startupHook = setWMName "LG3D"                              --
--       , handleEventHook = docksEventHook                            --
--   }                                                                 --
-------------------------------------------------------------------------

main = do
  xmproc <- spawnPipe ("xmobar " ++ myXmobarrc)
  xmonad $ ewmh
         $ defaults {
          logHook = dynamicLogWithPP $ xmobarPP {
              ppOutput = hPutStrLn xmproc
              , ppTitle = xmobarColor xmobarTitleColor "" . shorten 100
              , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
              , ppSep = "   "
          }
          , manageHook = manageDocks <+> myManageHook
--        , startupHook = docksStartupHook <+> setWMName "LG3D"
--        , startupHook = setWMName "LG3D"
          , startupHook = myStartupHook
          , handleEventHook = docksEventHook
       }



-------------------------------------------------------------------------------------
       
------------------------------------------------------------------------
-- Combine it all together
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = defaultConfig {
    -- simple stuff
    terminal           = myTerminal,
    focusFollowsMouse  = myFocusFollowsMouse,
    borderWidth        = myBorderWidth,
    modMask            = myModMask,
    workspaces         = myWorkspaces,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,

    -- key bindings
    keys               = myKeys,
    mouseBindings      = myMouseBindings,

    -- hooks, layouts
    layoutHook         = smartBorders $ myLayout,
    manageHook         = myManageHook,
    startupHook        = myStartupHook
}
-- | They keybindings for this config file, accessible via mod-Shift-/ 도움말기능 help
help :: String
help = unlines
   [ "XMonad keybindings help xmessage ~/.xmonad/xmonad.hs   "
   , "WORKFLOW - crow, surf, okular, evince, Emacs"
   , "WORKFLOW startup.sh, scheduler, key-mon,"
   , "surf shortcut {h | l | / | y | g | p}"
   , "The modifier key is 'super'. Keybindings:"
   , "mod-(Shift)-e      Switch to Emacs "
   , ""
   , "-- launching and killing programs"
   , "mod-Shift-Enter  Launch " ++ myTerminal
   , "mod-r            Launch rofi"
   , "mod-p            Launch gmrun     - run Shell commands     "
   , "mod-Shift-c      Close/kill the focused window"
   , "mod-Space        Rotate through the available layout algorithms"
   , "mod-Shift-Space  Reset the layouts on the current workSpace to default"
   , "mod-n            Resize/refresh viewed windows to the correct size"
   , "mod-Shift-l      Lock workstation with xscreensaver"
   , ""
   , "-- move focus up or down the window stack"
   , "mod-Tab        Move focus to the next window"
   , "mod-Shift-Tab  Move focus to the previous window"
   , "mod-j          Move focus to the next window"
   , "mod-k          Move focus to the previous window"
   , "mod-m          Move focus to the master window"
   , ""
   , "-- modifying the window order"
   , "mod-Return   (tile&float)Swap the focused window and the master window"
   , "mod-Shift-j  Swap the focused window with the next window"
   , "mod-Shift-k  Swap the focused window with the previous window"
   , ""
   , "-- resizing the master/slave ratio"
   , "mod-h  Shrink the master area"
   , "mod-l  Expand the master area"
   , ""
   , "-- floating layer support"
   , "mod-t  Push window back into tiling; unfloat and re-tile it"
   , ""
   , "-- increase or decrease number of windows in the master area"
   , "mod-comma  (mod-,)  Increment the number of windows in the master area"
   , "mod-period (mod-.)  Deincrement the number of windows in the master area"
   , ""
   , "-- quit, or restart"
   , "mod-Shift-q  Quit xmonad"
   , "mod-q        Restart xmonad"
   , ""
   , "-- Workspaces & screens"
   , "mod-[1..9]         Switch to workSpace N"
   , "mod-Shift-[1..9]   Move client to workspace N"
   , "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3"
   , "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3"
   , ""
   , "-- Mouse bindings: default actions bound to mouse events"
   , "mod-button1  Set the window to floating mode and move by dragging"
   , "mod-button2  (tile&float)Raise the window to the top of the stack"
   , "mod-button3  Set the window to floating mode and resize by dragging"
   , ""
   , "-- Miscellaneous bindings"
   , "mod-b                Toggle the status bar gap"
   , "mod-Shift-/ (mod-?)  Show this help dialog"
   ]

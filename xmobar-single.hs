-- xmobar config used by Vic Fryzel
-- Author: Vic Fryzel
-- https://github.com/vicfryzel/xmonad-config

-- This xmobar config is for a single 4k display (3840x2160) and meant to be
-- used with the stalonetrayrc-single config.
--
-- If you're using a single display with a different resolution, adjust the
-- position argument below using the given calculation.
Config {
    -- Position xmobar along the top, with a stalonetray in the top right.
    -- Add right padding to xmobar to ensure stalonetray and xmobar don't
    -- overlap. stalonetrayrc-single is configured for 12 icons, each 23px
    -- wide. 
    -- right_padding = num_icons * icon_size
    -- right_padding = 12 * 23 = 276
    -- Example: position = TopP 0 276
    position = Bottom,
--    font = "xft:monospace-11,nanumgoth-11",
    font = "xft:nanumgoth:size=11,monospace-11",
    -- bgColor = "#000000",
    -- bgColor = "#142942", -- ← 배경화면과 동일하게 통일된 바의 배경색깔임
--    bgColor = "midnightblue",
    fgColor = "darkgreen",
    -- emacs #fbd817 노란색배경
    bgColor = "#fdb817",
    borderColor = "blue",
    border = FullB,
    borderWidth = 3,
    lowerOnStart = False,
    overrideRedirect = False,
    allDesktops = True,
    persistent = True,
    commands = [
--        Run Weather "KPAO" ["-t","<tempF>F <skyCondition>","-L","64","-H","77","-n","#CEFFAC","-h","#FFB6B0","-l","#96CBFE"] 36000,
--        Run MultiCpu ["-t","Cpu: <total0> <total1> <total2> <total3>","-L","30","-H","60","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC","-w","3"] 10,
        Run Memory ["-t","Mem: <usedratio>%","-H","8192","-L","4096","-h","red","-l","#CEFFAC","-n","#FFFFCC"] 10,
--        Run Swap ["-t","Swap: <usedratio>%","-H","1024","-L","512","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
--        Run Network "eth0" ["-t","Net: <rx>, <tx>","-H","200","-L","10","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
--        Run Date "%a %b %_d %l:%M" "date" 10,
        Run Date " %k:%M   [%Y-%m-%d %a] " "date" 10,
        Run Battery [
	"-t", "<acstatus>: <left>% - <timeleft>",
	"--",
	--"-c", "charge_full",
	"-O", "AC",
	"-o", "Bat",
	"-h", "green",
	"-l", "red"
	] 10,
  Run Com "/usr/bin/bash" ["-c", "~/.xmonad/get-volume.sh"]  "myvolume" 1,
  Run Com "/usr/bin/bash" ["-c", "~/.xmonad/get-battery.sh"]  "mybattery" 1,
        --        Run Com ./getMasterVolume
--        Run Com "getMasterVolume" [] "volumelevel" 10,
        Run StdinReader
    ],
    sepChar = "%",
    alignSep = "}{",
--    template = "%StdinReader% }{ %multicpu%   %memory%   %swap%  %eth0%   Vol: <fc=#b2b2ff>%volumelevel%</fc>   <fc=#FFFFCC>%date%</fc>"
    -- template = "%StdinReader% }{ %date% %memory%  %multicpu% "
template = "  <fc=darkgreen> γνωθι σεαυτόν.</fc> <fc=red>%date%</fc> <fc=darkgreen>Xmonad =></fc> %StdinReader% }{ <fc=blue>%date%</fc> %mybattery% <fc=red>%myvolume%</fc> %memory% " --"%memory% %Battery% %mybattery% %myvolume%"
    -- template = "  <fc=green>Know Thyself</fc>  <fc=orange>%date%</fc> <fc=green>Xmonad =></fc> %StdinReader% }{ <fc=orange>%date%</fc> %memory%  "
--    template = "  <fc=green>Know Thyself</fc>  <fc=orange>%date%</fc> }{%StdinReader%  <fc=green>Xmonad</fc> %memory%  "
--    template = "%StdinReader% }{ %date% %memory%  "    
}

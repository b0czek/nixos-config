{ config, pkgs, ... }:

{
  home.file = {
  	".local/share/konsole/profilek1.profile".text = ''
  [General]
  Command=/run/current-system/sw/bin/fish
  Name=profilek1
  Parent=FALLBACK/

  [Interaction Options]
  UnderlineFilesEnabled=true
    
  [Scrolling]
  HistoryMode=2
    
  '';
  

    ".config/konsolerc".text = ''
  MenuBar=Disabled
  State=AAAA/wAAAAD9AAAAAQAAAAAAAAAAAAAAAPwCAAAAAvsAAAAiAFEAdQBpAGMAawBDAG8AbQBtAGEAbgBkAHMARABvAGMAawAAAAAA/////wAAAXwBAAAD+wAAABwAUwBTAEgATQBhAG4AYQBnAGUAcgBEAG8AYwBrAAAAAAD/////AAABFQEAAAMAAAUAAAAFQQAAAAQAAAAEAAAACAAAAAj8AAAAAQAAAAIAAAACAAAAFgBtAGEAaQBuAFQAbwBvAGwAQgBhAHIBAAAAAP////8AAAAAAAAAAAAAABwAcwBlAHMAcwBpAG8AbgBUAG8AbwBsAGIAYQByAQAAAAz/////AAAAAAAAAAA=

  [Desktop Entry]
  DefaultProfile=profilek.profile

  [General]
  ConfigVersion=1

  [MainWindow]
  State=AAAA/wAAAAD9AAAAAQAAAAAAAAAAAAAAAPwCAAAAAvsAAAAiAFEAdQBpAGMAawBDAG8AbQBtAGEAbgBkAHMARABvAGMAawAAAAAA/////wAAAXwBAAAD+wAAABwAUwBTAEgATQBhAG4AYQBnAGUAcgBEAG8AYwBrAAAAAAD/////AAABFQEAAAMAAASeAAACrwAAAAQAAAAEAAAACAAAAAj8AAAAAQAAAAIAAAACAAAAFgBtAGEAaQBuAFQAbwBvAGwAQgBhAHIAAAAAAP////8AAAAAAAAAAAAAABwAcwBlAHMAcwBpAG8AbgBUAG8AbwBsAGIAYQByAAAAAAD/////AAAAAAAAAAA=
  ToolBarsMovable=Disabled

  [Notification Messages]
  CloseAllTabs=true

  [UiSettings]
  ColorScheme=

    '';
  };
}

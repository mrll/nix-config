{ config, lib, ... }:

with lib;

{
  options.systemColors = {
    bg = {
      primary = mkOption { type = with types; str; default = config.systemColors.base.gray9; };
      secondary = mkOption { type = with types; str; default = config.systemColors.base.gray8; };
      tertiary = mkOption { type = with types; str; default = config.systemColors.base.gray7; };
      info = mkOption { type = with types; str; default = config.systemColors.base.blue5; };
      danger = mkOption { type = with types; str; default = config.systemColors.base.red5; };
      success = mkOption { type = with types; str; default = config.systemColors.base.green5; };
      warning = mkOption { type = with types; str; default = config.systemColors.base.yellow5; };
    };
    fg = {
      primary = mkOption { type = with types; str; default = config.systemColors.base.gray0; };
      secondary = mkOption { type = with types; str; default = config.systemColors.base.gray1; };
      tertiary = mkOption { type = with types; str; default = config.systemColors.base.gray2; };
      info = mkOption { type = with types; str; default = config.systemColors.base.blue3; };
      danger = mkOption { type = with types; str; default = config.systemColors.base.red3; };
      success = mkOption { type = with types; str; default = config.systemColors.base.green3; };
      warning = mkOption { type = with types; str; default = config.systemColors.base.yellow3; };
    };
    border = {
      primary = mkOption { type = with types; str; default = config.systemColors.base.gray3; };
      secondary = mkOption { type = with types; str; default = config.systemColors.base.gray2; };
      tertiary = mkOption { type = with types; str; default = config.systemColors.base.gray1; };
      info = mkOption { type = with types; str; default = config.systemColors.base.blue5; };
      danger = mkOption { type = with types; str; default = config.systemColors.base.red5; };
      success = mkOption { type = with types; str; default = config.systemColors.base.green5; };
      warning = mkOption { type = with types; str; default = config.systemColors.base.yellow5; };
    };
    ansi = {
      black = mkOption { type = with types; str; default = config.systemColors.bg.primary; };
      blackBright = mkOption { type = with types; str; default = config.systemColors.bg.tertiary; };
      white = mkOption { type = with types; str; default = config.systemColors.fg.tertiary; };
      whiteBright = mkOption { type = with types; str; default = config.systemColors.fg.primary; };
      red = mkOption { type = with types; str; default = config.systemColors.base.red5; };
      redBright = mkOption { type = with types; str; default = config.systemColors.base.red3; };
      green = mkOption { type = with types; str; default = config.systemColors.base.green5; };
      greenBright = mkOption { type = with types; str; default = config.systemColors.base.green3; };
      yellow = mkOption { type = with types; str; default = config.systemColors.base.yellow5; };
      yellowBright = mkOption { type = with types; str; default = config.systemColors.base.yellow3; };
      blue = mkOption { type = with types; str; default = config.systemColors.base.blue5; };
      blueBright = mkOption { type = with types; str; default = config.systemColors.base.blue3; };
      magenta = mkOption { type = with types; str; default = config.systemColors.base.pink5; };
      magentaBright = mkOption { type = with types; str; default = config.systemColors.base.pink3; };
      cyan = mkOption { type = with types; str; default = "#39c5cf"; };
      cyanBright = mkOption { type = with types; str; default = "#56d4dd"; };
    };
    base = {
      # Gray
      gray0 = mkOption { type = with types; str; default = "#cdd9e5"; };
      gray1 = mkOption { type = with types; str; default = "#adbac7"; };
      gray2 = mkOption { type = with types; str; default = "#909dab"; };
      gray3 = mkOption { type = with types; str; default = "#768390"; };
      gray4 = mkOption { type = with types; str; default = "#636e7b"; };
      gray5 = mkOption { type = with types; str; default = "#545d68"; };
      gray6 = mkOption { type = with types; str; default = "#444c56"; };
      gray7 = mkOption { type = with types; str; default = "#373e47"; };
      gray8 = mkOption { type = with types; str; default = "#2d333b"; };
      gray9 = mkOption { type = with types; str; default = "#22272e"; };
      # Blue
      blue0 = mkOption { type = with types; str; default = "#c6e6ff"; };
      blue1 = mkOption { type = with types; str; default = "#96d0ff"; };
      blue2 = mkOption { type = with types; str; default = "#6cb6ff"; };
      blue3 = mkOption { type = with types; str; default = "#539bf5"; };
      blue4 = mkOption { type = with types; str; default = "#4184e4"; };
      blue5 = mkOption { type = with types; str; default = "#316dca"; };
      blue6 = mkOption { type = with types; str; default = "#255ab2"; };
      blue7 = mkOption { type = with types; str; default = "#1b4b91"; };
      blue8 = mkOption { type = with types; str; default = "#143d79"; };
      blue9 = mkOption { type = with types; str; default = "#0f2d5c"; };
      # Green
      green0 = mkOption { type = with types; str; default = "#b4f1b4"; };
      green1 = mkOption { type = with types; str; default = "#8ddb8c"; };
      green2 = mkOption { type = with types; str; default = "#6bc46d"; };
      green3 = mkOption { type = with types; str; default = "#57ab5a"; };
      green4 = mkOption { type = with types; str; default = "#46954a"; };
      green5 = mkOption { type = with types; str; default = "#347d39"; };
      green6 = mkOption { type = with types; str; default = "#2b6a30"; };
      green7 = mkOption { type = with types; str; default = "#245829"; };
      green8 = mkOption { type = with types; str; default = "#1b4721"; };
      green9 = mkOption { type = with types; str; default = "#113417"; };
      # Purple
      purple0 = mkOption { type = with types; str; default = "#eedcff"; };
      purple1 = mkOption { type = with types; str; default = "#dcbdfb"; };
      purple2 = mkOption { type = with types; str; default = "#dcbdfb"; };
      purple3 = mkOption { type = with types; str; default = "#b083f0"; };
      purple4 = mkOption { type = with types; str; default = "#986ee2"; };
      purple5 = mkOption { type = with types; str; default = "#8256d0"; };
      purple6 = mkOption { type = with types; str; default = "#6b44bc"; };
      purple7 = mkOption { type = with types; str; default = "#5936a2"; };
      purple8 = mkOption { type = with types; str; default = "#472c82"; };
      purple9 = mkOption { type = with types; str; default = "#352160"; };
      # Yellow
      yellow0 = mkOption { type = with types; str; default = "#fbe090"; };
      yellow1 = mkOption { type = with types; str; default = "#eac55f"; };
      yellow2 = mkOption { type = with types; str; default = "#daaa3f"; };
      yellow3 = mkOption { type = with types; str; default = "#c69026"; };
      yellow4 = mkOption { type = with types; str; default = "#ae7c14"; };
      yellow5 = mkOption { type = with types; str; default = "#966600"; };
      yellow6 = mkOption { type = with types; str; default = "#805400"; };
      yellow7 = mkOption { type = with types; str; default = "#6c4400"; };
      yellow8 = mkOption { type = with types; str; default = "#593600"; };
      yellow9 = mkOption { type = with types; str; default = "#452700"; };
      # Orange
      orange0 = mkOption { type = with types; str; default = "#ffddb0"; };
      orange1 = mkOption { type = with types; str; default = "#ffbc6f"; };
      orange2 = mkOption { type = with types; str; default = "#f69d50"; };
      orange3 = mkOption { type = with types; str; default = "#e0823d"; };
      orange4 = mkOption { type = with types; str; default = "#cc6b2c"; };
      orange5 = mkOption { type = with types; str; default = "#ae5622"; };
      orange6 = mkOption { type = with types; str; default = "#94471b"; };
      orange7 = mkOption { type = with types; str; default = "#7f3913"; };
      orange8 = mkOption { type = with types; str; default = "#682d0f"; };
      orange9 = mkOption { type = with types; str; default = "#4d210c"; };
      # Red
      red0 = mkOption { type = with types; str; default = "#ffd8d3"; };
      red1 = mkOption { type = with types; str; default = "#ffb8b0"; };
      red2 = mkOption { type = with types; str; default = "#ff938a"; };
      red3 = mkOption { type = with types; str; default = "#f47067"; };
      red4 = mkOption { type = with types; str; default = "#e5534b"; };
      red5 = mkOption { type = with types; str; default = "#c93c37"; };
      red6 = mkOption { type = with types; str; default = "#ad2e2c"; };
      red7 = mkOption { type = with types; str; default = "#922323"; };
      red8 = mkOption { type = with types; str; default = "#78191b"; };
      red9 = mkOption { type = with types; str; default = "#78191b"; };
      # Pink
      pink0 = mkOption { type = with types; str; default = "#ffd7eb"; };
      pink1 = mkOption { type = with types; str; default = "#ffb3d8"; };
      pink2 = mkOption { type = with types; str; default = "#fc8dc7"; };
      pink3 = mkOption { type = with types; str; default = "#e275ad"; };
      pink4 = mkOption { type = with types; str; default = "#c96198"; };
      pink5 = mkOption { type = with types; str; default = "#ae4c82"; };
      pink6 = mkOption { type = with types; str; default = "#983b6e"; };
      pink7 = mkOption { type = with types; str; default = "#7e325a"; };
      pink8 = mkOption { type = with types; str; default = "#69264a"; };
      pink9 = mkOption { type = with types; str; default = "#551639"; };
    };
  };
}

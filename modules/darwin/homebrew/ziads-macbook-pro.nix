{ ... }:
{
  # Only things unique to the MacBook Air go here.
  homebrew = {
    brews = [
    ];

    casks = [
      "spotify"
      "bruno"
      # "porting-kit"
      # "jasp"
      "zen"
      "positron"
      "clion"

      {
        name = "kanriapp/cask/kanri";
        trusted = true;
      }
    ];

    taps = [
    ];
  };
}

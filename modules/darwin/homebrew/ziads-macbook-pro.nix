{ ... }:
{
  # Only things unique to the MacBook Air go here.
  homebrew = {
    brews = [
      "qt" # for zeal
    ];

    casks = [
      "spotify"
      "bruno"
      # "porting-kit"
      # "jasp"
      "zen"
      "positron"
    ];
  };
}

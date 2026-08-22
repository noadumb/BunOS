{ pkgs, ... }:
{
  programs.vesktop = {
    enable = true;
    vencord = {
      useSystem = true;
      settings = {
        autoUpdate = true;
        autoUpdateNotification = false;
        useQuickCss = true;
        disableMinSize = true;
        themes = {
          "catppuccin" = ''
            /**
             * @name Discord Catppuccin
             * @author Catppuccin
             * @description 🎮 Soothing pastel theme for Discord
             * @website https://github.com/catppuccin/discord
            **/
            @import url("https://catppuccin.github.io/discord/dist/catppuccin-macchiato-mauve.theme.css") (prefers-color-scheme: dark);
            @import url("https://catppuccin.github.io/discord/dist/catppuccin-latte-mauve.theme.css") (prefers-color-scheme: light);
          '';
        };
        plugins = {
          AnonymiseFileNames = {
            enabled = true;
            anonymiseByDefault = false;
            method = 0;
            randomisedLength = 13;
          };
          AlwaysExpandRoles.enabled = true;
          BetterSessions.enabled = true;
          CallTimer.enabled = true;
          Dearrow.enabled = true;
          Decor.enabled = true;
          ForceOwnerCrown.enabled = true;
          FixYoutubeEmbeds.enabled = true;
          FixImagesQuality.enabled = true;
          FriendsSince.enabled = true;
          FullSearchContext.enabled = true;
          ImageZoom.enabled = true;
          MemberCount.enabled = true;
          MessageLogger = {
            enabled = true;
            ignoreSelf = true;
          };
          MessageLatency.enabled = true;
          ClearURLs.enabled = true;
          MentionAvatars.enabled = true;
          MutualGroupDMs.enabled = true;
          NewGuildSettings.enabled = true;
          NoF1.enabled = true;
          PermissionsViewer.enabled = true;
          RelationshipNotifier.enabled = true;
          ShikiCodeblocks = {
            enabled = true;
            theme = "Catppuccin Mocha";
          };
          ShowHiddenChannels.enabled = true;
          Showions.enabled = true;
          SilentTyping.enabled = true;
          Summaries.enabled = true;
          TypingIndicator.enabled = true;
          VolumeBooster.enabled = true;
          WhoReacted.enabled = true;
          YoutubeAdblock.enabled = true;
        };
      };
    };
  };

}

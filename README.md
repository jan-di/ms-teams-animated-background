# ms-teams-animated-background

As of writing this tool, Teams is capable of using Videos and animated images as video backgrounds, but does not allow users to add their own videos.
To circumentvent this limitation, you can convert a video to a GIF and add it manually using this tool.

## Requirements

- [ffmpeg](https://ffmpeg.org/)

## Usage

```
./convert-background.sh /path/to/videofile
```

# Locations

After converting, put all generated files to the background location, depending on your OS and Teams version:

## MacOS

```bash 
# Teams v2
$HOME/Library/Containers/com.microsoft.teams2/Data/Library/Application Support/Microsoft/MSTeams/Backgrounds/Uploads

# Teams v1 (Microsoft Teams classic)
$HOME/Library/Application Support/Microsoft/Teams/Backgrounds/Uploads
```
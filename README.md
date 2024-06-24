# ms-teams-animated-background

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
# ElementaryOS Notes

A couple of notes on getting the system setup like I wanted.

## Essentials

### Sublime

```
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update
sudo apt-get install sublime-text-installer
subl
```

### Steam

 ```
 sudo apt-get update && sudo apt-get install steam
 ```

### Misc Apps

```
sudo apt-get install cmus
sudo apt-get install screenfetch
sudo apt-get install mc
sudo apt-get install kdenlive
```

### Standard Linter

```
sudo npm install standard --global
```

## Theming

```
sudo apt-get install dconf-tools
dconf-editor
sudo add-apt-repository ppa:philip.scott/elementary-tweaks
sudo apt install elementary-tweaks
```

## Theme

```
#000000:#86dbc3:#945950:#ff0000:#666666:#9fcfba:#57c89d:#89E0B9:#777777:#91bda1:#945950:#789689:#a84c47:#e6d3b2:#a4dbcc:#ffffff
```

## Battery management

```
sudo powertop --auto-tune
```

## Node

```
sudo npm install npm@latest -g
sudo npm cache clean -f
sudo npm install -g n
sudo npm i -g npm
sudo n stable
```

## Youtube-dl

```
sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

youtube-dl -x --audio-format mp3 https://www.youtube.com/watch?v=sfIls6LMAGE
```

## EyeD3

```
pip install eyeD3
eyeD3 -a "Artist" -A "Album" -t "Track Title" song.mp3
eyeD3 song.mp3
```

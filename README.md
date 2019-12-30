# Linux Notes

A couple of notes on getting the system setup like I wanted.

## Essentials

### Micro

```
snap install micro --classic
sudo apt-get install xclip
```

#### Config Micro

```
micro ~/.config/micro/settings.json
```

```
{
  "color_scheme": "Packages/Theme/Tech49.tmTheme",
  "font_size": 9,
  "margin": 2,
  "tab_size": 2,
  "theme": "Adaptive.sublime-theme",
  "translate_tabs_to_spaces": true
}
```


### Fish

```
sudo apt-get install fish
chsh -s /usr/bin/fish
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
sudo apt-get install htop
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
| bg   | fg1   | fg2           | bglab |                
#000000:#51a196:#72dec2:#ffffff:#333333:#cccccc:#FF5950:#aaaaaa:#ff7777:#ffbda1:#ffbda1:#ffbda1:#ffbda1:#FF5950:#72dec2:#ffffff
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

## Wine

```
sudo apt install wine-stable
```

## Youtube-dl

```
sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

// Single
youtube-dl -x --audio-format mp3 https://www.youtube.com/watch?v=sfIls6LMAGE

// Playlist
youtube-dl --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s" 'https://www.youtube.com/watch?v=5KpK7yhDRXE&list=PLfGibfZATlGq4e4UsUiPLs3asiOqysjei'
```

## EyeD3

```
pip install eyeD3
eyeD3 -a "Artist" -A "Album" -t "Track Title" song.mp3
eyeD3 song.mp3
```

## Copy image to clipboard

```
xclip -selection clipboard -t image/png -i example.png
```

## Use a .deb File

```
sudo dpkg -i filename.deb
```

## unix

### Get cmus currently playing

```
cmus-remote -Q | grep tag | head -n 3 | cut -d ' ' -f 3- 
```

## c

- [clang docs](https://clang.llvm.org/docs/ClangFormat.html)
- [clang-format template](https://github.com/torvalds/linux/blob/master/.clang-format)

## Development

- [Getting Started](https://elementary.io/docs/code/getting-started#gtk-application)
- [Vala Tutorial](https://wiki.gnome.org/Projects/Vala/Tutorial)
- [Vala Examples](https://wiki.gnome.org/Projects/Vala/Examples)
- [Vala Docs](https://valadoc.org/gtk+-3.0/Gtk.Application)

# ElementaryOS Notes

A couple of notes on getting the system setup like I wanted.

## Essentials

### Olive

See [Flatpack](https://flathub.org/apps/details/org.olivevideoeditor.Olive)

```
sudo apt-get install software-properties-common
sudo apt-get update
sudo add-apt-repository ppa:olive-editor/olive-editor
sudo apt-get update
sudo apt-get install olive-editor
```

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

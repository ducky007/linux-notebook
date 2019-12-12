# ElementaryOS Notes

A couple of notes on getting the system setup like I wanted.

## Essentials

### Olive

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

### Misc Apps

```
sudo apt-get cmus
sudo apt-get screenfetch
```

### Standard Linter

```
sudo npm install standard --global
```

## Theming

```
sudo apt-get install dconf-tools
dconf-editor
```

## Theme

```
#444444:#72dec2:#ffffff:#FF5950:#333333:#b5b5b5:#FF5950:#222222:#ff7777:#ffbda1:#ffbda1:#ffbda1:#ffbda1:#FF5950:#72dec2:#ffffff
```

## Battery management

```
sudo powertop --auto-tune
```
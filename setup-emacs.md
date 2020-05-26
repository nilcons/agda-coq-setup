# Setting up Emacs for Agda and Coq

If you haven't used Emacs before, or just haven't used Emacs' package
archive [MELPA](https://melpa.org/), create a `~/.emacs` file or add
the following to it:

```
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)
```

Then run Emacs and install the `proof-general` package with `M-x package-install`
command.  This package is for interactive work with Coq.  Agda has its
own Emacs mode, you can add it to your Emacs config by running:

```
agda-mode setup
```

and restarting Emacs.

## Convenience packages

There is a ton of packages and config options that can make your life
in Emacs better.  I recommend to look around the package list with
`M-x list-packages`.  One particular package I recommend, is
`which-key`.  It shows you the possible keyboard commands once you type
the initial `C-c` (or any prefix of a key combo), making exploration
easier and learning faster.

## Testing

Open the example files from the `examples` directory of this repo and
check whether the appropriate Emacs modes are loaded and Emacs
integration is working.

For Agda: press `C-c C-l` and the window should split in two, with the
agda output in a small window at the bottom, and the file should be
syntax highlighted after the successful type check.

For Coq: press `C-c C-b` and the window should split in three (with
the Coq output in bottom right) and the whole file should be
progressively marked as checked.

# Installing Coq

The most convenient way to install the most recent version of Coq is
by using the OCaml Package Manager: [opam](https://opam.ocaml.org/).
You can probably install opam from your distro, on `apt` base distros
do:

```
sudo apt install build-essential m4 opam
```

Then:

```
opam init
opam pin add coq 8.11.1
```

`opam init` will add a line to your `~/.profile` to initialize `$PATH`
and other environment variables, but otherwise everything will be
installed under `~/.opam`.

Now relogin to have the environmet set up, or just issue `eval $(opam env)` and try it:

```
coqtop --version
# The Coq Proof Assistant, version 8.11.1 (May 2020)
# compiled on May 25 2020 12:00:00 with OCaml 4.10.0
```

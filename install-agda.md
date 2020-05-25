# Installing Agda

The easiest way to install Agda is by using the [Haskell Tool Stack](https://docs.haskellstack.org/en/stable/install_and_upgrade/).
I am going to assume that you already have it.

We are going to install everything in your home directory, under
`~/.agda` without interfering with your system.

```
mkdir -p ~/.agda
git clone --depth 1 -b v2.6.1 https://github.com/agda/agda.git ~/.agda/src
stack --stack-yaml ~/.agda/src/stack-8.8.3.yaml install -j2
stack --stack-yaml ~/.agda/src/stack-8.8.3.yaml clean
```

You can choose a different GHC version other than `8.8.3`, look at the
`stack-*.yaml` files in the checked out Agda source. The `stack` tool
installs binaries under `~/.local/bin`, you can move them to some
other directory that's included in your `$PATH`.  For example, I moved
them to `~/bin`:

```
mv ~/.local/bin/{agda,agda-mode,size-solver} ~/bin
```

Test it!

```
agda --version
# Agda version 2.6.1-8eb0d01
```

## Agda Standard Library

Download the version of Agda Standard Library that goes with the current Agda version:

```
git clone --depth 1 -b v1.3 https://github.com/agda/agda-stdlib.git ~/.agda/stdlib
```

And tell Agda where to find it:

```
echo $HOME/.agda/stdlib/standard-library.agda-lib > ~/.agda/libraries
```

That's it!
